import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var favoritePlaces: [Place] = []
    @Published var savedRoutes: [TripRoute] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let cityId: String
    private let dataService: DataServiceProtocol
    private let favoritesService: FavoritesService
    private let savedRoutesService: SavedRoutesService

    init(
        cityId: String,
        dataService: DataServiceProtocol? = nil,
        favoritesService: FavoritesService? = nil,
        savedRoutesService: SavedRoutesService? = nil
    ) {
        self.cityId = cityId
        self.dataService = dataService ?? MockDataService()
        self.favoritesService = favoritesService ?? FavoritesService()
        self.savedRoutesService = savedRoutesService ?? SavedRoutesService.shared
    }
    
    var hasActiveSearch: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var hasSearchResults: Bool {
        !filteredSavedRoutes.isEmpty || !filteredFavoritePlaces.isEmpty
    }
    
    var filteredSavedRoutes: [TripRoute] {
        let query = normalizedSearchText

        guard !query.isEmpty else {
            return savedRoutes
        }

        return savedRoutes.filter { route in
            routeSearchText(route).contains(query)
        }
    }
    
    var filteredFavoritePlaces: [Place] {
        let query = normalizedSearchText

        guard !query.isEmpty else {
            return favoritePlaces
        }

        return favoritePlaces.filter { place in
            placeSearchText(place).contains(query)
        }
    }

    func loadFavorites() async {
        isLoading = true
        errorMessage = nil

        do {
            let allPlaces = try await dataService.fetchPlaces(cityId: cityId)
            let favoriteIds = favoritesService.getFavoritePlaceIds()

            favoritePlaces = allPlaces.filter { place in
                favoriteIds.contains(place.id)
            }

            await refreshSavedRoutes()

            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func refreshFavorites() async {
        do {
            let allPlaces = try await dataService.fetchPlaces(cityId: cityId)
            let favoriteIds = favoritesService.getFavoritePlaceIds()

            favoritePlaces = allPlaces.filter { place in
                favoriteIds.contains(place.id)
            }

            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func refreshSavedRoutes() async {
        do {
            let allRoutes = try await dataService.fetchRoutes(userId: "user_001")
            let savedIds = savedRoutesService.savedRouteIds

            savedRoutes = allRoutes.filter { route in
                route.cityId == cityId && savedIds.contains(route.id)
            }

            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func refreshAllFavorites() async {
        await refreshFavorites()
        await refreshSavedRoutes()
    }

    func removeFavorite(_ place: Place) {
        favoritesService.removeFavorite(placeId: place.id)
        favoritePlaces.removeAll { $0.id == place.id }
    }

    func clearAllFavorites() {
        favoritesService.clearFavorites()
        favoritePlaces = []
    }
    
    func removeSavedRoute(_ route: TripRoute) {
        savedRoutesService.remove(routeId: route.id)
        savedRoutes.removeAll { $0.id == route.id }
    }
    
    private var normalizedSearchText: String {
        searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .localizedLowercase
    }

    private func routeSearchText(_ route: TripRoute) -> String {
        let stopText = route.stops
            .map { stop in
                [
                    stop.title,
                    stop.timeLabel ?? "",
                    stop.note ?? ""
                ]
                .joined(separator: " ")
            }
            .joined(separator: " ")

        return [
            route.title,
            route.date ?? "",
            route.durationType.rawValue,
            route.budget?.displayName ?? "",
            route.estimatedCostLevel?.displayName ?? "",
            route.transportType?.displayName ?? "",
            route.tempo?.displayName ?? "",
            route.companions ?? "",
            route.interests.joined(separator: " "),
            stopText
        ]
        .joined(separator: " ")
        .localizedLowercase
    }

    private func placeSearchText(_ place: Place) -> String {
        [
            place.name,
            place.category.displayName,
            place.subCategory ?? "",
            place.shortDescription,
            place.longDescription ?? "",
            place.district,
            place.address,
            place.tags.joined(separator: " ")
        ]
        .joined(separator: " ")
        .localizedLowercase
    }
}

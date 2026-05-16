import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var favoritePlaces: [Place] = []
    @Published var savedRoutes: [TripRoute] = []
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
}

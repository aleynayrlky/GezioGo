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
    private let authStatus: AppState.AuthStatus
    private let dataService: DataServiceProtocol
    private let firebaseFavoritesService: FirebaseFavoritesService
    private let firebaseSavedRoutesService: FirebaseSavedRoutesService
    private let authService: FirebaseAuthService

    init(
        cityId: String,
        authStatus: AppState.AuthStatus,
        dataService: DataServiceProtocol? = nil,
        firebaseFavoritesService: FirebaseFavoritesService = .shared,
        firebaseSavedRoutesService: FirebaseSavedRoutesService = .shared,
        authService: FirebaseAuthService = .shared
    ) {
        self.cityId = cityId
        self.authStatus = authStatus
        self.dataService = dataService ?? MockDataService()
        self.firebaseFavoritesService = firebaseFavoritesService
        self.firebaseSavedRoutesService = firebaseSavedRoutesService
        self.authService = authService
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
        guard authStatus == .authenticated else {
            favoritePlaces = []
            savedRoutes = []
            isLoading = false
            errorMessage = nil
            return
        }

        isLoading = true
        errorMessage = nil

        await refreshFavorites()
        await refreshSavedRoutes()

        isLoading = false
    }

    func refreshFavorites() async {
        guard authStatus == .authenticated else {
            favoritePlaces = []
            errorMessage = nil
            return
        }

        guard let userId = authService.userId else {
            favoritePlaces = []
            errorMessage = "Favorileri görüntülemek için giriş yapmalısın."
            return
        }

        do {
            let allPlaces = try await dataService.fetchPlaces(cityId: cityId)
            let favoriteIds = try await firebaseFavoritesService.fetchFavoritePlaceIds(userId: userId)

            favoritePlaces = allPlaces.filter { place in
                favoriteIds.contains(place.id)
            }

            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func refreshSavedRoutes() async {
        guard authStatus == .authenticated else {
            savedRoutes = []
            errorMessage = nil
            return
        }

        guard let userId = authService.userId else {
            savedRoutes = []
            errorMessage = "Kaydedilen rotaları görüntülemek için giriş yapmalısın."
            return
        }

        do {
            let routes = try await firebaseSavedRoutesService.fetchSavedRoutes(
                userId: userId
            )

            savedRoutes = routes.filter { route in
                route.cityId == cityId
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

    func removeFavorite(_ place: Place) async {
        guard authStatus == .authenticated else {
            return
        }

        guard let userId = authService.userId else {
            errorMessage = "Favorilerden çıkarmak için giriş yapmalısın."
            return
        }

        do {
            try await firebaseFavoritesService.removeFavoritePlace(
                userId: userId,
                placeId: place.id
            )

            favoritePlaces.removeAll { $0.id == place.id }
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func clearAllFavorites() async {
        guard authStatus == .authenticated else {
            favoritePlaces = []
            return
        }

        guard let userId = authService.userId else {
            errorMessage = "Favorileri temizlemek için giriş yapmalısın."
            return
        }

        do {
            for place in favoritePlaces {
                try await firebaseFavoritesService.removeFavoritePlace(
                    userId: userId,
                    placeId: place.id
                )
            }

            favoritePlaces = []
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func removeSavedRoute(_ route: TripRoute) async {
        guard authStatus == .authenticated else {
            return
        }

        guard let userId = authService.userId else {
            errorMessage = "Rotayı kaydedilenlerden çıkarmak için giriş yapmalısın."
            return
        }

        do {
            try await firebaseSavedRoutesService.removeSavedRoute(
                userId: userId,
                routeId: route.id
            )

            savedRoutes.removeAll { $0.id == route.id }
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
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

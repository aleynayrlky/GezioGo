import Foundation
import Combine

@MainActor
final class RoutesViewModel: ObservableObject {
    @Published var routes: [TripRoute] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var savedRouteIds: [String] = []

    private let cityId: String
    private let dataService: DataServiceProtocol
    private let savedRoutesService: SavedRoutesService

    init(
        cityId: String,
        dataService: DataServiceProtocol? = nil,
        savedRoutesService: SavedRoutesService = .shared
    ) {
        self.cityId = cityId
        self.dataService = dataService ?? MockDataService()
        self.savedRoutesService = savedRoutesService
        self.savedRouteIds = savedRoutesService.savedRouteIds
    }

    var featuredRoutes: [TripRoute] {
        routes
    }

    func loadRoutes() async {
        isLoading = true
        errorMessage = nil

        do {
            let allRoutes = try await dataService.fetchRoutes(userId: "user_001")
            routes = allRoutes.filter { $0.cityId == cityId }
            refreshSavedRoutes()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    func refreshSavedRoutes() {
        savedRouteIds = savedRoutesService.savedRouteIds
    }

    func isSaved(_ route: TripRoute) -> Bool {
        savedRouteIds.contains(route.id)
    }
}

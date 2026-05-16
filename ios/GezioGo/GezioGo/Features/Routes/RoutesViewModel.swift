import Foundation
import Combine

@MainActor
final class RoutesViewModel: ObservableObject {
    @Published var routes: [TripRoute] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let cityId: String
    private let dataService: DataServiceProtocol

    init(
        cityId: String,
        dataService: DataServiceProtocol? = nil
    ) {
        self.cityId = cityId
        self.dataService = dataService ?? MockDataService()
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
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

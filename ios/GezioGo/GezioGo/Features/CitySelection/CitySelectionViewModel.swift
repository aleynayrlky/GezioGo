import Foundation
import Combine

@MainActor
final class CitySelectionViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let dataService: DataServiceProtocol

    init(dataService: DataServiceProtocol? = nil) {
        self.dataService = dataService ?? MockDataService()
    }

    func loadCities() async {
        isLoading = true
        errorMessage = nil

        do {
            cities = try await dataService.fetchCities()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

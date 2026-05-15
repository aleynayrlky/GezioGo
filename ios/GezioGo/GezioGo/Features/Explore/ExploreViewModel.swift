import Foundation
import Combine

@MainActor
final class ExploreViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var selectedCategory: PlaceCategory?
    @Published var searchText: String = ""
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

    var categories: [PlaceCategory] {
        [.historical, .museum, .nature, .foodDrink, .family, .hiddenGem]
    }

    var filteredPlaces: [Place] {
        var result = places

        if let selectedCategory {
            result = result.filter { $0.category == selectedCategory }
        }

        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            return result
        }

        return result.filter { place in
            placeMatchesSearch(place, query: query)
        }
    }

    var hasActiveFilters: Bool {
        selectedCategory != nil || !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var emptyStateTitle: String {
        hasActiveFilters ? "Sonuç bulunamadı" : "Mekan bulunamadı"
    }

    var emptyStateMessage: String {
        if hasActiveFilters {
            return "Aramana veya seçtiğin kategoriye uygun mekan bulunamadı. Farklı bir kelime ya da kategori deneyebilirsin."
        } else {
            return "Bu şehir için henüz mekan eklenmemiş."
        }
    }

    func loadPlaces() async {
        isLoading = true
        errorMessage = nil

        do {
            places = try await dataService.fetchPlaces(cityId: cityId)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func selectCategory(_ category: PlaceCategory?) {
        selectedCategory = category
    }

    func clearFilters() {
        selectedCategory = nil
        searchText = ""
    }

    private func placeMatchesSearch(_ place: Place, query: String) -> Bool {
        let normalizedQuery = query.localizedLowercase

        let searchableText = [
            place.name,
            place.district,
            place.address,
            place.shortDescription,
            place.longDescription ?? "",
            place.category.displayName,
            place.subCategory ?? "",
            place.priceType.displayName,
            place.tags.joined(separator: " ")
        ]
        .joined(separator: " ")
        .localizedLowercase

        return searchableText.contains(normalizedQuery)
    }
}

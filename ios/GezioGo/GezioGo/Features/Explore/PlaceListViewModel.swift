import Foundation
import Combine

@MainActor
final class PlaceListViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let cityId: String
    let category: PlaceCategory?

    private let dataService: DataServiceProtocol

    init(
        cityId: String,
        category: PlaceCategory? = nil,
        dataService: DataServiceProtocol? = nil
    ) {
        self.cityId = cityId
        self.category = category
        self.dataService = dataService ?? MockDataService()
    }

    var filteredPlaces: [Place] {
        var result = places

        if let category {
            result = result.filter { $0.category == category }
        }

        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            return result
        }

        return result.filter { place in
            placeMatchesSearch(place, query: query)
        }
    }

    var screenTitle: String {
        category?.displayName ?? "Tüm Mekanlar"
    }

    var screenDescription: String {
        if let category {
            return "\(category.displayName) kategorisindeki önerilen mekanları keşfet."
        } else {
            return "Samsun’daki tüm önerilen mekanları keşfet."
        }
    }

    var hasActiveSearch: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var emptyStateTitle: String {
        hasActiveSearch ? "Sonuç bulunamadı" : "Mekan bulunamadı"
    }

    var emptyStateMessage: String {
        if hasActiveSearch {
            return "Aramana uygun mekan bulunamadı. Farklı bir kelime deneyebilirsin."
        } else {
            return "Bu kategoride henüz mekan bulunmuyor. Daha sonra tekrar kontrol edebilirsin."
        }
    }
    
    var resultsTitle: String {
        hasActiveSearch ? "Arama sonuçları" : "Sonuçlar"
    }
    
    func clearSearch() {
        searchText = ""
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

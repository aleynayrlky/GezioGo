import Foundation
import Combine

@MainActor
final class EventsViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var searchText: String = ""
    @Published var selectedCategory: EventCategory?
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

    var categories: [EventCategory] {
        EventCategory.allCases
    }

    var upcomingEvents: [Event] {
        var result = events

        if let selectedCategory {
            result = result.filter { $0.category == selectedCategory }
        }

        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            return result
        }

        return result.filter { event in
            eventMatchesSearch(event, query: query)
        }
    }

    var hasActiveFilters: Bool {
        selectedCategory != nil || !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var emptyStateTitle: String {
        hasActiveFilters ? "Sonuç bulunamadı" : "Etkinlik bulunamadı"
    }

    var emptyStateMessage: String {
        if hasActiveFilters {
            return "Aramana veya seçtiğin kategoriye uygun etkinlik bulunamadı. Farklı bir kelime ya da kategori deneyebilirsin."
        } else {
            return "Bu şehir için henüz etkinlik eklenmemiş. Daha sonra tekrar kontrol edebilirsin."
        }
    }

    var resultsTitle: String {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !query.isEmpty, let selectedCategory {
            return "\(selectedCategory.displayName) içinde arama"
        } else if !query.isEmpty {
            return "Arama sonuçları"
        } else if let selectedCategory {
            return selectedCategory.displayName
        } else {
            return "Yaklaşan etkinlikler"
        }
    }

    func loadEvents() async {
        isLoading = true
        errorMessage = nil

        do {
            events = try await dataService.fetchEvents(cityId: cityId)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func selectCategory(_ category: EventCategory?) {
        selectedCategory = category
    }

    func clearFilters() {
        selectedCategory = nil
        searchText = ""
    }

    private func eventMatchesSearch(_ event: Event, query: String) -> Bool {
        let normalizedQuery = query.localizedLowercase

        let searchableText = [
            event.title,
            event.description,
            event.venueName,
            event.address ?? "",
            event.district ?? "",
            event.category.displayName,
            event.priceType.displayName,
            event.organizer ?? "",
            event.tags.joined(separator: " ")
        ]
        .joined(separator: " ")
        .localizedLowercase

        return searchableText.contains(normalizedQuery)
    }
}

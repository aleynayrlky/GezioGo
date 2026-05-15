import Foundation
import Combine

@MainActor
final class EventsViewModel: ObservableObject {
    @Published var events: [Event] = []
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

    var upcomingEvents: [Event] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            return events
        }

        return events.filter { event in
            eventMatchesSearch(event, query: query)
        }
    }

    var hasActiveSearch: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var emptyStateTitle: String {
        hasActiveSearch ? "Sonuç bulunamadı" : "Etkinlik bulunamadı"
    }

    var emptyStateMessage: String {
        if hasActiveSearch {
            return "Aramana uygun etkinlik bulunamadı. Farklı bir kelime deneyebilirsin."
        } else {
            return "Bu şehir için henüz etkinlik eklenmemiş. Daha sonra tekrar kontrol edebilirsin."
        }
    }

    var resultsTitle: String {
        hasActiveSearch ? "Arama sonuçları" : "Yaklaşan etkinlikler"
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

    func clearSearch() {
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

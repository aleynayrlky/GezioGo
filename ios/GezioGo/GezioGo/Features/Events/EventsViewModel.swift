import Foundation
import Combine

enum EventQuickFilter: String, CaseIterable {
    case all
    case today
    case thisWeek
    case free

    var title: String {
        switch self {
        case .all:
            return "Tümü"
        case .today:
            return "Bugün"
        case .thisWeek:
            return "Bu Hafta"
        case .free:
            return "Ücretsiz"
        }
    }

    var iconName: String {
        switch self {
        case .all:
            return "square.grid.2x2"
        case .today:
            return "calendar"
        case .thisWeek:
            return "calendar.badge.clock"
        case .free:
            return "ticket"
        }
    }
}

@MainActor
final class EventsViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var selectedCategory: EventCategory?
    @Published var selectedQuickFilter: EventQuickFilter = .all
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

    var quickFilters: [EventQuickFilter] {
        EventQuickFilter.allCases
    }

    var categories: [EventCategory] {
        Array(Set(events.map { $0.category }))
            .sorted { $0.displayName < $1.displayName }
    }

    var upcomingEvents: [Event] {
        var result = events

        switch selectedQuickFilter {
        case .all:
            break

        case .today:
            result = result.filter { event in
                guard let date = eventDate(from: event.startDate) else {
                    return false
                }

                return Calendar.current.isDateInToday(date)
            }

        case .thisWeek:
            result = result.filter { event in
                guard let date = eventDate(from: event.startDate) else {
                    return false
                }

                let today = Calendar.current.startOfDay(for: Date())
                let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: today) ?? today

                return date >= today && date <= nextWeek
            }

        case .free:
            result = result.filter {
                $0.priceType == .free
            }
        }

        if let selectedCategory {
            result = result.filter { $0.category == selectedCategory }
        }

        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !query.isEmpty {
            result = result.filter { event in
                eventMatchesSearch(event, query: query)
            }
        }

        return result.sorted { lhs, rhs in
            let lhsDate = eventDate(from: lhs.startDate) ?? .distantFuture
            let rhsDate = eventDate(from: rhs.startDate) ?? .distantFuture

            return lhsDate < rhsDate
        }
    }

    var featuredEvent: Event? {
        upcomingEvents.first
    }

    var listEvents: [Event] {
        if upcomingEvents.count <= 1 {
            return upcomingEvents
        }

        return Array(upcomingEvents.dropFirst())
    }

    var hasActiveSearch: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var hasActiveFilters: Bool {
        selectedCategory != nil || selectedQuickFilter != .all || hasActiveSearch
    }

    var emptyStateTitle: String {
        hasActiveFilters ? "Sonuç bulunamadı" : "Etkinlik bulunamadı"
    }

    var emptyStateMessage: String {
        if hasActiveFilters {
            return "Aramana veya seçtiğin filtrelere uygun etkinlik bulunamadı."
        } else {
            return "Bu şehir için henüz yaklaşan etkinlik eklenmemiş."
        }
    }

    var resultsTitle: String {
        hasActiveFilters ? "Arama sonuçları" : "Yaklaşan etkinlikler"
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

    func selectQuickFilter(_ filter: EventQuickFilter) {
        selectedQuickFilter = filter
    }

    func clearFilters() {
        selectedCategory = nil
        selectedQuickFilter = .all
        searchText = ""
    }

    private func eventMatchesSearch(_ event: Event, query: String) -> Bool {
        let normalizedQuery = query.localizedLowercase

        let searchableText = [
            event.title,
            event.description,
            event.category.displayName,
            event.venueName,
            event.district ?? "",
            event.address ?? "",
            event.organizer ?? "",
            event.priceType.displayName,
            event.tags.joined(separator: " ")
        ]
        .joined(separator: " ")
        .localizedLowercase

        return searchableText.contains(normalizedQuery)
    }

    private func eventDate(from string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]

        if let date = formatter.date(from: string) {
            return date
        }

        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: string)
    }
}

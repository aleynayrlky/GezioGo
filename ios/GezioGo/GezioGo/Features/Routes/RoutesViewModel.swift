import Foundation
import Combine

@MainActor
final class RoutesViewModel: ObservableObject {
    @Published var routes: [TripRoute] = []
    @Published var savedRouteIds: [String] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

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
        filteredRoutes
    }

    var filteredRoutes: [TripRoute] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            return routes
        }

        return routes.filter { route in
            routeMatchesSearch(route, query: query)
        }
    }

    var hasActiveFilters: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var emptyStateTitle: String {
        hasActiveFilters ? "Sonuç bulunamadı" : "Rota bulunamadı"
    }

    var emptyStateMessage: String {
        if hasActiveFilters {
            return "Aramana uygun rota bulunamadı. Farklı bir kelime deneyebilirsin."
        } else {
            return "Bu şehir için henüz rota eklenmemiş. Daha sonra tekrar kontrol edebilirsin."
        }
    }

    var resultsTitle: String {
        hasActiveFilters ? "Arama sonuçları" : "Önerilen rotalar"
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

    func clearFilters() {
        searchText = ""
    }

    private func routeMatchesSearch(_ route: TripRoute, query: String) -> Bool {
        let normalizedQuery = query.localizedLowercase

        let stopSearchText = route.stops
            .map { stop in
                [
                    stop.title,
                    stop.timeLabel ?? "",
                    stop.note ?? ""
                ]
                .joined(separator: " ")
            }
            .joined(separator: " ")

        let searchableText = [
            route.title,
            route.date ?? "",
            durationTypeText(route.durationType),
            route.budget?.displayName ?? "",
            route.estimatedCostLevel?.displayName ?? "",
            route.transportType?.displayName ?? "",
            route.tempo?.displayName ?? "",
            route.companions ?? "",
            route.interests.map { interestDisplayName($0) }.joined(separator: " "),
            route.interests.joined(separator: " "),
            stopSearchText
        ]
        .joined(separator: " ")
        .localizedLowercase

        return searchableText.contains(normalizedQuery)
    }

    private func interestDisplayName(_ interest: String) -> String {
        switch interest {
        case "history":
            return "Tarih"
        case "nature":
            return "Doğa"
        case "food_drink":
            return "Yeme İçme"
        case "museum":
            return "Müze"
        case "family":
            return "Aile"
        case "culture":
            return "Kültür"
        default:
            return interest
        }
    }

    private func durationTypeText(_ durationType: RouteDurationType) -> String {
        switch durationType {
        case .halfDay:
            return "Yarım Gün"
        case .oneDay:
            return "1 Gün"
        case .twoDays:
            return "2 Gün"
        case .custom:
            return "Özel"
        }
    }
}

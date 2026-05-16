import Foundation
import Combine

@MainActor
final class RoutesViewModel: ObservableObject {
    @Published var routes: [TripRoute] = []
    @Published var savedRouteIds: [String] = []
    @Published var searchText: String = ""
    @Published var selectedInterest: String?
    @Published var selectedDurationType: RouteDurationType?
    @Published var selectedTransportType: TransportType?
    @Published var selectedTempo: TravelTempo?
    @Published var showSavedOnly = false
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
        var result = routes

        if let selectedInterest {
            result = result.filter { route in
                route.interests.contains(selectedInterest)
            }
        }

        if let selectedDurationType {
            result = result.filter { route in
                route.durationType == selectedDurationType
            }
        }

        if let selectedTransportType {
            result = result.filter { route in
                route.transportType == selectedTransportType
            }
        }

        if let selectedTempo {
            result = result.filter { route in
                route.tempo == selectedTempo
            }
        }

        if showSavedOnly {
            result = result.filter { route in
                savedRouteIds.contains(route.id)
            }
        }

        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            return result
        }

        return result.filter { route in
            routeMatchesSearch(route, query: query)
        }
    }

    var interestOptions: [String] {
        ["history", "nature", "museum", "food_drink", "family", "culture"]
    }

    var durationOptions: [RouteDurationType] {
        [.halfDay, .oneDay, .twoDays, .custom]
    }

    var transportOptions: [TransportType] {
        [.walking, .publicTransport, .car, .mixed]
    }

    var tempoOptions: [TravelTempo] {
        [.slow, .balanced, .intense]
    }

    var hasActiveFilters: Bool {
        selectedInterest != nil ||
        selectedDurationType != nil ||
        selectedTransportType != nil ||
        selectedTempo != nil ||
        showSavedOnly ||
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var emptyStateTitle: String {
        hasActiveFilters ? "Sonuç bulunamadı" : "Rota bulunamadı"
    }

    var emptyStateMessage: String {
        if hasActiveFilters {
            return "Aramana veya seçtiğin filtrelere uygun rota bulunamadı. Farklı bir kelime ya da filtre deneyebilirsin."
        } else {
            return "Bu şehir için henüz rota eklenmemiş. Daha sonra tekrar kontrol edebilirsin."
        }
    }

    var resultsTitle: String {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !query.isEmpty {
            return "Arama sonuçları"
        }

        if showSavedOnly {
            return "Kaydedilen rotalar"
        }

        if let selectedInterest {
            return interestDisplayName(selectedInterest)
        }

        if let selectedDurationType {
            return durationTypeText(selectedDurationType)
        }

        if let selectedTransportType {
            return selectedTransportType.displayName
        }

        if let selectedTempo {
            return selectedTempo.displayName
        }

        return "Önerilen rotalar"
    }
    
    var activeFilterSummary: String? {
        var filters: [String] = []

        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !query.isEmpty {
            filters.append("Arama: \(query)")
        }

        if let selectedInterest {
            filters.append(interestDisplayName(selectedInterest))
        }

        if let selectedDurationType {
            filters.append(durationTypeText(selectedDurationType))
        }

        if let selectedTransportType {
            filters.append(selectedTransportType.displayName)
        }

        if let selectedTempo {
            filters.append(selectedTempo.displayName)
        }

        if showSavedOnly {
            filters.append("Kaydedilenler")
        }

        guard !filters.isEmpty else {
            return nil
        }

        return filters.joined(separator: " • ")
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
        selectedInterest = nil
        selectedDurationType = nil
        selectedTransportType = nil
        selectedTempo = nil
        showSavedOnly = false
    }

    func selectInterest(_ interest: String?) {
        if selectedInterest == interest {
            selectedInterest = nil
        } else {
            selectedInterest = interest
        }
    }

    func selectDurationType(_ durationType: RouteDurationType?) {
        if selectedDurationType == durationType {
            selectedDurationType = nil
        } else {
            selectedDurationType = durationType
        }
    }

    func selectTransportType(_ transportType: TransportType?) {
        if selectedTransportType == transportType {
            selectedTransportType = nil
        } else {
            selectedTransportType = transportType
        }
    }

    func selectTempo(_ tempo: TravelTempo?) {
        if selectedTempo == tempo {
            selectedTempo = nil
        } else {
            selectedTempo = tempo
        }
    }

    func toggleSavedOnly() {
        showSavedOnly.toggle()
    }

    func interestDisplayName(_ interest: String) -> String {
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

    func durationTypeText(_ durationType: RouteDurationType) -> String {
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
}

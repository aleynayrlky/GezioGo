import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var city: City?
    @Published var places: [Place] = []
    @Published var events: [Event] = []
    @Published var routes: [TripRoute] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let cityId: String
    private let userDisplayName: String?
    private let dataService: DataServiceProtocol

    init(
        cityId: String,
        userDisplayName: String? = nil,
        dataService: DataServiceProtocol = MockDataService()
    ) {
        self.cityId = cityId
        self.userDisplayName = userDisplayName
        self.dataService = dataService
    }

    var cityName: String {
        city?.name ?? cityId.capitalized
    }

    var greetingTitle: String {
        let cleanedName = userDisplayName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if cleanedName.isEmpty {
            return "Merhaba, Gezgin!"
        }

        return "Merhaba, \(cleanedName)!"
    }

    var greetingSubtitle: String {
        "Bugün \(cityName)’da nereyi keşfetmek istersin?"
    }

    var featuredPlaces: [Place] {
        Array(places.prefix(6))
    }

    var recommendedPlaces: [Place] {
        Array(places.prefix(5))
    }

    var featuredEvents: [Event] {
        Array(events.prefix(2))
    }

    var dailyFeaturedPlace: Place? {
        guard !places.isEmpty else {
            return nil
        }

        let day = Calendar.current.ordinality(of: .day, in: .era, for: Date()) ?? 0
        let index = day % places.count

        return places[index]
    }

    func loadHomeData() async {
        isLoading = true
        errorMessage = nil

        do {
            let cities = try await dataService.fetchCities()
            city = cities.first { $0.id == cityId }
            places = try await dataService.fetchPlaces(cityId: cityId)
            events = try await dataService.fetchEvents(cityId: cityId)
            routes = try await dataService.fetchRoutes(cityId: cityId)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

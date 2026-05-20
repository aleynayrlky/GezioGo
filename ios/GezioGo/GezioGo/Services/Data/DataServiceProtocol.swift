import Foundation

protocol DataServiceProtocol {
    func fetchCities() async throws -> [City]
    func fetchPlaces(cityId: String) async throws -> [Place]
    func fetchEvents(cityId: String) async throws -> [Event]
    func fetchRoutes(userId: String) async throws -> [TripRoute]
    func fetchRoutes(cityId: String) async throws -> [TripRoute]
}

import Foundation

final class MockDataService: DataServiceProtocol {
    func fetchCities() async throws -> [City] {
        try JSONLoader.load("MockCities", as: [City].self)
    }

    func fetchPlaces(cityId: String) async throws -> [Place] {
        let places = try JSONLoader.load("MockPlaces", as: [Place].self)
        return places.filter {
            $0.cityId == cityId && $0.contentStatus == .published
        }
    }

    func fetchEvents(cityId: String) async throws -> [Event] {
        let events = try JSONLoader.load("MockEvents", as: [Event].self)
        return events.filter {
            $0.cityId == cityId && $0.contentStatus == .published
        }
    }

    func fetchRoutes(userId: String) async throws -> [TripRoute] {
        let routes = try JSONLoader.load("MockRoutes", as: [TripRoute].self)
        return routes.filter {
            $0.userId == userId
        }
    }
}//
//  MockDataService.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


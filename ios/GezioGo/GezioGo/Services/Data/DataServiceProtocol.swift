import Foundation

protocol DataServiceProtocol {
    func fetchCities() async throws -> [City]
    func fetchPlaces(cityId: String) async throws -> [Place]
    func fetchEvents(cityId: String) async throws -> [Event]
    func fetchRoutes(userId: String) async throws -> [TripRoute]
}//
//  DataServiceProtocol.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


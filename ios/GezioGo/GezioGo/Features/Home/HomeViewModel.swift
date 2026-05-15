import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var city: City?
    @Published var places: [Place] = []
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let cityId: String
    private let dataService: DataServiceProtocol

    init(
        cityId: String,
        dataService: DataServiceProtocol = MockDataService()
    ) {
        self.cityId = cityId
        self.dataService = dataService
    }

    func loadHomeData() async {
        isLoading = true
        errorMessage = nil

        do {
            let cities = try await dataService.fetchCities()
            city = cities.first { $0.id == cityId }
            places = try await dataService.fetchPlaces(cityId: cityId)
            events = try await dataService.fetchEvents(cityId: cityId)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}//
//  HomeViewModel.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


import Foundation
import Combine

@MainActor
final class EventsViewModel: ObservableObject {
    @Published var events: [Event] = []
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
        events
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
}//
//  EventsViewModel.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 16.05.2026.
//


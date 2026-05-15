import Foundation
import Combine

@MainActor
final class ExploreViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var selectedCategory: PlaceCategory?
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

    var categories: [PlaceCategory] {
        [.historical, .museum, .nature, .foodDrink, .family, .hiddenGem]
    }

    var filteredPlaces: [Place] {
        guard let selectedCategory else {
            return places
        }

        return places.filter { $0.category == selectedCategory }
    }

    func loadPlaces() async {
        isLoading = true
        errorMessage = nil

        do {
            places = try await dataService.fetchPlaces(cityId: cityId)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func selectCategory(_ category: PlaceCategory?) {
        selectedCategory = category
    }
}//
//  ExploreViewModel.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


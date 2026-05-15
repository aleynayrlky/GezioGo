import Foundation
import Combine

@MainActor
final class PlaceListViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let cityId: String
    let category: PlaceCategory?

    private let dataService: DataServiceProtocol

    init(
        cityId: String,
        category: PlaceCategory? = nil,
        dataService: DataServiceProtocol? = nil
    ) {
        self.cityId = cityId
        self.category = category
        self.dataService = dataService ?? MockDataService()
    }

    var filteredPlaces: [Place] {
        guard let category else {
            return places
        }

        return places.filter { $0.category == category }
    }

    var screenTitle: String {
        category?.displayName ?? "Tüm Mekanlar"
    }

    var screenDescription: String {
        if let category {
            return "\(category.displayName) kategorisindeki önerilen mekanları keşfet."
        } else {
            return "Samsun’daki tüm önerilen mekanları keşfet."
        }
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
}//
//  PlaceListViewModel.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


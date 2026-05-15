import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var favoritePlaces: [Place] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let cityId: String
    private let dataService: DataServiceProtocol
    private let favoritesService: FavoritesService

    init(
        cityId: String,
        dataService: DataServiceProtocol? = nil,
        favoritesService: FavoritesService = FavoritesService()
    ) {
        self.cityId = cityId
        self.dataService = dataService ?? MockDataService()
        self.favoritesService = favoritesService
    }

    func loadFavorites() async {
        isLoading = true
        errorMessage = nil

        do {
            let allPlaces = try await dataService.fetchPlaces(cityId: cityId)
            let favoriteIds = favoritesService.getFavoritePlaceIds()

            favoritePlaces = allPlaces.filter { place in
                favoriteIds.contains(place.id)
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func removeFavorite(_ place: Place) {
        favoritesService.removeFavorite(placeId: place.id)
        favoritePlaces.removeAll { $0.id == place.id }
    }
}//
//  FavoritesViewModel.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


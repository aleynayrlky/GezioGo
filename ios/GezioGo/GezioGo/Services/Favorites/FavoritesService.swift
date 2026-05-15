import Foundation

final class FavoritesService {
    private let favoritePlaceIdsKey = "favorite_place_ids"

    func getFavoritePlaceIds() -> [String] {
        UserDefaults.standard.stringArray(forKey: favoritePlaceIdsKey) ?? []
    }

    func isFavorite(placeId: String) -> Bool {
        getFavoritePlaceIds().contains(placeId)
    }

    func addFavorite(placeId: String) {
        var ids = getFavoritePlaceIds()

        guard !ids.contains(placeId) else {
            return
        }

        ids.append(placeId)
        UserDefaults.standard.set(ids, forKey: favoritePlaceIdsKey)
    }

    func removeFavorite(placeId: String) {
        let ids = getFavoritePlaceIds().filter { $0 != placeId }
        UserDefaults.standard.set(ids, forKey: favoritePlaceIdsKey)
    }

    func toggleFavorite(placeId: String) {
        if isFavorite(placeId: placeId) {
            removeFavorite(placeId: placeId)
        } else {
            addFavorite(placeId: placeId)
        }
    }
}//
//  FavoritesService.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


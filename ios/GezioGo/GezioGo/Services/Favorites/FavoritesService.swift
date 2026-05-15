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
        saveFavoritePlaceIds(ids)
    }

    func removeFavorite(placeId: String) {
        let ids = getFavoritePlaceIds().filter { $0 != placeId }
        saveFavoritePlaceIds(ids)
    }

    func toggleFavorite(placeId: String) {
        if isFavorite(placeId: placeId) {
            removeFavorite(placeId: placeId)
        } else {
            addFavorite(placeId: placeId)
        }
    }

    func clearFavorites() {
        saveFavoritePlaceIds([])
    }

    private func saveFavoritePlaceIds(_ ids: [String]) {
        UserDefaults.standard.set(ids, forKey: favoritePlaceIdsKey)
        NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
    }
}

extension Notification.Name {
    static let favoritesDidChange = Notification.Name("favoritesDidChange")
}

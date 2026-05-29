import Foundation
import FirebaseFirestore

final class FirebaseFavoritesService {
    static let shared = FirebaseFavoritesService()

    private let db = Firestore.firestore()

    private init() {}

    func fetchFavoritePlaceIds(userId: String) async throws -> [String] {
        let snapshot = try await db
            .collection("users")
            .document(userId)
            .collection("favoritePlaces")
            .getDocuments()

        return snapshot.documents.map { $0.documentID }
    }

    func isFavoritePlace(
        userId: String,
        placeId: String
    ) async throws -> Bool {
        let snapshot = try await db
            .collection("users")
            .document(userId)
            .collection("favoritePlaces")
            .document(placeId)
            .getDocument()

        return snapshot.exists
    }

    func addFavoritePlace(
        userId: String,
        place: Place
    ) async throws {
        let data: [String: Any] = [
            "placeId": place.id,
            "cityId": place.cityId,
            "name": place.name,
            "category": place.category.displayName,
            "district": place.district,
            "createdAt": Timestamp(date: Date())
        ]

        try await db
            .collection("users")
            .document(userId)
            .collection("favoritePlaces")
            .document(place.id)
            .setData(data, merge: true)

        NotificationCenter.default.post(
            name: .favoritesDidChange,
            object: nil
        )
    }

    func removeFavoritePlace(
        userId: String,
        placeId: String
    ) async throws {
        try await db
            .collection("users")
            .document(userId)
            .collection("favoritePlaces")
            .document(placeId)
            .delete()

        NotificationCenter.default.post(
            name: .favoritesDidChange,
            object: nil
        )
    }

    func toggleFavoritePlace(
        userId: String,
        place: Place
    ) async throws -> Bool {
        let isFavorite = try await isFavoritePlace(
            userId: userId,
            placeId: place.id
        )

        if isFavorite {
            try await removeFavoritePlace(
                userId: userId,
                placeId: place.id
            )
            return false
        } else {
            try await addFavoritePlace(
                userId: userId,
                place: place
            )
            return true
        }
    }
}

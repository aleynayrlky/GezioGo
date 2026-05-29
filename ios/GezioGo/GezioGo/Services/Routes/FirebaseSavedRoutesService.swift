import Foundation
import FirebaseFirestore

final class FirebaseSavedRoutesService {
    static let shared = FirebaseSavedRoutesService()

    private let db = Firestore.firestore()

    private init() {}

    func fetchSavedRouteIds(userId: String) async throws -> [String] {
        let snapshot = try await db
            .collection("users")
            .document(userId)
            .collection("savedRoutes")
            .getDocuments()

        return snapshot.documents.map { $0.documentID }
    }

    func isSavedRoute(
        userId: String,
        routeId: String
    ) async throws -> Bool {
        let snapshot = try await db
            .collection("users")
            .document(userId)
            .collection("savedRoutes")
            .document(routeId)
            .getDocument()

        return snapshot.exists
    }

    func addSavedRoute(
        userId: String,
        route: TripRoute
    ) async throws {
        var data: [String: Any] = [
            "routeId": route.id,
            "cityId": route.cityId,
            "title": route.title,
            "durationType": route.durationType.rawValue,
            "stopCount": route.stops.count,
            "createdAt": Timestamp(date: Date())
        ]

        if let date = route.date {
            data["date"] = date
        }

        if let totalDurationMinutes = route.totalDurationMinutes {
            data["totalDurationMinutes"] = totalDurationMinutes
        }

        if let totalDistanceKm = route.totalDistanceKm {
            data["totalDistanceKm"] = totalDistanceKm
        }

        try await db
            .collection("users")
            .document(userId)
            .collection("savedRoutes")
            .document(route.id)
            .setData(data, merge: true)

        NotificationCenter.default.post(
            name: .savedRoutesDidChange,
            object: nil
        )
    }

    func removeSavedRoute(
        userId: String,
        routeId: String
    ) async throws {
        try await db
            .collection("users")
            .document(userId)
            .collection("savedRoutes")
            .document(routeId)
            .delete()

        NotificationCenter.default.post(
            name: .savedRoutesDidChange,
            object: nil
        )
    }

    func toggleSavedRoute(
        userId: String,
        route: TripRoute
    ) async throws -> Bool {
        let isSaved = try await isSavedRoute(
            userId: userId,
            routeId: route.id
        )

        if isSaved {
            try await removeSavedRoute(
                userId: userId,
                routeId: route.id
            )

            return false
        } else {
            try await addSavedRoute(
                userId: userId,
                route: route
            )

            return true
        }
    }
}

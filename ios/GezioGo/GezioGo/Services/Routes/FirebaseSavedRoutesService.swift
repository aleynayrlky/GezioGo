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

    func fetchSavedRoutes(userId: String) async throws -> [TripRoute] {
        let snapshot = try await db
            .collection("users")
            .document(userId)
            .collection("savedRoutes")
            .getDocuments()

        return snapshot.documents
            .compactMap { document in
                tripRoute(
                    documentId: document.documentID,
                    data: document.data()
                )
            }
            .sorted { first, second in
                first.updatedAt > second.updatedAt
            }
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
        let now = Date()

        var data: [String: Any] = [
            "routeId": route.id,
            "userId": userId,
            "cityId": route.cityId,
            "title": route.title,
            "durationType": route.durationType.rawValue,
            "interests": route.interests,
            "stops": route.stops.map { stopData($0) },
            "stopCount": route.stops.count,
            "isSaved": true,
            "savedAt": Timestamp(date: now),
            "updatedAtTimestamp": Timestamp(date: now),
            "createdAt": route.createdAt,
            "updatedAt": isoDateTimeFormatter.string(from: now)
        ]

        if let date = route.date {
            data["date"] = date
        }

        if let budget = route.budget {
            data["budget"] = budget.rawValue
        }

        if let transportType = route.transportType {
            data["transportType"] = transportType.rawValue
        }

        if let companions = route.companions,
           !companions.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            data["companions"] = companions
        }

        if let tempo = route.tempo {
            data["tempo"] = tempo.rawValue
        }

        if let totalDurationMinutes = route.totalDurationMinutes {
            data["totalDurationMinutes"] = totalDurationMinutes
        }

        if let totalDistanceKm = route.totalDistanceKm {
            data["totalDistanceKm"] = totalDistanceKm
        }

        if let estimatedCostLevel = route.estimatedCostLevel {
            data["estimatedCostLevel"] = estimatedCostLevel.rawValue
        }

        if let aiPromptVersion = route.aiPromptVersion {
            data["aiPromptVersion"] = aiPromptVersion
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

    private func stopData(_ stop: RouteStop) -> [String: Any] {
        var data: [String: Any] = [
            "order": stop.order,
            "type": stop.type.rawValue,
            "title": stop.title
        ]

        if let placeId = stop.placeId {
            data["placeId"] = placeId
        }

        if let eventId = stop.eventId {
            data["eventId"] = eventId
        }

        if let timeLabel = stop.timeLabel {
            data["timeLabel"] = timeLabel
        }

        if let durationMinutes = stop.durationMinutes {
            data["durationMinutes"] = durationMinutes
        }

        if let note = stop.note {
            data["note"] = note
        }

        if let latitude = stop.latitude {
            data["latitude"] = latitude
        }

        if let longitude = stop.longitude {
            data["longitude"] = longitude
        }

        return data
    }

    private func tripRoute(
        documentId: String,
        data: [String: Any]
    ) -> TripRoute? {
        guard let cityId = data["cityId"] as? String,
              let title = data["title"] as? String,
              let durationTypeRawValue = data["durationType"] as? String,
              let durationType = RouteDurationType(rawValue: durationTypeRawValue) else {
            return nil
        }

        let routeId = (data["routeId"] as? String) ?? documentId
        let userId = data["userId"] as? String
        let date = data["date"] as? String

        let budget = (data["budget"] as? String).flatMap {
            BudgetLevel(rawValue: $0)
        }

        let interests = data["interests"] as? [String] ?? []

        let transportType = (data["transportType"] as? String).flatMap {
            TransportType(rawValue: $0)
        }

        let companions = data["companions"] as? String

        let tempo = (data["tempo"] as? String).flatMap {
            TravelTempo(rawValue: $0)
        }

        let stopsData = data["stops"] as? [[String: Any]] ?? []
        let stops = stopsData.compactMap { routeStop(data: $0) }

        let totalDurationMinutes = intValue(data["totalDurationMinutes"])
        let totalDistanceKm = doubleValue(data["totalDistanceKm"])

        let estimatedCostLevel = (data["estimatedCostLevel"] as? String).flatMap {
            BudgetLevel(rawValue: $0)
        }

        let aiPromptVersion = data["aiPromptVersion"] as? String

        let createdAt = (data["createdAt"] as? String) ?? ""
        let updatedAt = (data["updatedAt"] as? String) ?? createdAt

        return TripRoute(
            id: routeId,
            userId: userId,
            cityId: cityId,
            title: title,
            date: date,
            durationType: durationType,
            budget: budget,
            interests: interests,
            transportType: transportType,
            companions: companions,
            tempo: tempo,
            stops: stops,
            totalDurationMinutes: totalDurationMinutes,
            totalDistanceKm: totalDistanceKm,
            estimatedCostLevel: estimatedCostLevel,
            aiPromptVersion: aiPromptVersion,
            isSaved: true,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }

    private func routeStop(data: [String: Any]) -> RouteStop? {
        guard let order = intValue(data["order"]),
              let typeRawValue = data["type"] as? String,
              let type = RouteStopType(rawValue: typeRawValue),
              let title = data["title"] as? String else {
            return nil
        }

        return RouteStop(
            order: order,
            type: type,
            placeId: data["placeId"] as? String,
            eventId: data["eventId"] as? String,
            title: title,
            timeLabel: data["timeLabel"] as? String,
            durationMinutes: intValue(data["durationMinutes"]),
            note: data["note"] as? String,
            latitude: doubleValue(data["latitude"]),
            longitude: doubleValue(data["longitude"])
        )
    }

    private func intValue(_ value: Any?) -> Int? {
        if let int = value as? Int {
            return int
        }

        if let number = value as? NSNumber {
            return number.intValue
        }

        return nil
    }

    private func doubleValue(_ value: Any?) -> Double? {
        if let double = value as? Double {
            return double
        }

        if let number = value as? NSNumber {
            return number.doubleValue
        }

        return nil
    }

    private var isoDateTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
}

import Foundation
import FirebaseFirestore

enum ReviewTargetType: String, Codable, Hashable {
    case place
    case event
    case accommodation
    case restaurant
    case route

    var displayName: String {
        switch self {
        case .place:
            return "Mekan"
        case .event:
            return "Etkinlik"
        case .accommodation:
            return "Konaklama"
        case .restaurant:
            return "Restoran"
        case .route:
            return "Rota"
        }
    }
}

struct Review: Identifiable, Hashable {
    let id: String
    let targetId: String
    let targetTitle: String
    let targetType: ReviewTargetType
    let userId: String
    let displayName: String
    let rating: Int
    let comment: String
    let createdAt: Date
    let updatedAt: Date?

    var dateText: String {
        let calendar = Calendar.current

        if calendar.isDateInToday(updatedAt ?? createdAt) {
            return "Bugün"
        }

        if calendar.isDateInYesterday(updatedAt ?? createdAt) {
            return "Dün"
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "d MMM yyyy"

        return formatter.string(from: updatedAt ?? createdAt)
    }

    var isEdited: Bool {
        guard let updatedAt else {
            return false
        }

        return updatedAt.timeIntervalSince(createdAt) > 5
    }

    init?(
        id: String,
        data: [String: Any]
    ) {
        guard let targetId = data["targetId"] as? String,
              let targetTypeRawValue = data["targetType"] as? String,
              let targetType = ReviewTargetType(rawValue: targetTypeRawValue),
              let userId = data["userId"] as? String,
              let displayName = data["displayName"] as? String,
              let rating = data["rating"] as? Int,
              let comment = data["comment"] as? String else {
            return nil
        }

        let createdAtTimestamp = data["createdAt"] as? Timestamp
        let updatedAtTimestamp = data["updatedAt"] as? Timestamp

        self.id = id
        self.targetId = targetId
        self.targetTitle = data["targetTitle"] as? String ?? targetId
        self.targetType = targetType
        self.userId = userId
        self.displayName = displayName
        self.rating = rating
        self.comment = comment
        self.createdAt = createdAtTimestamp?.dateValue() ?? Date()
        self.updatedAt = updatedAtTimestamp?.dateValue()
    }
}

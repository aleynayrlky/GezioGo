import Foundation
import FirebaseFirestore

final class FirebaseReviewsService {
    static let shared = FirebaseReviewsService()

    private let db = Firestore.firestore()

    private init() {}

    func fetchReviews(
        targetId: String,
        targetType: ReviewTargetType
    ) async throws -> [Review] {
        let snapshot = try await db
            .collection("reviews")
            .whereField("targetId", isEqualTo: targetId)
            .whereField("targetType", isEqualTo: targetType.rawValue)
            .getDocuments()

        let reviews = snapshot.documents
            .compactMap { document in
                Review(
                    id: document.documentID,
                    data: document.data()
                )
            }
            .sorted { ($0.updatedAt ?? $0.createdAt) > ($1.updatedAt ?? $1.createdAt) }

        var seenUserIds = Set<String>()

        return reviews.filter { review in
            let wasInserted = seenUserIds.insert(review.userId).inserted
            return wasInserted
        }
    }

    func fetchReviews(
        userId: String
    ) async throws -> [Review] {
        let snapshot = try await db
            .collection("reviews")
            .whereField("userId", isEqualTo: userId)
            .getDocuments()

        return snapshot.documents
            .compactMap { document in
                Review(
                    id: document.documentID,
                    data: document.data()
                )
            }
            .sorted { ($0.updatedAt ?? $0.createdAt) > ($1.updatedAt ?? $1.createdAt) }
    }

    func addReview(
        targetId: String,
        targetTitle: String,
        targetType: ReviewTargetType,
        userId: String,
        displayName: String,
        rating: Int,
        comment: String
    ) async throws {
        let cleanedDisplayName = displayName
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let cleanedTargetTitle = targetTitle
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let cleanedComment = comment
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !cleanedComment.isEmpty else {
            return
        }

        let reviewId = reviewDocumentId(
            targetId: targetId,
            targetType: targetType,
            userId: userId
        )

        let document = db
            .collection("reviews")
            .document(reviewId)

        let snapshot = try await document.getDocument()

        var data: [String: Any] = [
            "id": reviewId,
            "targetId": targetId,
            "targetTitle": cleanedTargetTitle.isEmpty ? targetId : cleanedTargetTitle,
            "targetType": targetType.rawValue,
            "userId": userId,
            "displayName": cleanedDisplayName.isEmpty ? "Gezgin" : cleanedDisplayName,
            "rating": max(1, min(5, rating)),
            "comment": cleanedComment,
            "updatedAt": Timestamp(date: Date())
        ]

        if !snapshot.exists {
            data["createdAt"] = Timestamp(date: Date())
        }

        try await document.setData(data, merge: true)

        NotificationCenter.default.post(
            name: .reviewsDidChange,
            object: nil
        )
    }

    func deleteReview(
        reviewId: String
    ) async throws {
        try await db
            .collection("reviews")
            .document(reviewId)
            .delete()

        NotificationCenter.default.post(
            name: .reviewsDidChange,
            object: nil
        )
    }

    private func reviewDocumentId(
        targetId: String,
        targetType: ReviewTargetType,
        userId: String
    ) -> String {
        "\(targetType.rawValue)_\(targetId)_\(userId)"
    }
}

extension Notification.Name {
    static let reviewsDidChange = Notification.Name("reviewsDidChange")
}

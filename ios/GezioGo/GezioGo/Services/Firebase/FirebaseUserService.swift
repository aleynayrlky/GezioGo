import Foundation
import FirebaseFirestore

final class FirebaseUserService {
    static let shared = FirebaseUserService()

    private let db = Firestore.firestore()

    private init() {}

    func createOrUpdateUserProfile(
        userId: String,
        firstName: String? = nil,
        lastName: String? = nil,
        displayName: String?,
        email: String?,
        selectedCityId: String? = nil
    ) async throws {
        var data: [String: Any] = [
            "id": userId,
            "role": "user",
            "updatedAt": Timestamp(date: Date())
        ]

        if let firstName {
            let cleanedFirstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
            if !cleanedFirstName.isEmpty {
                data["firstName"] = cleanedFirstName
            }
        }

        if let lastName {
            let cleanedLastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
            if !cleanedLastName.isEmpty {
                data["lastName"] = cleanedLastName
            }
        }

        if let displayName {
            let cleanedDisplayName = displayName.trimmingCharacters(in: .whitespacesAndNewlines)
            if !cleanedDisplayName.isEmpty {
                data["displayName"] = cleanedDisplayName
            }
        }

        if let email {
            let cleanedEmail = email
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()

            if !cleanedEmail.isEmpty {
                data["email"] = cleanedEmail
            }
        }

        if let selectedCityId {
            let cleanedCityId = selectedCityId.trimmingCharacters(in: .whitespacesAndNewlines)

            if !cleanedCityId.isEmpty {
                data["selectedCityId"] = cleanedCityId
            }
        }

        let document = db.collection("users").document(userId)
        let snapshot = try await document.getDocument()

        if !snapshot.exists {
            data["createdAt"] = Timestamp(date: Date())
        }

        try await document.setData(data, merge: true)
    }

    func fetchUserProfile(userId: String) async throws -> [String: Any]? {
        let snapshot = try await db
            .collection("users")
            .document(userId)
            .getDocument()

        return snapshot.data()
    }

    func fetchSelectedCityId(userId: String) async throws -> String? {
        let snapshot = try await db
            .collection("users")
            .document(userId)
            .getDocument()

        return snapshot.data()?["selectedCityId"] as? String
    }

    func updateSelectedCity(
        userId: String,
        cityId: String
    ) async throws {
        try await db
            .collection("users")
            .document(userId)
            .setData(
                [
                    "selectedCityId": cityId,
                    "updatedAt": Timestamp(date: Date())
                ],
                merge: true
            )
    }
}

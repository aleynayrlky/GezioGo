import Foundation
import Combine
import FirebaseAuth

@MainActor
final class FirebaseAuthService: ObservableObject {
    static let shared = FirebaseAuthService()

    @Published private(set) var currentUser: User?
    @Published private(set) var isAuthenticated: Bool = false

    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?

    private init() {
        refreshCurrentUser()
        listenAuthState()
    }

    deinit {
        if let authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(authStateListenerHandle)
        }
    }

    func refreshCurrentUser() {
        let user = Auth.auth().currentUser
        currentUser = user
        isAuthenticated = user != nil
    }

    func listenAuthState() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.currentUser = user
                self?.isAuthenticated = user != nil
            }
        }
    }

    func signIn(
        email: String,
        password: String
    ) async throws {
        let cleanedEmail = email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        try await Auth.auth().signIn(
            withEmail: cleanedEmail,
            password: password
        )

        refreshCurrentUser()
    }

    func register(
        email: String,
        password: String,
        firstName: String,
        lastName: String
    ) async throws {
        let cleanedEmail = email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        let cleanedFirstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedLastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        let displayName = "\(cleanedFirstName) \(cleanedLastName)"
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let result = try await Auth.auth().createUser(
            withEmail: cleanedEmail,
            password: password
        )

        if !displayName.isEmpty {
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = displayName
            try await changeRequest.commitChanges()
        }

        refreshCurrentUser()
    }

    func signOut() throws {
        try Auth.auth().signOut()
        refreshCurrentUser()
    }

    var userId: String? {
        currentUser?.uid
    }

    var userEmail: String? {
        currentUser?.email
    }

    var userDisplayName: String? {
        currentUser?.displayName
    }
}

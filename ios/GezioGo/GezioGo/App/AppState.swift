import SwiftUI
import Combine
import FirebaseAuth

@MainActor
final class AppState: ObservableObject {
    @Published var hasSeenOnboarding: Bool
    @Published var selectedCityId: String?
    @Published var authStatus: AuthStatus
    @Published var userDisplayName: String?

    enum AuthStatus: String {
        case guest
        case authenticated
    }

    private enum Keys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
        static let selectedCityId = "selectedCityId"
        static let authStatus = "authStatus"
        static let userDisplayName = "userDisplayName"
    }

    private let authService = FirebaseAuthService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.hasSeenOnboarding = UserDefaults.standard.bool(forKey: Keys.hasSeenOnboarding)
        self.selectedCityId = UserDefaults.standard.string(forKey: Keys.selectedCityId)

        if authService.isAuthenticated {
            self.authStatus = .authenticated
            self.userDisplayName = authService.userDisplayName
            UserDefaults.standard.set(AuthStatus.authenticated.rawValue, forKey: Keys.authStatus)

            if let displayName = authService.userDisplayName,
               !displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                UserDefaults.standard.set(displayName, forKey: Keys.userDisplayName)
            }
        } else {
            self.authStatus = .guest
            self.userDisplayName = nil

            UserDefaults.standard.set(AuthStatus.guest.rawValue, forKey: Keys.authStatus)
            UserDefaults.standard.removeObject(forKey: Keys.userDisplayName)
        }

        observeFirebaseAuth()
    }

    private func observeFirebaseAuth() {
        authService.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self else { return }

                if let user {
                    self.authStatus = .authenticated
                    self.userDisplayName = user.displayName

                    UserDefaults.standard.set(AuthStatus.authenticated.rawValue, forKey: Keys.authStatus)

                    if let displayName = user.displayName,
                       !displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        UserDefaults.standard.set(displayName, forKey: Keys.userDisplayName)
                    }
                } else {
                    self.authStatus = .guest
                    self.userDisplayName = nil

                    UserDefaults.standard.set(AuthStatus.guest.rawValue, forKey: Keys.authStatus)
                    UserDefaults.standard.removeObject(forKey: Keys.userDisplayName)
                }
            }
            .store(in: &cancellables)
    }

    func completeOnboarding() {
        hasSeenOnboarding = true
        UserDefaults.standard.set(true, forKey: Keys.hasSeenOnboarding)
    }

    func continueAsGuest() {
        authStatus = .guest
        userDisplayName = nil

        UserDefaults.standard.set(AuthStatus.guest.rawValue, forKey: Keys.authStatus)
        UserDefaults.standard.removeObject(forKey: Keys.userDisplayName)
    }

    func completeLogin(displayName: String? = nil) {
        authStatus = .authenticated

        let resolvedDisplayName = displayName ?? authService.userDisplayName

        UserDefaults.standard.set(AuthStatus.authenticated.rawValue, forKey: Keys.authStatus)

        if let resolvedDisplayName,
           !resolvedDisplayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            userDisplayName = resolvedDisplayName
            UserDefaults.standard.set(resolvedDisplayName, forKey: Keys.userDisplayName)
        }
    }

    func completeRegister(displayName: String? = nil) {
        authStatus = .authenticated

        let resolvedDisplayName = displayName ?? authService.userDisplayName

        if let resolvedDisplayName,
           !resolvedDisplayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            userDisplayName = resolvedDisplayName
            UserDefaults.standard.set(resolvedDisplayName, forKey: Keys.userDisplayName)
        }

        UserDefaults.standard.set(AuthStatus.authenticated.rawValue, forKey: Keys.authStatus)
    }

    func logout() {
        do {
            try authService.signOut()
        } catch {
            print("Firebase çıkış hatası: \(error.localizedDescription)")
        }

        authStatus = .guest
        userDisplayName = nil

        UserDefaults.standard.set(AuthStatus.guest.rawValue, forKey: Keys.authStatus)
        UserDefaults.standard.removeObject(forKey: Keys.userDisplayName)
    }

    func ensureDefaultCityIfNeeded() {
        if selectedCityId == nil {
            selectedCityId = "samsun"
            UserDefaults.standard.set("samsun", forKey: Keys.selectedCityId)
        }
    }

    func loadUserCityOrSetDefault() async {
        guard let userId = authService.userId else {
            ensureDefaultCityIfNeeded()
            return
        }

        do {
            if let profile = try await FirebaseUserService.shared.fetchUserProfile(userId: userId) {
                applyUserProfile(profile)
            }

            if let firestoreCityId = try await FirebaseUserService.shared.fetchSelectedCityId(userId: userId),
               !firestoreCityId.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                selectedCityId = firestoreCityId
                UserDefaults.standard.set(firestoreCityId, forKey: Keys.selectedCityId)
            } else {
                ensureDefaultCityIfNeeded()

                if let selectedCityId {
                    try await FirebaseUserService.shared.updateSelectedCity(
                        userId: userId,
                        cityId: selectedCityId
                    )
                }
            }
        } catch {
            print("Kullanıcı profil/şehir bilgisi okunamadı: \(error.localizedDescription)")
            ensureDefaultCityIfNeeded()
        }
    }

    func selectCity(_ city: City) {
        selectedCityId = city.id
        UserDefaults.standard.set(city.id, forKey: Keys.selectedCityId)

        if let userId = authService.userId {
            Task {
                do {
                    try await FirebaseUserService.shared.updateSelectedCity(
                        userId: userId,
                        cityId: city.id
                    )
                } catch {
                    print("Seçili şehir Firestore'a yazılamadı: \(error.localizedDescription)")
                }
            }
        }
    }

    func resetCitySelection() {
        selectedCityId = nil
        UserDefaults.standard.removeObject(forKey: Keys.selectedCityId)
    }

    private func applyUserProfile(_ profile: [String: Any]) {
        let firstName = (profile["firstName"] as? String)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let lastName = (profile["lastName"] as? String)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let displayName = (profile["displayName"] as? String)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let resolvedDisplayName: String

        if !displayName.isEmpty {
            resolvedDisplayName = displayName
        } else {
            resolvedDisplayName = "\(firstName) \(lastName)"
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }

        if !resolvedDisplayName.isEmpty {
            userDisplayName = resolvedDisplayName
            UserDefaults.standard.set(resolvedDisplayName, forKey: Keys.userDisplayName)
        }
    }
}

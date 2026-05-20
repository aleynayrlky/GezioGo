import SwiftUI
import Combine

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

    init() {
        self.hasSeenOnboarding = UserDefaults.standard.bool(forKey: Keys.hasSeenOnboarding)
        self.selectedCityId = UserDefaults.standard.string(forKey: Keys.selectedCityId)

        let savedAuthStatus = UserDefaults.standard.string(forKey: Keys.authStatus)
        self.authStatus = AuthStatus(rawValue: savedAuthStatus ?? "") ?? .guest

        self.userDisplayName = UserDefaults.standard.string(forKey: Keys.userDisplayName)

        if self.authStatus == .guest {
            self.userDisplayName = nil
        }
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

        UserDefaults.standard.set(AuthStatus.authenticated.rawValue, forKey: Keys.authStatus)

        if let displayName,
           !displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            userDisplayName = displayName
            UserDefaults.standard.set(displayName, forKey: Keys.userDisplayName)
        }
    }

    func completeRegister(displayName: String) {
        let cleanedName = displayName.trimmingCharacters(in: .whitespacesAndNewlines)

        authStatus = .authenticated
        userDisplayName = cleanedName.isEmpty ? nil : cleanedName

        UserDefaults.standard.set(AuthStatus.authenticated.rawValue, forKey: Keys.authStatus)

        if !cleanedName.isEmpty {
            UserDefaults.standard.set(cleanedName, forKey: Keys.userDisplayName)
        }
    }

    func logout() {
        authStatus = .guest
        userDisplayName = nil

        UserDefaults.standard.set(AuthStatus.guest.rawValue, forKey: Keys.authStatus)
        UserDefaults.standard.removeObject(forKey: Keys.userDisplayName)
    }

    func selectCity(_ city: City) {
        selectedCityId = city.id
        UserDefaults.standard.set(city.id, forKey: Keys.selectedCityId)
    }

    func resetCitySelection() {
        selectedCityId = nil
        UserDefaults.standard.removeObject(forKey: Keys.selectedCityId)
    }
}

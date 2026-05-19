import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var hasSeenOnboarding: Bool
    @Published var selectedCityId: String?

    private enum Keys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
        static let selectedCityId = "selectedCityId"
    }

    init() {
        self.hasSeenOnboarding = UserDefaults.standard.bool(forKey: Keys.hasSeenOnboarding)
        self.selectedCityId = UserDefaults.standard.string(forKey: Keys.selectedCityId)
    }

    func completeOnboarding() {
        hasSeenOnboarding = true
        UserDefaults.standard.set(true, forKey: Keys.hasSeenOnboarding)
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

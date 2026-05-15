import SwiftUI

enum AppLaunchState {
    case splash
    case onboarding
    case citySelection
    case main
}

struct RootView: View {
    @StateObject private var appState = AppState()
    @State private var launchState: AppLaunchState = .splash

    var body: some View {
        Group {
            switch launchState {
            case .splash:
                SplashView {
                    withAnimation {
                        launchState = appState.hasSeenOnboarding ? .citySelection : .onboarding
                    }
                }

            case .onboarding:
                OnboardingView {
                    appState.hasSeenOnboarding = true
                    withAnimation {
                        launchState = .citySelection
                    }
                }

            case .citySelection:
                CitySelectionView { city in
                    appState.selectCity(city)
                    withAnimation {
                        launchState = .main
                    }
                }

            case .main:
                if let selectedCityId = appState.selectedCityId {
                    MainTabBarView(cityId: selectedCityId)
                } else {
                    CitySelectionView { city in
                        appState.selectCity(city)
                        withAnimation {
                            launchState = .main
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RootView()
}

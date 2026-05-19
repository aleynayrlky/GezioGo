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
                        if !appState.hasSeenOnboarding {
                            launchState = .onboarding
                        } else if appState.selectedCityId == nil {
                            launchState = .citySelection
                        } else {
                            launchState = .main
                        }
                    }
                }

            case .onboarding:
                OnboardingView {
                    appState.completeOnboarding()
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
                    MainTabBarView(
                        cityId: selectedCityId,
                        onChangeCity: {
                            appState.resetCitySelection()
                            withAnimation {
                                launchState = .citySelection
                            }
                        }
                    )
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

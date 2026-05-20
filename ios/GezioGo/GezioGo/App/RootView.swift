import SwiftUI

enum AppLaunchState {
    case splash
    case onboarding
    case citySelection
    case login
    case register
    case main
}

struct RootView: View {
    @StateObject private var appState = AppState()
    @State private var launchState: AppLaunchState = .splash

    var body: some View {
        Group {
            switch launchState {
            case .splash:
                SplashView(
                    onFinish: {
                        appState.continueAsGuest()
                        
                        withAnimation {
                            launchState = .citySelection
                        }
                    },
                    onAuthTap: {
                        withAnimation {
                            launchState = .login
                        }
                    }
                )

            case .onboarding:
                OnboardingView {
                    appState.completeOnboarding()
                    withAnimation {
                        launchState = .citySelection
                    }
                }

            case .login:
                LoginView(
                    onLoginSuccess: {
                        appState.completeLogin()

                        withAnimation {
                            launchState = .citySelection
                        }
                    },
                    onRegisterTap: {
                        withAnimation {
                            launchState = .register
                        }
                    },
                    onBack: {
                        withAnimation {
                            launchState = .splash
                        }
                    }
                )

            case .register:
                RegisterView(
                    onRegisterSuccess: {
                        appState.completeRegister(displayName: "Gezgin")
                        withAnimation {
                            launchState = .citySelection
                        }
                    },
                    onLoginTap: {
                        withAnimation {
                            launchState = .login
                        }
                    },
                    onBack: {
                        withAnimation {
                            launchState = .login
                        }
                    }
                )

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
                        authStatus: appState.authStatus,
                        userDisplayName: appState.userDisplayName,
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

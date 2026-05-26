import SwiftUI
import FirebaseAuth

enum AppLaunchState {
    case startupSplash
    case onboarding
    case welcome
    case citySelection
    case login
    case register
    case main
}

struct RootView: View {
    @StateObject private var appState = AppState()
    @State private var launchState: AppLaunchState = .startupSplash
    @State private var didDecideInitialScreen = false

    var body: some View {
        Group {
            switch launchState {
            case .startupSplash:
                StartupSplashView()
                    .task {
                        guard !didDecideInitialScreen else { return }
                        didDecideInitialScreen = true

                        try? await Task.sleep(nanoseconds: 2_500_000_000)

                        await decideInitialScreen()
                    }

            case .onboarding:
                OnboardingView {
                    appState.completeOnboarding()

                    withAnimation {
                        launchState = .welcome
                    }
                }

            case .welcome:
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

            case .citySelection:
                CitySelectionView { city in
                    appState.selectCity(city)

                    withAnimation {
                        launchState = .main
                    }
                }

            case .login:
                LoginView(
                    onLoginSuccess: {
                        let user = Auth.auth().currentUser

                        appState.completeLogin(
                            displayName: user?.displayName
                        )

                        Task {
                            await appState.loadUserCityOrSetDefault()

                            await MainActor.run {
                                withAnimation {
                                    launchState = .main
                                }
                            }
                        }
                    },
                    onRegisterTap: {
                        withAnimation {
                            launchState = .register
                        }
                    },
                    onBack: {
                        withAnimation {
                            launchState = .welcome
                        }
                    }
                )

            case .register:
                RegisterView(
                    onRegisterSuccess: {
                        let user = Auth.auth().currentUser

                        appState.completeRegister(
                            displayName: user?.displayName
                        )

                        appState.resetCitySelection()

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

            case .main:
                let selectedCityId = appState.selectedCityId ?? "samsun"

                MainTabBarView(
                    cityId: selectedCityId,
                    authStatus: appState.authStatus,
                    userDisplayName: appState.userDisplayName,
                    onChangeCity: {
                        appState.resetCitySelection()

                        withAnimation {
                            launchState = .citySelection
                        }
                    },
                    onLogout: {
                        appState.logout()

                        withAnimation {
                            launchState = .welcome
                        }
                    }
                )
            }
        }
    }

    @MainActor
    private func decideInitialScreen() async {
        FirebaseAuthService.shared.refreshCurrentUser()

        if let user = Auth.auth().currentUser {
            appState.completeLogin(
                displayName: user.displayName
            )

            await appState.loadUserCityOrSetDefault()

            withAnimation {
                launchState = .main
            }

            return
        }

        appState.continueAsGuest()

        withAnimation {
            if appState.hasSeenOnboarding {
                launchState = .welcome
            } else {
                launchState = .onboarding
            }
        }
    }
}

#Preview {
    RootView()
}

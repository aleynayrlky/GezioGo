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
    @State private var path: [AppRoute] = []

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
                    NavigationStack(path: $path) {
                        HomeView(cityId: selectedCityId)
                            .navigationDestination(for: AppRoute.self) { route in
                                switch route {
                                case .explore(let cityId):
                                    ExploreView(cityId: cityId)

                                case .placeList(let cityId, let category):
                                    PlaceListView(cityId: cityId, category: category)

                                case .placeDetail(let place):
                                    PlaceDetailView(place: place)
                                }
                            }
                    }
                    .environment(\.navigate) { route in
                        path.append(route)
                    }
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

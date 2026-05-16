import SwiftUI
import UIKit

struct MainTabBarView: View {
    let cityId: String

    @State private var selectedTab: MainTab = .home
    @State private var homePath: [AppRoute] = []
    @State private var explorePath: [AppRoute] = []
    @State private var mapPath: [AppRoute] = []
    @State private var favoritesPath: [AppRoute] = []
    @State private var profilePath: [AppRoute] = []

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $homePath) {
                HomeView(cityId: cityId)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
            }
            .environment(\.navigate) { route in
                homePath.append(route)
            }
            .tabItem {
                tabLabel(for: .home)
            }
            .tag(MainTab.home)

            NavigationStack(path: $explorePath) {
                ExploreView(cityId: cityId)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
            }
            .environment(\.navigate) { route in
                explorePath.append(route)
            }
            .tabItem {
                tabLabel(for: .explore)
            }
            .tag(MainTab.explore)

            NavigationStack(path: $mapPath) {
                MapExploreView(cityId: cityId)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
            }
            .environment(\.navigate) { route in
                mapPath.append(route)
            }
            .tabItem {
                tabLabel(for: .map)
            }
            .tag(MainTab.map)

            NavigationStack(path: $favoritesPath) {
                FavoritesView(cityId: cityId)
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
            }
            .environment(\.navigate) { route in
                favoritesPath.append(route)
            }
            .tabItem {
                tabLabel(for: .favorites)
            }
            .tag(MainTab.favorites)

            NavigationStack(path: $profilePath) {
                ProfileView(cityId: cityId)
            }
            .tabItem {
                tabLabel(for: .profile)
            }
            .tag(MainTab.profile)
        }
        .tint(AppColors.petrol)
        .onAppear {
            configureTabBarAppearance()
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .explore(let cityId):
            ExploreView(cityId: cityId)

        case .placeList(let cityId, let category):
            PlaceListView(cityId: cityId, category: category)

        case .placeDetail(let place):
            PlaceDetailView(place: place)

        case .events(let cityId):
            EventsView(cityId: cityId)

        case .eventDetail(let event):
            EventDetailView(event: event)

        case .routes(let cityId):
            RoutesView(cityId: cityId)

        case .routeDetail(let route):
            RouteDetailView(route: route)
        }
    }

    private func tabLabel(for tab: MainTab) -> some View {
        Label(
            tab.title,
            systemImage: selectedTab == tab ? tab.selectedIconName : tab.iconName
        )
    }

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(AppColors.cardBackground)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    MainTabBarView(cityId: "samsun")
}

import SwiftUI
import UIKit

struct MainTabBarView: View {
    let cityId: String

    @State private var selectedTab: MainTab = .home
    @State private var homePath: [AppRoute] = []
    @State private var explorePath: [AppRoute] = []
    @State private var mapPath: [AppRoute] = []
    @State private var favoritesPath: [AppRoute] = []

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

            temporaryTabView(
                title: "Profil",
                message: "Şehir tercihin, ayarlar ve hesap bilgilerin burada olacak.",
                iconName: "person.fill"
            )
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
        }
    }

    private func tabLabel(for tab: MainTab) -> some View {
        Label(
            tab.title,
            systemImage: selectedTab == tab ? tab.selectedIconName : tab.iconName
        )
    }

    private func temporaryTabView(
        title: String,
        message: String,
        iconName: String
    ) -> some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                ZStack {
                    Circle()
                        .fill(AppColors.cream)
                        .frame(width: 96, height: 96)

                    Image(systemName: iconName)
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                }

                VStack(spacing: AppSpacing.sm) {
                    Text(title)
                        .font(AppTypography.title)
                        .foregroundStyle(AppColors.textPrimary)

                    Text(message)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, AppSpacing.xl)
                }

                AppTag("Yakında", iconName: "clock")
            }
            .padding(AppSpacing.lg)
        }
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

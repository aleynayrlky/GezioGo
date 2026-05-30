import SwiftUI
import UIKit

struct MainTabBarView: View {
    let cityId: String
    let authStatus: AppState.AuthStatus
    let userDisplayName: String?
    var onChangeCity: (() -> Void)? = nil
    var onLogout: (() -> Void)? = nil
    var onAuthTap: (() -> Void)? = nil

    @State private var selectedTab: MainTab = .home
    @State private var homePath: [AppRoute] = []
    @State private var explorePath: [AppRoute] = []
    @State private var plannerPath: [AppRoute] = []
    @State private var favoritesPath: [AppRoute] = []
    @State private var profilePath: [AppRoute] = []

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationStack(path: $homePath) {
                    HomeView(
                        cityId: cityId,
                        userDisplayName: userDisplayName
                    )
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
                }
                .environment(\.navigate) { route in
                    homePath.append(route)
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
                .tag(MainTab.explore)

                NavigationStack(path: $plannerPath) {
                    AIPlannerView(cityId: cityId)
                        .navigationDestination(for: AppRoute.self) { route in
                            destination(for: route)
                        }
                }
                .environment(\.navigate) { route in
                    plannerPath.append(route)
                }
                .tag(MainTab.planner)

                NavigationStack(path: $favoritesPath) {
                    FavoritesView(
                        cityId: cityId,
                        authStatus: authStatus,
                        onAuthTap: onAuthTap
                    )
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
                }
                .environment(\.navigate) { route in
                    favoritesPath.append(route)
                }
                .tag(MainTab.favorites)

                NavigationStack(path: $profilePath) {
                    ProfileView(
                        cityId: cityId,
                        authStatus: authStatus,
                        userDisplayName: userDisplayName,
                        onChangeCity: onChangeCity,
                        onLogout: onLogout
                    )
                    .navigationDestination(for: AppRoute.self) { route in
                        destination(for: route)
                    }
                }
                .environment(\.navigate) { route in
                    profilePath.append(route)
                }
                .tag(MainTab.profile)
            }
            .toolbar(.hidden, for: .tabBar)
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(height: 56)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)

            customTabBar
                .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear {
            UITabBar.appearance().isHidden = true
            configureTabBarAppearance()
        }
        .onDisappear {
            UITabBar.appearance().isHidden = false
        }
    }

    private var customTabBar: some View {
        HStack(alignment: .center, spacing: 0) {
            tabBarItem(.home)
            tabBarItem(.explore)
            plannerTabButton
            tabBarItem(.favorites)
            tabBarItem(.profile)
        }
        .frame(height: 58)
        .padding(.horizontal, AppSpacing.sm)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(AppColors.cardBackground)
                .shadow(color: .black.opacity(0.10), radius: 14, x: 0, y: 6)
        )
        .padding(.horizontal, AppSpacing.md)
        .padding(.bottom, 4)
    }

    private func tabBarItem(_ tab: MainTab) -> some View {
        Button {
            selectTab(tab)
        } label: {
            VStack(spacing: 3) {
                Image(systemName: selectedTab == tab ? tab.selectedIconName : tab.iconName)
                    .font(.system(size: 18, weight: .semibold))

                Text(tab.title)
                    .font(.system(size: 9, weight: .medium))
                    .lineLimit(1)
            }
            .foregroundStyle(selectedTab == tab ? AppColors.petrol : AppColors.textSecondary)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
        }
        .buttonStyle(.plain)
    }

    private var plannerTabButton: some View {
        Button {
            selectTab(.planner)
        } label: {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(AppColors.cardBackground)
                        .frame(width: 62, height: 62)
                        .shadow(color: .black.opacity(0.10), radius: 10, x: 0, y: 5)

                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppColors.teal,
                                    AppColors.petrol
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 52, height: 52)

                    Image("gezioGoLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 42, height: 42)
                        .clipShape(Circle())
                }
                .offset(y: -20)

                Text("Planla")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundStyle(selectedTab == .planner ? AppColors.petrol : AppColors.textSecondary)
                    .offset(y: -15)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
        }
        .buttonStyle(.plain)
    }

    private func selectTab(_ tab: MainTab) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

        withAnimation(.spring(response: 0.28, dampingFraction: 0.82)) {
            selectedTab = tab
            resetNavigation(for: tab)
        }
    }

    private func resetNavigation(for tab: MainTab) {
        switch tab {
        case .home:
            homePath.removeAll()

        case .explore:
            explorePath.removeAll()

        case .planner:
            plannerPath.removeAll()

        case .favorites:
            favoritesPath.removeAll()

        case .profile:
            profilePath.removeAll()
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
            PlaceDetailView(
                place: place,
                authStatus: authStatus,
                userDisplayName: userDisplayName
            )

        case .events(let cityId):
            EventsView(cityId: cityId)

        case .eventDetail(let event):
            EventDetailView(event: event)

        case .routes(let cityId):
            RoutesView(cityId: cityId)

        case .routeDetail(let route):
            RouteDetailView(
                route: route,
                authStatus: authStatus
            )

        case .notifications:
            NotificationsView()

        case .accommodation(let cityId):
            AccommodationView(
                cityId: cityId,
                authStatus: authStatus
            )

        case .transportation(let cityId):
            TransportationView(cityId: cityId)

        case .mapExplore(let cityId):
            MapExploreView(cityId: cityId)

        case .myReviews:
            MyReviewsView(userDisplayName: userDisplayName)
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
    MainTabBarView(
        cityId: "samsun",
        authStatus: .authenticated,
        userDisplayName: "Aleyna Yerlikaya",
        onLogout: {},
        onAuthTap: {}
    )
}

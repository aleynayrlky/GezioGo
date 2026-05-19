import SwiftUI
import UIKit

struct MainTabBarView: View {
    let cityId: String

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
                    HomeView(cityId: cityId)
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
                    AIPlannerPlaceholderView(cityId: cityId)
                        .navigationDestination(for: AppRoute.self) { route in
                            destination(for: route)
                        }
                }
                .environment(\.navigate) { route in
                    plannerPath.append(route)
                }
                .tag(MainTab.planner)

                NavigationStack(path: $favoritesPath) {
                    FavoritesView(cityId: cityId)
                        .navigationDestination(for: AppRoute.self) { route in
                            destination(for: route)
                        }
                }
                .environment(\.navigate) { route in
                    favoritesPath.append(route)
                }
                .tag(MainTab.favorites)

                NavigationStack(path: $profilePath) {
                    ProfileView(cityId: cityId)
                }
                .tag(MainTab.profile)
            }
            .toolbar(.hidden, for: .tabBar)
            .onAppear {
                UITabBar.appearance().isHidden = true
            }
            .onDisappear {
                UITabBar.appearance().isHidden = false
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear
                    .frame(height: 56)
            }

            customTabBar
        }
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

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(AppColors.cardBackground)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

private struct AIPlannerPlaceholderView: View {
    let cityId: String

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                ZStack {
                    Circle()
                        .fill(AppColors.teal)
                        .frame(width: 72, height: 72)

                    Image(systemName: "wand.and.stars")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundStyle(.white)
                }

                VStack(spacing: AppSpacing.sm) {
                    Text("Planla")
                        .font(AppTypography.title)
                        .foregroundStyle(AppColors.textPrimary)

                    Text("Yapay zekâ ile sana özel gezi rotanı oluşturacağın alan burada olacak.")
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }

                AppTag("AI rota oluşturma yakında", iconName: "sparkles")
            }
            .padding(AppSpacing.lg)
        }
        .navigationTitle("Planla")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MainTabBarView(cityId: "samsun")
}

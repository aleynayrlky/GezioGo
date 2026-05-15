import SwiftUI

struct MainTabBarView: View {
    let cityId: String

    @State private var selectedTab: MainTab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(cityId: cityId)
                .tabItem {
                    tabLabel(for: .home)
                }
                .tag(MainTab.home)

            ExploreView(cityId: cityId)
                .tabItem {
                    tabLabel(for: .explore)
                }
                .tag(MainTab.explore)

            temporaryTabView(
                title: "Harita",
                message: "Yakındaki mekanları haritada görebileceğin ekran burada olacak.",
                iconName: "map.fill"
            )
            .tabItem {
                tabLabel(for: .map)
            }
            .tag(MainTab.map)

            temporaryTabView(
                title: "Favoriler",
                message: "Kaydettiğin mekanlar, etkinlikler ve rotalar burada görünecek.",
                iconName: "heart.fill"
            )
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
}//
//  MainTabBarView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


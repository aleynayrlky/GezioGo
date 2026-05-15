import SwiftUI

struct HomeView: View {
    let cityId: String

    @StateObject private var viewModel: HomeViewModel

    init(cityId: String) {
        self.cityId = cityId
        _viewModel = StateObject(
            wrappedValue: HomeViewModel(cityId: cityId)
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    headerView

                    if viewModel.isLoading {
                        ProgressView("Ana sayfa yükleniyor...")
                            .frame(maxWidth: .infinity)
                            .padding(.top, AppSpacing.xl)
                    } else if let errorMessage = viewModel.errorMessage {
                        AppCard {
                            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                                Text("Veriler yüklenemedi")
                                    .font(AppTypography.subtitle)
                                    .foregroundStyle(AppColors.error)

                                Text(errorMessage)
                                    .font(AppTypography.body)
                                    .foregroundStyle(AppColors.textSecondary)
                            }
                        }
                    } else {
                        HomeHeroCard(city: viewModel.city)

                        categorySection

                        placesSection

                        eventsSection
                    }
                }
                .padding(AppSpacing.lg)
            }
        }
        .task {
            await viewModel.loadHomeData()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text("GezioGo")
                .font(AppTypography.title)
                .foregroundStyle(AppColors.petrol)

            Text("Şehir seninle keşfedilir")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
        }
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Kategoriler")
                .font(AppTypography.subtitle)
                .foregroundStyle(AppColors.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.md) {
                    CategoryShortcutView(category: .historical)
                    CategoryShortcutView(category: .museum)
                    CategoryShortcutView(category: .nature)
                    CategoryShortcutView(category: .foodDrink)
                    CategoryShortcutView(category: .family)
                }
            }
        }
    }

    private var placesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Öne çıkan mekanlar")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.places.count) mekan")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            VStack(spacing: AppSpacing.md) {
                ForEach(viewModel.places.prefix(3)) { place in
                    FeaturedPlaceCard(place: place)
                }
            }
        }
    }

    private var eventsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Yaklaşan etkinlikler")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.events.count) etkinlik")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            AppCard {
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    ForEach(viewModel.events.prefix(2)) { event in
                        VStack(alignment: .leading, spacing: AppSpacing.xs) {
                            Text(event.title)
                                .font(AppTypography.bodyMedium)
                                .foregroundStyle(AppColors.textPrimary)

                            Text(event.venueName)
                                .font(AppTypography.caption)
                                .foregroundStyle(AppColors.textSecondary)

                            AppTag(event.category.displayName, iconName: "calendar")
                        }

                        if event.id != viewModel.events.prefix(2).last?.id {
                            Divider()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(cityId: "samsun")
}//
//  HomeView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


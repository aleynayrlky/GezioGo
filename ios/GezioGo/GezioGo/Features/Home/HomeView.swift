import SwiftUI

struct HomeView: View {
    let cityId: String

    @Environment(\.navigate) private var navigate
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
                        
                        AppButton(title: "Keşfetmeye Başla") {
                            navigate(.explore(cityId: cityId))
                        }

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
                    ForEach([PlaceCategory.historical, .museum, .nature, .foodDrink, .family], id: \.self) { category in
                        Button {
                            navigate(.placeList(cityId: cityId, category: category))
                        } label: {
                            CategoryShortcutView(category: category)
                        }
                        .buttonStyle(.plain)
                    }
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
                    Button {
                        navigate(.placeDetail(place: place))
                    } label: {
                        FeaturedPlaceCard(place: place)
                    }
                    .buttonStyle(.plain)
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

                Button("Tümünü Gör") {
                    navigate(.events(cityId: cityId))
                }
                .font(AppTypography.captionMedium)
                .foregroundStyle(AppColors.teal)
            }

            if viewModel.events.isEmpty {
                EmptyStateView(
                    title: "Etkinlik bulunamadı",
                    message: "Bu şehir için henüz etkinlik eklenmemiş.",
                    iconName: "calendar"
                )
            } else {
                AppCard {
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        ForEach(Array(viewModel.events.prefix(2).enumerated()), id: \.element.id) { index, event in
                            Button {
                                navigate(.eventDetail(event: event))
                            } label: {
                                HStack(alignment: .top, spacing: AppSpacing.md) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: AppRadius.medium)
                                            .fill(AppColors.cream)
                                            .frame(width: 44, height: 44)

                                        Image(systemName: event.category.iconName)
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundStyle(AppColors.petrol)
                                    }

                                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                        Text(event.title)
                                            .font(AppTypography.bodyMedium)
                                            .foregroundStyle(AppColors.textPrimary)
                                            .multilineTextAlignment(.leading)

                                        Text(event.venueName)
                                            .font(AppTypography.caption)
                                            .foregroundStyle(AppColors.textSecondary)
                                            .lineLimit(1)

                                        HStack(spacing: AppSpacing.xs) {
                                            AppTag(event.category.displayName, iconName: "calendar")
                                            AppTag(event.startDate.gezioFormattedDate, iconName: "clock")
                                        }
                                    }

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundStyle(AppColors.textSecondary)
                                        .padding(.top, AppSpacing.xs)
                                }
                            }
                            .buttonStyle(.plain)

                            if index != min(viewModel.events.count, 2) - 1 {
                                Divider()
                            }
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


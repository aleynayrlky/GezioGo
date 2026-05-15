//
//  ExploreView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//

import SwiftUI

struct ExploreView: View {
    let cityId: String

    @StateObject private var viewModel: ExploreViewModel

    init(cityId: String) {
        self.cityId = cityId
        _viewModel = StateObject(
            wrappedValue: ExploreViewModel(cityId: cityId)
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    headerView

                    categorySection

                    contentSection
                }
                .padding(AppSpacing.lg)
            }
        }
        .task {
            await viewModel.loadPlaces()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("Keşfet", iconName: "sparkles")

            Text("Samsun’da ne keşfetmek istersin?")
                .font(AppTypography.title)
                .foregroundStyle(AppColors.textPrimary)

            Text("Tarihi yerlerden sahile, müzelerden doğa rotalarına kadar şehirdeki önerileri incele.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Kategoriler")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Button("Tümü") {
                    withAnimation {
                        viewModel.selectCategory(nil)
                    }
                }
                .font(AppTypography.captionMedium)
                .foregroundStyle(AppColors.teal)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.md) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        CategoryCard(
                            category: category,
                            isSelected: viewModel.selectedCategory == category
                        ) {
                            withAnimation {
                                if viewModel.selectedCategory == category {
                                    viewModel.selectCategory(nil)
                                } else {
                                    viewModel.selectCategory(category)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, AppSpacing.xs)
            }
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            VStack(spacing: AppSpacing.md) {
                ProgressView()
                Text("Mekanlar yükleniyor...")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, AppSpacing.xl)

        } else if let errorMessage = viewModel.errorMessage {
            AppCard {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    Text("Bir sorun oluştu")
                        .font(AppTypography.subtitle)
                        .foregroundStyle(AppColors.error)

                    Text(errorMessage)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)

                    AppButton(title: "Tekrar Dene") {
                        Task {
                            await viewModel.loadPlaces()
                        }
                    }
                }
            }

        } else if viewModel.filteredPlaces.isEmpty {
            AppCard {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    Text("Mekan bulunamadı")
                        .font(AppTypography.subtitle)
                        .foregroundStyle(AppColors.textPrimary)

                    Text("Bu kategoride henüz mekan bulunmuyor. Tüm kategorileri görüntülemeyi deneyebilirsin.")
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)

                    AppButton(title: "Tümünü Göster", style: .secondary) {
                        withAnimation {
                            viewModel.selectCategory(nil)
                        }
                    }
                }
            }

        } else {
            placesSection
        }
    }

    private var placesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text(sectionTitle)
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.filteredPlaces.count) mekan")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            VStack(spacing: AppSpacing.md) {
                ForEach(viewModel.filteredPlaces) { place in
                    PlaceCard(place: place)
                }
            }
        }
    }

    private var sectionTitle: String {
        if let selectedCategory = viewModel.selectedCategory {
            return selectedCategory.displayName
        } else {
            return "Öne çıkan mekanlar"
        }
    }
}

#Preview {
    ExploreView(cityId: "samsun")
}

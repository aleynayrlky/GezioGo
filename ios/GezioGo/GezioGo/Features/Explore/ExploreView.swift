//
//  ExploreView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//

import SwiftUI

struct ExploreView: View {
    let cityId: String

    @Environment(\.navigate) private var navigate
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
                    
                    searchSection

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
    
    private var searchSection: some View {
        SearchBarView(
            text: $viewModel.searchText,
            placeholder: "Mekan, ilçe veya kategori ara"
        )
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
                        viewModel.clearFilters()
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
            LoadingView("Mekanlar yükleniyor...")
        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(message: errorMessage) {
                Task {
                    await viewModel.loadPlaces()
                }
            }
        } else if viewModel.filteredPlaces.isEmpty {
            EmptyStateView(
                title: viewModel.emptyStateTitle,
                message: viewModel.emptyStateMessage,
                iconName: "mappin.slash",
                buttonTitle: viewModel.hasActiveFilters ? "Filtreleri Temizle" : nil
            ) {
                withAnimation {
                    viewModel.clearFilters()
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
                    PlaceCard(place: place) {
                        navigate(.placeDetail(place: place))
                    }
                }
            }
        }
    }

    private var sectionTitle: String {
        let query = viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !query.isEmpty, let selectedCategory = viewModel.selectedCategory {
            return "\(selectedCategory.displayName) içinde arama"
        } else if !query.isEmpty {
            return "Arama sonuçları"
        } else if let selectedCategory = viewModel.selectedCategory {
            return selectedCategory.displayName
        } else {
            return "Öne çıkan mekanlar"
        }
    }
}

#Preview {
    ExploreView(cityId: "samsun")
}

import SwiftUI

struct FavoritesView: View {
    let cityId: String

    @Environment(\.navigate) private var navigate
    @StateObject private var viewModel: FavoritesViewModel

    init(cityId: String) {
        self.cityId = cityId
        _viewModel = StateObject(
            wrappedValue: FavoritesViewModel(cityId: cityId)
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    headerView

                    contentSection
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle("Favoriler")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadFavorites()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("Favoriler", iconName: "heart")

            Text("Kaydettiğin yerler")
                .font(AppTypography.title)
                .foregroundStyle(AppColors.textPrimary)

            Text("Gezmek istediğin mekanları favorilerine ekleyerek daha sonra hızlıca ulaşabilirsin.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            LoadingView("Favoriler yükleniyor...")

        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(message: errorMessage) {
                Task {
                    await viewModel.loadFavorites()
                }
            }

        } else if viewModel.favoritePlaces.isEmpty {
            emptyFavoritesView

        } else {
            favoritesList
        }
    }

    private var emptyFavoritesView: some View {
        EmptyStateView(
            title: "Henüz favorin yok",
            message: "Keşfet ekranından beğendiğin mekanları favorilerine ekleyebilirsin.",
            iconName: "heart",
            buttonTitle: "Keşfetmeye Git"
        ) {
            navigate(.explore(cityId: cityId))
        }
    }

    private var favoritesList: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Favori mekanların")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.favoritePlaces.count) mekan")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            VStack(spacing: AppSpacing.md) {
                ForEach(viewModel.favoritePlaces) { place in
                    PlaceCard(place: place) {
                        navigate(.placeDetail(place: place))
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            viewModel.removeFavorite(place)
                        } label: {
                            Label("Favorilerden çıkar", systemImage: "heart.slash")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView(cityId: "samsun")
    }
}//
//  FavoritesView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


import SwiftUI

struct PlaceListView: View {
    let cityId: String
    let category: PlaceCategory?

    @Environment(\.navigate) private var navigate
    @StateObject private var viewModel: PlaceListViewModel

    init(cityId: String, category: PlaceCategory? = nil) {
        self.cityId = cityId
        self.category = category
        _viewModel = StateObject(
            wrappedValue: PlaceListViewModel(
                cityId: cityId,
                category: category
            )
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
        .navigationTitle(viewModel.screenTitle)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadPlaces()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("Mekanlar", iconName: "mappin.and.ellipse")

            Text(viewModel.screenTitle)
                .font(AppTypography.title)
                .foregroundStyle(AppColors.textPrimary)

            Text(viewModel.screenDescription)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            loadingView
        } else if let errorMessage = viewModel.errorMessage {
            errorView(errorMessage)
        } else if viewModel.filteredPlaces.isEmpty {
            emptyView
        } else {
            placesList
        }
    }

    private var loadingView: some View {
        VStack(spacing: AppSpacing.md) {
            ProgressView()

            Text("Mekanlar yükleniyor...")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, AppSpacing.xl)
    }

    private func errorView(_ message: String) -> some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Bir sorun oluştu")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.error)

                Text(message)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)

                AppButton(title: "Tekrar Dene") {
                    Task {
                        await viewModel.loadPlaces()
                    }
                }
            }
        }
    }

    private var emptyView: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Mekan bulunamadı")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Text("Bu kategoride henüz mekan bulunmuyor. Daha sonra tekrar kontrol edebilirsin.")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
    }

    private var placesList: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Sonuçlar")
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
}

#Preview {
    NavigationStack {
        PlaceListView(cityId: "samsun", category: .museum)
    }
}

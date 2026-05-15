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
            LoadingView("Mekanlar yükleniyor...")
        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(message: errorMessage) {
                Task {
                    await viewModel.loadPlaces()
                }
            }
        } else if viewModel.filteredPlaces.isEmpty {
            EmptyStateView(
                title: "Mekan bulunamadı",
                message: "Bu kategoride henüz mekan bulunmuyor. Daha sonra tekrar kontrol edebilirsin.",
                iconName: "mappin.slash"
            )
        } else {
            placesList
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

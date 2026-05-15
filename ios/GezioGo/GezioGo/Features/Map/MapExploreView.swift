import SwiftUI
import MapKit

struct MapExploreView: View {
    let cityId: String

    @Environment(\.navigate) private var navigate
    @StateObject private var viewModel: MapExploreViewModel

    init(cityId: String) {
        self.cityId = cityId
        _viewModel = StateObject(
            wrappedValue: MapExploreViewModel(cityId: cityId)
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    headerView

                    mapSection

                    contentSection
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle("Harita")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadPlaces()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("Harita", iconName: "map")

            Text("Şehri haritada keşfet")
                .font(AppTypography.title)
                .foregroundStyle(AppColors.textPrimary)

            Text("Samsun’daki önerilen mekanları harita üzerinden incele. Pin seçimi ve detay kartı sonraki adımda eklenecek.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    private var mapSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Harita")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                AppTag("\(viewModel.visiblePlaces.count) mekan", iconName: "mappin.and.ellipse")
            }

            Map(coordinateRegion: $viewModel.region)
                .frame(height: 280)
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.xlarge))
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.xlarge)
                        .stroke(AppColors.border, lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)

            Text("Harita şu an Samsun merkezli açılıyor. Mekan pinleri bir sonraki gün eklenecek.")
                .font(AppTypography.caption)
                .foregroundStyle(AppColors.textSecondary)
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            LoadingView("Harita verileri yükleniyor...")

        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(message: errorMessage) {
                Task {
                    await viewModel.loadPlaces()
                }
            }

        } else if viewModel.visiblePlaces.isEmpty {
            EmptyStateView(
                title: "Mekan bulunamadı",
                message: "Haritada gösterecek mekan bulunamadı.",
                iconName: "map"
            )

        } else {
            placesSection
        }
    }

    private var placesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Haritada gösterilecek yerler")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.visiblePlaces.count) mekan")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            VStack(spacing: AppSpacing.md) {
                ForEach(viewModel.visiblePlaces) { place in
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
        MapExploreView(cityId: "samsun")
    }
}

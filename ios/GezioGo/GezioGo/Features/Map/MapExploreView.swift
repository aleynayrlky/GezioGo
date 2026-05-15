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

                    selectedPlaceSection

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

            Text("Samsun’daki önerilen mekanları harita üzerinde gör, pinlere dokunarak detaylarını incele.")
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

            Map(
                coordinateRegion: $viewModel.region,
                annotationItems: viewModel.visiblePlaces
            ) { place in
                MapAnnotation(
                    coordinate: CLLocationCoordinate2D(
                        latitude: place.latitude,
                        longitude: place.longitude
                    )
                ) {
                    Button {
                        withAnimation {
                            viewModel.selectPlace(place)
                        }
                    } label: {
                        VStack(spacing: 2) {
                            Image(systemName: selectedPinIcon(for: place))
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(selectedPinColor(for: place))

                            Text(place.name)
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(AppColors.textPrimary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(AppColors.cardBackground.opacity(0.92))
                                .clipShape(Capsule())
                                .lineLimit(1)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(height: 320)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.xlarge))
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.xlarge)
                    .stroke(AppColors.border, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)

            Text("Pinlere dokunarak seçili mekanı değiştirebilirsin.")
                .font(AppTypography.caption)
                .foregroundStyle(AppColors.textSecondary)
        }
    }

    @ViewBuilder
    private var selectedPlaceSection: some View {
        if let selectedPlace = viewModel.selectedPlace {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Seçili mekan")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                PlaceCard(place: selectedPlace) {
                    navigate(.placeDetail(place: selectedPlace))
                }
            }
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
                Text("Tüm harita mekanları")
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

    private func selectedPinIcon(for place: Place) -> String {
        viewModel.selectedPlace?.id == place.id ? "mappin.circle.fill" : "mappin.circle"
    }

    private func selectedPinColor(for place: Place) -> Color {
        viewModel.selectedPlace?.id == place.id ? AppColors.gold : AppColors.petrol
    }
}

#Preview {
    NavigationStack {
        MapExploreView(cityId: "samsun")
    }
}

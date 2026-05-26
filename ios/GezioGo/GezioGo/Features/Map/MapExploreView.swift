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
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    headerView

                    categoryFilterSection

                    mapSection

                    selectedPlaceSection

                    contentSection
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 120)
            }
        }
        .navigationTitle("Harita")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadPlaces()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 6) {
            AppTag("Harita", iconName: "map")

            Text("Şehri haritada keşfet")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Text("Kategori seç, haritadaki ilgili mekanları gör ve pinlere dokunarak detayları incele.")
                .font(.system(size: 12.5, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)
        }
    }

    private var categoryFilterSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                Text("Kategori")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                if viewModel.selectedCategory != nil {
                    Button {
                        withAnimation {
                            viewModel.selectCategory(nil)
                        }
                    } label: {
                        Text("Temizle")
                            .font(.system(size: 11.5, weight: .semibold))
                            .foregroundStyle(AppColors.teal)
                    }
                    .buttonStyle(.plain)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.sm) {
                    Button {
                        withAnimation {
                            viewModel.selectCategory(nil)
                        }
                    } label: {
                        filterChip(
                            title: "Tümü",
                            iconName: "square.grid.2x2",
                            count: viewModel.places.count,
                            isSelected: viewModel.selectedCategory == nil
                        )
                    }
                    .buttonStyle(.plain)

                    ForEach(viewModel.categories, id: \.self) { category in
                        Button {
                            withAnimation {
                                if viewModel.selectedCategory == category {
                                    viewModel.selectCategory(nil)
                                } else {
                                    viewModel.selectCategory(category)
                                }
                            }
                        } label: {
                            filterChip(
                                title: category.displayName,
                                iconName: category.iconName,
                                count: viewModel.places.filter { $0.category == category }.count,
                                isSelected: viewModel.selectedCategory == category
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private func filterChip(
        title: String,
        iconName: String,
        count: Int,
        isSelected: Bool
    ) -> some View {
        HStack(spacing: 6) {
            Image(systemName: iconName)
                .font(.system(size: 12, weight: .semibold))

            Text(title)
                .font(.system(size: 12, weight: .semibold))

            Text("\(count)")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(isSelected ? AppColors.petrol : AppColors.teal)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(isSelected ? AppColors.cardBackground : AppColors.cream)
                .clipShape(Capsule())
        }
        .foregroundStyle(isSelected ? .white : AppColors.petrol)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(isSelected ? AppColors.teal : AppColors.cardBackground)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(isSelected ? AppColors.teal : AppColors.border.opacity(0.65), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.04), radius: 7, x: 0, y: 3)
    }

    private var mapSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                Text("Harita")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
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
                        pinView(for: place)
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(height: 260)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(AppColors.border, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.075), radius: 10, x: 0, y: 5)

            Text("Pinlere dokunarak seçili mekanı değiştirebilirsin.")
                .font(.system(size: 11.5, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
        }
    }

    private func pinView(for place: Place) -> some View {
        let isSelected = viewModel.selectedPlace?.id == place.id

        return VStack(spacing: 2) {
            ZStack {
                Circle()
                    .fill(isSelected ? AppColors.gold : AppColors.cardBackground)
                    .frame(width: isSelected ? 34 : 28, height: isSelected ? 34 : 28)
                    .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: 2)

                Image(systemName: place.category.iconName)
                    .font(.system(size: isSelected ? 15 : 12, weight: .bold))
                    .foregroundStyle(isSelected ? .white : AppColors.petrol)
            }

            if isSelected {
                Text(place.name)
                    .font(.system(size: 9.5, weight: .bold))
                    .foregroundStyle(AppColors.textPrimary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(AppColors.cardBackground.opacity(0.95))
                    .clipShape(Capsule())
                    .lineLimit(1)
            }
        }
    }

    @ViewBuilder
    private var selectedPlaceSection: some View {
        if let selectedPlace = viewModel.selectedPlace {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                HStack {
                    Text("Seçili mekan")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)

                    Spacer()

                    Text(viewModel.selectedCategoryTitle)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(AppColors.teal)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 5)
                        .background(AppColors.cream)
                        .clipShape(Capsule())
                }

                selectedPlaceCard(selectedPlace)
            }
        }
    }

    private func selectedPlaceCard(_ place: Place) -> some View {
        Button {
            navigate(.placeDetail(place: place))
        } label: {
            HStack(spacing: AppSpacing.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppColors.teal,
                                    AppColors.petrol
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 64, height: 64)

                    Image(systemName: place.category.iconName)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(AppColors.gold)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(place.name)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(1)

                    HStack(spacing: 5) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 10, weight: .semibold))

                        Text(place.district)
                            .font(.system(size: 11, weight: .medium))
                            .lineLimit(1)
                    }
                    .foregroundStyle(AppColors.teal)

                    Text(place.shortDescription)
                        .font(.system(size: 10.5, weight: .regular))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(2)
                        .lineSpacing(1)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(AppColors.textSecondary)
            }
            .padding(12)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(.plain)
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
                message: "Seçili kategori için haritada gösterecek mekan bulunamadı.",
                iconName: "map"
            )

        } else {
            placesSection
        }
    }

    private var placesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                Text("Bu kategoride")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.visiblePlaces.count) mekan")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(AppColors.teal)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.sm) {
                    ForEach(viewModel.visiblePlaces) { place in
                        Button {
                            withAnimation {
                                viewModel.selectPlace(place)
                            }
                        } label: {
                            miniPlaceCard(place)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private func miniPlaceCard(_ place: Place) -> some View {
        let isSelected = viewModel.selectedPlace?.id == place.id

        return VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [
                                AppColors.teal,
                                AppColors.petrol
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 76)

                Image(systemName: place.category.iconName)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.18))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppColors.gold)
                        .padding(7)
                }
            }

            Text(place.name)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)
                .lineLimit(1)

            HStack(spacing: 4) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 9, weight: .semibold))

                Text(place.district)
                    .font(.system(size: 9.5, weight: .medium))
                    .lineLimit(1)
            }
            .foregroundStyle(AppColors.textSecondary)
        }
        .padding(9)
        .frame(width: 138)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(isSelected ? AppColors.gold.opacity(0.9) : .clear, lineWidth: 1.4)
        )
        .shadow(color: .black.opacity(0.045), radius: 7, x: 0, y: 3)
    }
}

#Preview {
    NavigationStack {
        MapExploreView(cityId: "samsun")
    }
}

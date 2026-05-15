import SwiftUI

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

                    mapPreviewSection

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

            Text("Samsun’daki önerilen mekanları konum odaklı incele. Gerçek harita entegrasyonu sonraki aşamada eklenecek.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    private var mapPreviewSection: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: AppRadius.xlarge)
                .fill(
                    LinearGradient(
                        colors: [
                            AppColors.teal.opacity(0.22),
                            AppColors.gold.opacity(0.20),
                            AppColors.cream
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 260)

            decorativeMapLines

            VStack(spacing: AppSpacing.md) {
                Image(systemName: "map.fill")
                    .font(.system(size: 54, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)

                Text("MapKit entegrasyonu yakında")
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.petrol)

                AppTag("\(viewModel.visiblePlaces.count) mekan", iconName: "mappin.and.ellipse")
            }
            .frame(maxWidth: .infinity, maxHeight: 260)

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text("Harita önizleme")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.petrol)

                Text("Şimdilik mock mekanlar listeleniyor.")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
            }
            .padding(AppSpacing.md)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
            .padding(AppSpacing.md)
        }
    }

    private var decorativeMapLines: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 40, y: 80))
                path.addCurve(
                    to: CGPoint(x: 280, y: 170),
                    control1: CGPoint(x: 110, y: 20),
                    control2: CGPoint(x: 190, y: 230)
                )
            }
            .stroke(AppColors.petrol.opacity(0.18), lineWidth: 4)

            Path { path in
                path.move(to: CGPoint(x: 20, y: 190))
                path.addCurve(
                    to: CGPoint(x: 330, y: 70),
                    control1: CGPoint(x: 120, y: 130),
                    control2: CGPoint(x: 220, y: 110)
                )
            }
            .stroke(AppColors.gold.opacity(0.22), lineWidth: 4)
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
}//
//  MapExploreView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


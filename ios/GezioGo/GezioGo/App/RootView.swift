import SwiftUI

struct RootView: View {
    @StateObject private var appState = AppState()

    private let sampleCity = City(
        id: "samsun",
        name: "Samsun",
        slug: "samsun",
        country: "Türkiye",
        region: "Karadeniz",
        shortDescription: "Karadeniz’in tarih, doğa ve sahil deneyimini bir arada sunan şehirlerinden biri.",
        longDescription: nil,
        coverImageUrl: nil,
        thumbnailUrl: nil,
        latitude: 41.2867,
        longitude: 36.33,
        popularCategoryIds: ["historical", "museum", "nature"],
        weatherRegionCode: "TR-55",
        isActive: true,
        createdAt: "2026-05-15T00:00:00+03:00",
        updatedAt: "2026-05-15T00:00:00+03:00"
    )

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                VStack(spacing: AppSpacing.xs) {
                    Text("GezioGo")
                        .font(AppTypography.largeTitle)
                        .foregroundStyle(AppColors.petrol)

                    Text("Şehir seninle keşfedilir")
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                }

                AppCard {
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text(sampleCity.name)
                            .font(AppTypography.subtitle)
                            .foregroundStyle(AppColors.textPrimary)

                        Text(sampleCity.shortDescription)
                            .font(AppTypography.body)
                            .foregroundStyle(AppColors.textSecondary)

                        HStack {
                            AppTag("Model Testi", iconName: "checkmark.seal")
                            AppTag(sampleCity.region, iconName: "map")
                        }
                    }
                }

                AppButton(title: "Devam Et") {
                    print("Selected city: \(sampleCity.id)")
                }
            }
            .padding(AppSpacing.lg)
        }
    }
}

#Preview {
    RootView()
}

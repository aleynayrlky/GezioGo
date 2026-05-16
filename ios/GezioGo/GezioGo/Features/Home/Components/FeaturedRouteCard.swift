import SwiftUI

struct FeaturedRouteCard: View {
    var body: some View {
        AppCard {
            HStack(alignment: .top, spacing: AppSpacing.md) {
                iconBox

                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text("Şehri hazır planlarla gez")
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(AppColors.textPrimary)
                        .multilineTextAlignment(.leading)

                    Text("Tarih, doğa ve sahil odaklı gezi rotalarını incele.")
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineSpacing(3)

                    HStack(spacing: AppSpacing.xs) {
                        AppTag("Rotalar", iconName: "map")
                        AppTag("AI rota yakında", iconName: "wand.and.stars")
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(AppColors.textSecondary)
                    .padding(.top, AppSpacing.xs)
            }
        }
    }

    private var iconBox: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppRadius.medium)
                .fill(
                    LinearGradient(
                        colors: [
                            AppColors.petrol,
                            AppColors.teal
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 52, height: 52)

            Image(systemName: "map.fill")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(AppColors.gold)
        }
    }
}

#Preview {
    FeaturedRouteCard()
        .padding()
        .background(AppColors.background)
}

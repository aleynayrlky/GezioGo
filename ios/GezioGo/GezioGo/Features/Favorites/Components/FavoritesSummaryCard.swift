import SwiftUI

struct FavoritesSummaryCard: View {
    let savedRoutesCount: Int
    let favoritePlacesCount: Int

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                header

                Divider()

                HStack(spacing: AppSpacing.md) {
                    summaryItem(
                        title: "Kayıtlı rota",
                        value: "\(savedRoutesCount)",
                        iconName: "bookmark.fill"
                    )

                    Divider()
                        .frame(height: 36)

                    summaryItem(
                        title: "Favori mekan",
                        value: "\(favoritePlacesCount)",
                        iconName: "heart.fill"
                    )
                }
            }
        }
    }

    private var header: some View {
        HStack(spacing: AppSpacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.medium)
                    .fill(AppColors.petrol)
                    .frame(width: 52, height: 52)

                Image(systemName: "heart.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(AppColors.gold)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text("Favorilerin")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Text("Kaydettiğin rota ve mekanlara buradan hızlıca ulaşabilirsin.")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(3)
            }

            Spacer()
        }
    }

    private func summaryItem(
        title: String,
        value: String,
        iconName: String
    ) -> some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: iconName)
                .font(.caption)
                .foregroundStyle(AppColors.teal)

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(value)
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)

                Text(title)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
            }

            Spacer()
        }
    }
}

#Preview {
    FavoritesSummaryCard(
        savedRoutesCount: 3,
        favoritePlacesCount: 2
    )
    .padding()
    .background(AppColors.background)
}

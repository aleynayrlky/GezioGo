import SwiftUI

struct RouteActionSection: View {
    let firstStop: RouteStop
    let isSaved: Bool
    let startRoute: () -> Void

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                header

                Divider()

                stopInfo

                startButton
            }
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text("Rota aksiyonları")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Text("Rotayı başlat, paylaş veya daha sonra tekrar incelemek için kaydet.")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
            }

            Spacer()

            if isSaved {
                AppTag("Kaydedildi", iconName: "bookmark.fill")
            }
        }
    }

    private var stopInfo: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.medium)
                    .fill(AppColors.petrol)
                    .frame(width: 52, height: 52)

                Image(systemName: "location.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(AppColors.gold)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text("Rotayı başlat")
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)

                Text("Apple Maps ile ilk uygun durağa yol tarifi al.")
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(2)

                Text("İlk durak: \(firstStop.title)")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
                    .lineLimit(2)

                if let timeLabel = firstStop.timeLabel {
                    AppTag(timeLabel, iconName: "clock")
                }
            }

            Spacer()
        }
    }

    private var startButton: some View {
        Button {
            startRoute()
        } label: {
            HStack {
                Image(systemName: "location.fill")
                    .font(.caption)

                Text("Rotayı Apple Maps’te başlat")
                    .font(AppTypography.captionMedium)

                Spacer()

                Image(systemName: "arrow.up.right")
                    .font(.caption)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, AppSpacing.md)
            .padding(.vertical, AppSpacing.sm)
            .background(AppColors.petrol)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
        }
        .buttonStyle(.plain)
    }
}



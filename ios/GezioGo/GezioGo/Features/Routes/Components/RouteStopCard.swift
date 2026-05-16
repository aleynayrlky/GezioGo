import SwiftUI

struct RouteStopCard: View {
    let stop: RouteStop
    let isSelected: Bool
    let stopTypeTitle: String
    let stopTypeIconName: String
    let actionTitle: String?
    let hasRelatedPlace: Bool
    let canOpenDirections: Bool
    var openDetail: (() -> Void)? = nil
    var openDirections: (() -> Void)? = nil

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                mainContent

                if actionTitle != nil || canOpenDirections {
                    Divider()

                    actionButtons
                }
            }
        }
    }

    private var mainContent: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            ZStack {
                Circle()
                    .fill(isSelected ? AppColors.gold : AppColors.petrol)
                    .frame(width: 38, height: 38)

                Text("\(stop.order)")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                tagRow

                Text(stop.title)
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)

                if let durationMinutes = stop.durationMinutes {
                    Text("\(durationMinutes) dk önerilir")
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.textSecondary)
                }

                if let note = stop.note {
                    Text(note)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineSpacing(3)
                }
            }

            Spacer()
        }
    }

    private var tagRow: some View {
        HStack {
            AppTag(
                stopTypeTitle,
                iconName: stopTypeIconName
            )

            if let timeLabel = stop.timeLabel {
                AppTag(timeLabel, iconName: "clock")
            }

            if isSelected {
                AppTag("Seçili", iconName: "checkmark")
            }

            if actionTitle != nil || canOpenDirections {
                AppTag("Aksiyon var", iconName: "arrow.up.right")
            }
        }
    }

    private var actionButtons: some View {
        VStack(spacing: AppSpacing.sm) {
            if let actionTitle {
                Button {
                    openDetail?()
                } label: {
                    HStack {
                        Image(systemName: hasRelatedPlace ? "mappin.and.ellipse" : "calendar")
                            .font(.caption)

                        Text(actionTitle)
                            .font(AppTypography.captionMedium)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.caption)
                    }
                    .foregroundStyle(AppColors.teal)
                }
                .buttonStyle(.plain)
            }

            if actionTitle != nil && canOpenDirections {
                Divider()
            }

            if canOpenDirections {
                Button {
                    openDirections?()
                } label: {
                    HStack {
                        Image(systemName: "location.fill")
                            .font(.caption)

                        Text("Yol tarifi al")
                            .font(AppTypography.captionMedium)

                        Spacer()

                        Image(systemName: "arrow.up.right")
                            .font(.caption)
                    }
                    .foregroundStyle(AppColors.petrol)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

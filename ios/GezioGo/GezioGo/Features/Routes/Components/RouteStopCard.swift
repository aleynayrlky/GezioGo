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
            orderBadge

            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                metaSection

                Text(stop.title)
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

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
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Spacer(minLength: 0)
        }
    }

    private var orderBadge: some View {
        ZStack {
            Circle()
                .fill(isSelected ? AppColors.gold : AppColors.petrol)
                .frame(width: 38, height: 38)

            Text("\(stop.order)")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.white)
        }
        .frame(width: 38, height: 38)
    }

    private var metaSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            HStack(spacing: AppSpacing.xs) {
                compactTag(
                    title: stopTypeTitle,
                    iconName: stopTypeIconName
                )

                if isSelected {
                    compactTag(
                        title: "Seçili",
                        iconName: "checkmark"
                    )
                }

                if actionTitle != nil || canOpenDirections {
                    compactTag(
                        title: "Detay",
                        iconName: "arrow.up.right"
                    )
                }
            }

            if let timeLabel = stop.timeLabel {
                compactTag(
                    title: timeLabel,
                    iconName: "clock"
                )
            }
        }
    }

    private func compactTag(
        title: String,
        iconName: String
    ) -> some View {
        HStack(spacing: 5) {
            Image(systemName: iconName)
                .font(.system(size: 11, weight: .semibold))

            Text(title)
                .font(.system(size: 11.5, weight: .semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.78)
        }
        .foregroundStyle(AppColors.petrol)
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(AppColors.cream)
        .clipShape(Capsule())
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
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)

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

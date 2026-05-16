import SwiftUI

struct SelectedRouteStopCard: View {
    let stop: RouteStop
    let relatedPlace: Place?
    let relatedEvent: Event?
    let stopTypeTitle: String
    let stopTypeIconName: String
    let actionTitle: String?
    var openDetail: (() -> Void)? = nil

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                topRow

                if let note = stop.note {
                    Text(note)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineSpacing(4)
                }

                if let durationMinutes = stop.durationMinutes {
                    AppTag("\(durationMinutes) dk önerilir", iconName: "clock")
                }

                if let actionTitle {
                    Divider()

                    Button {
                        openDetail?()
                    } label: {
                        HStack(spacing: AppSpacing.sm) {
                            Image(systemName: relatedPlace != nil ? "mappin.and.ellipse" : "calendar")
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
            }
        }
    }

    private var topRow: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            ZStack {
                Circle()
                    .fill(AppColors.gold)
                    .frame(width: 44, height: 44)

                Text("\(stop.order)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                HStack(spacing: AppSpacing.xs) {
                    AppTag(stopTypeTitle, iconName: stopTypeIconName)

                    if let timeLabel = stop.timeLabel {
                        AppTag(timeLabel, iconName: "clock")
                    }
                }

                Text(stop.title)
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)

                if let relatedPlace {
                    Text(relatedPlace.district)
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(1)
                } else if let relatedEvent {
                    Text(relatedEvent.venueName)
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(1)
                }
            }

            Spacer()
        }
    }
}



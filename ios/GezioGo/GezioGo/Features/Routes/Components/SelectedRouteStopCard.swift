import SwiftUI

struct SelectedRouteStopCard: View {
    let stop: RouteStop
    let relatedPlace: Place?
    let stopTypeTitle: String
    let stopTypeIconName: String
    var openPlaceDetail: (() -> Void)? = nil

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

                if relatedPlace != nil {
                    Divider()

                    Button {
                        openPlaceDetail?()
                    } label: {
                        HStack(spacing: AppSpacing.sm) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.caption)

                            Text("Mekan detayını aç")
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
                }
            }

            Spacer()
        }
    }
}



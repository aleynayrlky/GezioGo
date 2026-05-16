import SwiftUI

struct RouteCard: View {
    let route: TripRoute
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            AppCard {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    topRow

                    Text(descriptionText)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)

                    infoRow

                    tagRow
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(action == nil)
    }

    private var topRow: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            iconBox

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(route.title)
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)

                Text(route.interestsText)
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
                    .lineLimit(1)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, AppSpacing.xs)
        }
    }

    private var iconBox: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppRadius.medium)
                .fill(
                    LinearGradient(
                        colors: [
                            AppColors.cream,
                            AppColors.gold.opacity(0.18)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 56, height: 56)

            Image(systemName: "map")
                .font(.title3)
                .foregroundStyle(AppColors.petrol)
        }
    }

    private var infoRow: some View {
        HStack(spacing: AppSpacing.md) {
            infoItem(
                icon: "clock",
                text: durationText
            )

            infoItem(
                icon: "mappin.and.ellipse",
                text: "\(route.stops.count) durak"
            )

            if let transportType = route.transportType {
                infoItem(
                    icon: "figure.walk",
                    text: transportType.displayName
                )
            }
        }
    }

    private func infoItem(icon: String, text: String) -> some View {
        HStack(spacing: AppSpacing.xxs) {
            Image(systemName: icon)
                .font(.caption)

            Text(text)
                .font(AppTypography.caption)
                .lineLimit(1)
        }
        .foregroundStyle(AppColors.textSecondary)
    }

    private var tagRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.xs) {
                AppTag(durationTypeText, iconName: "calendar")

                if let tempo = route.tempo {
                    AppTag(tempo.displayName, iconName: "speedometer")
                }

                if let budget = route.estimatedCostLevel ?? route.budget {
                    AppTag(budget.displayName, iconName: "creditcard")
                }

                ForEach(route.interests.prefix(3), id: \.self) { interest in
                    AppTag(interest)
                }
            }
        }
    }

    private var descriptionText: String {
        let stopCount = route.stops.count
        let interests = route.interestsText

        if interests.isEmpty {
            return "\(stopCount) duraklı hazır gezi rotası. Samsun’u planlı ve pratik şekilde keşfetmek için hazırlandı."
        } else {
            return "\(stopCount) duraklı \(interests) odaklı hazır gezi rotası. Samsun’u planlı ve pratik şekilde keşfetmek için hazırlandı."
        }
    }

    private var durationText: String {
        guard let minutes = route.totalDurationMinutes else {
            return durationTypeText
        }

        if minutes < 60 {
            return "\(minutes) dk"
        } else if minutes == 60 {
            return "1 saat"
        } else {
            let hour = minutes / 60
            let remaining = minutes % 60

            if remaining == 0 {
                return "\(hour) saat"
            } else {
                return "\(hour)s \(remaining)dk"
            }
        }
    }

    private var durationTypeText: String {
        switch route.durationType {
        case .halfDay:
            return "Yarım Gün"
        case .oneDay:
            return "1 Gün"
        case .twoDays:
            return "2 Gün"
        case .custom:
            return "Özel"
        }
    }
}

private extension TripRoute {
    var interestsText: String {
        interests
            .prefix(2)
            .joined(separator: ", ")
    }
}

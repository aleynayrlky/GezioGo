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

                    summaryGrid

                    stopsPreview

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

                Text(route.interestsText.isEmpty ? "Hazır gezi rotası" : route.interestsText)
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
                            AppColors.petrol,
                            AppColors.teal
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 58, height: 58)

            Image(systemName: routeIconName)
                .font(.title3)
                .foregroundStyle(AppColors.gold)
        }
    }

    private var summaryGrid: some View {
        HStack(spacing: AppSpacing.sm) {
            summaryItem(
                iconName: "clock",
                title: "Süre",
                value: durationText
            )

            summaryItem(
                iconName: "mappin.and.ellipse",
                title: "Durak",
                value: "\(route.stops.count)"
            )

            summaryItem(
                iconName: "speedometer",
                title: "Tempo",
                value: route.tempo?.displayName ?? "Dengeli"
            )
        }
    }

    private func summaryItem(
        iconName: String,
        title: String,
        value: String
    ) -> some View {
        VStack(spacing: AppSpacing.xxs) {
            Image(systemName: iconName)
                .font(.caption)
                .foregroundStyle(AppColors.petrol)

            Text(value)
                .font(AppTypography.captionMedium)
                .foregroundStyle(AppColors.textPrimary)
                .lineLimit(1)

            Text(title)
                .font(AppTypography.caption)
                .foregroundStyle(AppColors.textSecondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.sm)
        .background(AppColors.cream.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
    }

    private var stopsPreview: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Duraklar")
                .font(AppTypography.captionMedium)
                .foregroundStyle(AppColors.textPrimary)

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                ForEach(route.stops.prefix(3)) { stop in
                    HStack(spacing: AppSpacing.sm) {
                        ZStack {
                            Circle()
                                .fill(AppColors.petrol)
                                .frame(width: 22, height: 22)

                            Text("\(stop.order)")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundStyle(.white)
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text(stop.title)
                                .font(AppTypography.captionMedium)
                                .foregroundStyle(AppColors.textPrimary)
                                .lineLimit(1)

                            if let timeLabel = stop.timeLabel {
                                Text(timeLabel)
                                    .font(AppTypography.caption)
                                    .foregroundStyle(AppColors.textSecondary)
                                    .lineLimit(1)
                            }
                        }

                        Spacer()
                    }
                }

                if route.stops.count > 3 {
                    Text("+\(route.stops.count - 3) durak daha")
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.teal)
                        .padding(.leading, 30)
                }
            }
        }
        .padding(AppSpacing.sm)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.large)
                .stroke(AppColors.textSecondary.opacity(0.12), lineWidth: 1)
        )
    }

    private var tagRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.xs) {
                AppTag(durationTypeText, iconName: "calendar")

                if let transportType = route.transportType {
                    AppTag(transportType.displayName, iconName: transportIconName)
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

    private var routeIconName: String {
        if route.interests.contains("history") {
            return "building.columns"
        } else if route.interests.contains("nature") {
            return "leaf"
        } else if route.interests.contains("food_drink") {
            return "fork.knife"
        } else {
            return "map"
        }
    }

    private var transportIconName: String {
        switch route.transportType {
        case .walking:
            return "figure.walk"
        case .publicTransport:
            return "tram"
        case .car:
            return "car"
        case .mixed:
            return "arrow.triangle.swap"
        case .none:
            return "map"
        }
    }
}

private extension TripRoute {
    var interestsText: String {
        interests
            .prefix(2)
            .map { interest in
                switch interest {
                case "history":
                    return "Tarih"
                case "nature":
                    return "Doğa"
                case "food_drink":
                    return "Yeme İçme"
                case "museum":
                    return "Müze"
                case "family":
                    return "Aile"
                default:
                    return interest
                }
            }
            .joined(separator: ", ")
    }
}

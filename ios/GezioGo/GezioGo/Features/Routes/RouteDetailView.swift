import SwiftUI

struct RouteDetailView: View {
    @StateObject private var viewModel: RouteDetailViewModel

    init(route: TripRoute) {
        _viewModel = StateObject(
            wrappedValue: RouteDetailViewModel(route: route)
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    heroSection

                    summarySection

                    interestsSection

                    stopsSection

                    notesSection
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle(viewModel.route.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.xlarge)
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
                    .frame(height: 220)

                VStack(spacing: AppSpacing.md) {
                    Image(systemName: "map.fill")
                        .font(.system(size: 56, weight: .semibold))
                        .foregroundStyle(AppColors.gold)

                    Text(viewModel.durationTypeText)
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(AppColors.cream)
                }
            }

            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                AppTag("Rota", iconName: "map")

                Text(viewModel.route.title)
                    .font(AppTypography.title)
                    .foregroundStyle(AppColors.textPrimary)

                Text(descriptionText)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(4)
            }
        }
    }

    private var summarySection: some View {
        AppCard {
            VStack(spacing: AppSpacing.md) {
                PlaceInfoRow(
                    iconName: "clock",
                    title: "Toplam Süre",
                    value: viewModel.durationText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "mappin.and.ellipse",
                    title: "Durak Sayısı",
                    value: "\(viewModel.sortedStops.count) durak"
                )

                Divider()

                PlaceInfoRow(
                    iconName: "point.topleft.down.curvedto.point.bottomright.up",
                    title: "Mesafe",
                    value: viewModel.distanceText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "figure.walk",
                    title: "Ulaşım",
                    value: viewModel.transportText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "speedometer",
                    title: "Tempo",
                    value: viewModel.tempoText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "creditcard",
                    title: "Tahmini Bütçe",
                    value: viewModel.budgetText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "person.2",
                    title: "Kimler İçin",
                    value: viewModel.companionText
                )
            }
        }
    }

    private var interestsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("İlgi alanları")
                .font(AppTypography.subtitle)
                .foregroundStyle(AppColors.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.xs) {
                    ForEach(viewModel.route.interests, id: \.self) { interest in
                        AppTag(
                            viewModel.interestDisplayName(interest),
                            iconName: "sparkles"
                        )
                    }
                }
            }
        }
    }

    private var stopsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Rota durakları")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.sortedStops.count) durak")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            VStack(spacing: AppSpacing.md) {
                ForEach(viewModel.sortedStops) { stop in
                    stopCard(stop)
                }
            }
        }
    }

    private func stopCard(_ stop: RouteStop) -> some View {
        AppCard {
            HStack(alignment: .top, spacing: AppSpacing.md) {
                VStack(spacing: AppSpacing.xs) {
                    ZStack {
                        Circle()
                            .fill(AppColors.petrol)
                            .frame(width: 34, height: 34)

                        Text("\(stop.order)")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                    }

                    Rectangle()
                        .fill(AppColors.textSecondary.opacity(0.18))
                        .frame(width: 2, height: 32)
                }

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    HStack {
                        AppTag(
                            viewModel.stopTypeText(stop.type),
                            iconName: viewModel.stopTypeIcon(stop.type)
                        )

                        if let timeLabel = stop.timeLabel {
                            AppTag(timeLabel, iconName: "clock")
                        }
                    }

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
    }

    private var notesSection: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Rota notu")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Text("Bu rota şimdilik mock veriyle hazırlanmıştır. İlerleyen aşamalarda AI destekli kişisel rota önerileri, konuma göre sıralama ve harita üzerinde rota görünümü eklenecek.")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(4)

                HStack(spacing: AppSpacing.xs) {
                    AppTag("AI rota yakında", iconName: "wand.and.stars")
                    AppTag("Harita desteği yakında", iconName: "map")
                }
            }
        }
    }

    private var descriptionText: String {
        let interests = viewModel.interestsText

        if interests.isEmpty {
            return "Samsun’u planlı ve pratik şekilde keşfetmek için hazırlanmış hazır gezi rotası."
        } else {
            return "\(interests) odaklı, Samsun’u planlı ve pratik şekilde keşfetmek için hazırlanmış hazır gezi rotası."
        }
    }
}

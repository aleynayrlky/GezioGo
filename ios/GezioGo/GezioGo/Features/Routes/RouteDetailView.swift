import SwiftUI

struct RouteDetailView: View {
    @Environment(\.navigate) private var navigate
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

                    routeActionSection

                    summarySection

                    mapSection

                    interestsSection

                    stopsSection

                    notesSection
                }
                .padding(AppSpacing.lg)
                .padding(.bottom, AppSpacing.xl)
            }
        }
        .navigationTitle(viewModel.route.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                ShareLink(
                    item: viewModel.shareText,
                    subject: Text(viewModel.shareTitle),
                    message: Text(viewModel.shareText)
                ) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(AppColors.petrol)
                }
                .accessibilityLabel("Rotayı paylaş")

                Button {
                    withAnimation {
                        viewModel.toggleSaved()
                    }
                } label: {
                    Image(systemName: viewModel.isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(viewModel.isSaved ? AppColors.gold : AppColors.petrol)
                }
                .accessibilityLabel(viewModel.isSaved ? "Rotayı kayıttan çıkar" : "Rotayı kaydet")
            }
        }
        .task {
            viewModel.refreshSavedState()
            await viewModel.loadPlaces()
        }
        .onReceive(NotificationCenter.default.publisher(for: .savedRoutesDidChange)) { _ in
            viewModel.refreshSavedState()
        }
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
                HStack(spacing: AppSpacing.xs) {
                    AppTag("Rota", iconName: "map")

                    if viewModel.isSaved {
                        AppTag("Kaydedildi", iconName: "bookmark.fill")
                    }
                }

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

    @ViewBuilder
    private var routeActionSection: some View {
        if let firstStop = viewModel.firstNavigableStop {
            RouteActionSection(
                firstStop: firstStop,
                isSaved: viewModel.isSaved
            ) {
                viewModel.startRoute()
            }
        }
    }

    private var summarySection: some View {
        RouteSummaryCard(
            durationText: viewModel.durationText,
            stopCountText: "\(viewModel.sortedStops.count) durak",
            distanceText: viewModel.distanceText,
            transportText: viewModel.transportText,
            tempoText: viewModel.tempoText,
            budgetText: viewModel.budgetText,
            companionText: viewModel.companionText
        )
    }

    private var mapSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Rota haritası")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.sortedStops.count) durak")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            RouteMapView(
                stops: viewModel.sortedStops,
                selectedStop: $viewModel.selectedStop
            )

            selectedStopSummary
        }
    }

    @ViewBuilder
    private var selectedStopSummary: some View {
        if let selectedStop = viewModel.selectedStop {
            let relatedPlace = viewModel.place(for: selectedStop)
            let relatedEvent = viewModel.event(for: selectedStop)

            SelectedRouteStopCard(
                stop: selectedStop,
                relatedPlace: relatedPlace,
                relatedEvent: relatedEvent,
                stopTypeTitle: viewModel.stopTypeText(selectedStop.type),
                stopTypeIconName: viewModel.stopTypeIcon(selectedStop.type),
                actionTitle: viewModel.actionTitle(for: selectedStop),
                canOpenDirections: viewModel.canOpenDirections(for: selectedStop),
                openDetail: {
                    if let relatedPlace {
                        navigate(.placeDetail(place: relatedPlace))
                    } else if let relatedEvent {
                        navigate(.eventDetail(event: relatedEvent))
                    }
                },
                openDirections: {
                    viewModel.openDirections(for: selectedStop)
                }
            )
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
                if viewModel.isLoadingPlaces {
                    LoadingView("Rota durakları hazırlanıyor...")
                }

                if let errorMessage = viewModel.placeLoadErrorMessage {
                    ErrorStateView(message: errorMessage) {
                        Task {
                            await viewModel.loadPlaces()
                        }
                    }
                }

                ForEach(viewModel.sortedStops) { stop in
                    Button {
                        withAnimation {
                            viewModel.selectedStop = stop
                        }
                    } label: {
                        stopCard(stop)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func stopCard(_ stop: RouteStop) -> some View {
        let relatedPlace = viewModel.place(for: stop)
        let relatedEvent = viewModel.event(for: stop)
        let actionTitle = viewModel.actionTitle(for: stop)
        let canOpenDirections = viewModel.canOpenDirections(for: stop)

        return RouteStopCard(
            stop: stop,
            isSelected: viewModel.selectedStop?.id == stop.id,
            stopTypeTitle: viewModel.stopTypeText(stop.type),
            stopTypeIconName: viewModel.stopTypeIcon(stop.type),
            actionTitle: actionTitle,
            hasRelatedPlace: relatedPlace != nil,
            canOpenDirections: canOpenDirections,
            openDetail: {
                if let relatedPlace {
                    navigate(.placeDetail(place: relatedPlace))
                } else if let relatedEvent {
                    navigate(.eventDetail(event: relatedEvent))
                }
            },
            openDirections: {
                viewModel.openDirections(for: stop)
            }
        )
    }

    private var notesSection: some View {
        RouteNotesCard()
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

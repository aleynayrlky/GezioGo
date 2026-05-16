import SwiftUI

struct FavoritesView: View {
    let cityId: String

    @Environment(\.navigate) private var navigate
    @StateObject private var viewModel: FavoritesViewModel

    init(cityId: String) {
        self.cityId = cityId
        _viewModel = StateObject(
            wrappedValue: FavoritesViewModel(cityId: cityId)
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    headerView

                    contentSection

                    savedRoutesSection
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle("Favoriler")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadFavorites()
            await viewModel.refreshSavedRoutes()
        }
        .onAppear {
            Task {
                await viewModel.refreshFavorites()
                await viewModel.refreshSavedRoutes()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .favoritesDidChange)) { _ in
            Task {
                await viewModel.refreshFavorites()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .savedRoutesDidChange)) { _ in
            Task {
                await viewModel.refreshSavedRoutes()
            }
        }
        .toolbar {
            if !viewModel.favoritePlaces.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.clearAllFavorites()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(AppColors.error)
                    }
                    .accessibilityLabel("Tüm favori mekanları temizle")
                }
            }
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("Favoriler", iconName: "heart")

            Text("Kaydettiğin yerler")
                .font(AppTypography.title)
                .foregroundStyle(AppColors.textPrimary)

            Text("Gezmek istediğin mekanları ve rotaları kaydederek daha sonra hızlıca ulaşabilirsin.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            LoadingView("Favoriler yükleniyor...")

        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(message: errorMessage) {
                Task {
                    await viewModel.loadFavorites()
                    await viewModel.refreshSavedRoutes()
                }
            }

        } else if viewModel.favoritePlaces.isEmpty {
            EmptyStateView(
                title: "Favori mekan yok",
                message: "Keşfet ekranından beğendiğin mekanları favorilerine ekleyebilirsin.",
                iconName: "heart",
                buttonTitle: "Keşfetmeye Git"
            ) {
                navigate(.explore(cityId: cityId))
            }

        } else {
            favoritesList
        }
    }

    @ViewBuilder
    private var savedRoutesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                    Text("Kaydedilen rotalar")
                        .font(AppTypography.subtitle)
                        .foregroundStyle(AppColors.textPrimary)

                    Text("Daha sonra incelemek istediğin gezi planları")
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.textSecondary)
                }

                Spacer()

                Text("\(viewModel.savedRoutes.count) rota")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            if viewModel.savedRoutes.isEmpty {
                EmptyStateView(
                    title: "Kaydedilen rota yok",
                    message: "Rota detay ekranından beğendiğin rotaları kaydedebilirsin.",
                    iconName: "bookmark"
                )
            } else {
                VStack(spacing: AppSpacing.md) {
                    ForEach(viewModel.savedRoutes) { route in
                        RouteCard(
                            route: route,
                            isSaved: true
                        ) {
                            navigate(.routeDetail(route: route))
                        }
                        .contextMenu {
                            ShareLink(
                                item: shareText(for: route),
                                subject: Text(shareTitle(for: route)),
                                message: Text(shareText(for: route))
                            ) {
                                Label("Rotayı paylaş", systemImage: "square.and.arrow.up")
                            }

                            Button(role: .destructive) {
                                viewModel.removeSavedRoute(route)
                            } label: {
                                Label("Kaydedilenlerden çıkar", systemImage: "bookmark.slash")
                            }
                        }
                    }
                }
            }
        }
    }

    private var emptyFavoritesView: some View {
        EmptyStateView(
            title: "Henüz favorin yok",
            message: "Keşfet ekranından beğendiğin mekanları favorilerine, rota detayından gezi planlarını kaydedebilirsin.",
            iconName: "heart",
            buttonTitle: "Keşfetmeye Git"
        ) {
            navigate(.explore(cityId: cityId))
        }
    }

    private var favoritesList: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Favori mekanların")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.favoritePlaces.count) mekan")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            VStack(spacing: AppSpacing.md) {
                ForEach(viewModel.favoritePlaces) { place in
                    PlaceCard(place: place, isFavorite: true) {
                        navigate(.placeDetail(place: place))
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            viewModel.removeFavorite(place)
                        } label: {
                            Label("Favorilerden çıkar", systemImage: "heart.slash")
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.removeFavorite(place)
                        } label: {
                            Label("Çıkar", systemImage: "heart.slash")
                        }
                    }
                }
            }
        }
    }
    
    private func shareTitle(for route: TripRoute) -> String {
        "GezioGo Rotası: \(route.title)"
    }

    private func shareText(for route: TripRoute) -> String {
        [
            shareTitle(for: route),
            "",
            shareSummaryText(for: route),
            "",
            shareStopsText(for: route),
            "",
            "Bu rota GezioGo ile hazırlandı. Şehri planlı ve keyifli şekilde keşfet."
        ]
        .filter { !$0.isEmpty }
        .joined(separator: "\n")
    }

    private func shareSummaryText(for route: TripRoute) -> String {
        var lines: [String] = []

        lines.append("Şehir: \(route.cityId.capitalized)")

        if let totalDurationMinutes = route.totalDurationMinutes {
            lines.append("Süre: \(durationText(totalDurationMinutes))")
        }

        lines.append("Rota tipi: \(durationTypeText(route.durationType))")

        if let transportType = route.transportType {
            lines.append("Ulaşım: \(transportType.displayName)")
        }

        if let tempo = route.tempo {
            lines.append("Tempo: \(tempo.displayName)")
        }

        if let budget = route.estimatedCostLevel ?? route.budget {
            lines.append("Tahmini bütçe: \(budget.displayName)")
        }

        if !route.interests.isEmpty {
            let interests = route.interests
                .map { interestDisplayName($0) }
                .joined(separator: ", ")

            lines.append("İlgi alanları: \(interests)")
        }

        return lines.joined(separator: "\n")
    }

    private func shareStopsText(for route: TripRoute) -> String {
        let sortedStops = route.stops.sorted { $0.order < $1.order }

        guard !sortedStops.isEmpty else {
            return "Durak bilgisi henüz eklenmemiş."
        }

        let stopLines = sortedStops.map { stop in
            if let timeLabel = stop.timeLabel {
                return "\(stop.order). \(stop.title) - \(timeLabel)"
            } else {
                return "\(stop.order). \(stop.title)"
            }
        }

        return """
        Duraklar:
        \(stopLines.joined(separator: "\n"))
        """
    }
    
    private func durationText(_ minutes: Int) -> String {
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

    private func durationTypeText(_ durationType: RouteDurationType) -> String {
        switch durationType {
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

    private func interestDisplayName(_ interest: String) -> String {
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
        case "culture":
            return "Kültür"
        default:
            return interest
        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView(cityId: "samsun")
    }
}

import SwiftUI

private enum FavoritesSegment: String, CaseIterable {
    case places
    case events
    case routes

    var title: String {
        switch self {
        case .places:
            return "Mekanlar"
        case .events:
            return "Etkinlikler"
        case .routes:
            return "Rotalar"
        }
    }

    var iconName: String {
        switch self {
        case .places:
            return "mappin.and.ellipse"
        case .events:
            return "calendar"
        case .routes:
            return "point.topleft.down.curvedto.point.bottomright.up"
        }
    }
}

struct FavoritesView: View {
    let cityId: String
    let authStatus: AppState.AuthStatus
    var onAuthTap: (() -> Void)? = nil

    @Environment(\.navigate) private var navigate
    @StateObject private var viewModel: FavoritesViewModel
    @State private var selectedSegment: FavoritesSegment = .places

    init(
        cityId: String,
        authStatus: AppState.AuthStatus,
        onAuthTap: (() -> Void)? = nil
    ) {
        self.cityId = cityId
        self.authStatus = authStatus
        self.onAuthTap = onAuthTap

        _viewModel = StateObject(
            wrappedValue: FavoritesViewModel(
                cityId: cityId,
                authStatus: authStatus
            )
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            if authStatus == .guest {
                AuthRequiredView(
                    title: "Favorilerini görmek için giriş yap",
                    message: "Favori mekanlarını ve kaydettiğin rotaları hesabında saklamak için giriş yap veya üye ol.",
                    buttonTitle: "Giriş Yap / Üye Ol"
                ) {
                    onAuthTap?()
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        topLogoSection

                        titleSection

                        segmentControl

                        contentSection
                    }
                    .padding(.horizontal, AppSpacing.md)
                    .padding(.top, AppSpacing.md)
                    .padding(.bottom, 120)
                }
            }
        }
        .navigationTitle("Favoriler")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadFavorites()
        }
        .onAppear {
            Task {
                await viewModel.refreshAllFavorites()
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
    }

    private var topLogoSection: some View {
        HStack {
            HStack(spacing: 6) {
                Image("gezioGoLogoTransparent")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
                    .clipShape(Circle())

                HStack(spacing: 0) {
                    Text("Gezio")
                        .foregroundStyle(AppColors.petrol)

                    Text("Go")
                        .foregroundStyle(AppColors.gold)
                }
                .font(.system(size: 19, weight: .bold, design: .rounded))
            }

            Spacer()

            Button {
                navigate(.notifications)
            } label: {
                Image(systemName: "bell")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
                    .frame(width: 40, height: 40)
                    .background(AppColors.cardBackground)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.08), radius: 9, x: 0, y: 4)
            }
            .buttonStyle(.plain)
        }
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Favorilerim")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Text("Kaydettiğin mekanlara, etkinliklere ve rotalara hızlıca ulaş.")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)
        }
    }

    private var segmentControl: some View {
        HStack(spacing: 0) {
            ForEach(FavoritesSegment.allCases, id: \.self) { segment in
                Button {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.86)) {
                        selectedSegment = segment
                    }
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: segment.iconName)
                            .font(.system(size: 12, weight: .semibold))

                        Text(segment.title)
                            .font(.system(size: 12, weight: .semibold))
                            .lineLimit(1)
                    }
                    .foregroundStyle(selectedSegment == segment ? .white : AppColors.petrol)
                    .frame(maxWidth: .infinity)
                    .frame(height: 36)
                    .background(
                        selectedSegment == segment
                        ? AnyShapeStyle(
                            LinearGradient(
                                colors: [AppColors.teal, AppColors.petrol],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        : AnyShapeStyle(Color.clear)
                    )
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(AppColors.cardBackground)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(AppColors.border.opacity(0.65), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.045), radius: 7, x: 0, y: 3)
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            LoadingView("Favoriler yükleniyor...")
        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(message: errorMessage) {
                Task {
                    await viewModel.loadFavorites()
                }
            }
        } else {
            switch selectedSegment {
            case .places:
                favoritePlacesSection
            case .events:
                favoriteEventsSection
            case .routes:
                savedRoutesSection
            }
        }
    }

    private var favoritePlacesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionHeader(
                title: "Favori mekanlar",
                countText: "\(viewModel.favoritePlaces.count) mekan"
            )

            if viewModel.favoritePlaces.isEmpty {
                emptyFavoriteCard(
                    iconName: "heart",
                    title: "Henüz favori mekan yok",
                    message: "Beğendiğin mekanları favorilere ekleyerek burada görebilirsin.",
                    buttonTitle: "Keşfetmeye Git"
                ) {
                    navigate(.explore(cityId: cityId))
                }
            } else {
                VStack(spacing: AppSpacing.sm) {
                    ForEach(viewModel.favoritePlaces) { place in
                        favoritePlaceCard(place)
                    }
                }
            }
        }
    }

    private var favoriteEventsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionHeader(
                title: "Favori etkinlikler",
                countText: "0 etkinlik"
            )

            emptyFavoriteCard(
                iconName: "calendar",
                title: "Henüz favori etkinlik yok",
                message: "Etkinlikleri kaydetme özelliğini eklediğimizde favori etkinliklerin burada görünecek.",
                buttonTitle: "Etkinliklere Git"
            ) {
                navigate(.events(cityId: cityId))
            }
        }
    }

    private var savedRoutesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionHeader(
                title: "Kaydedilen rotalar",
                countText: "\(viewModel.savedRoutes.count) rota"
            )

            if viewModel.savedRoutes.isEmpty {
                emptyFavoriteCard(
                    iconName: "bookmark",
                    title: "Henüz kayıtlı rota yok",
                    message: "Beğendiğin rotaları kaydederek daha sonra buradan hızlıca ulaşabilirsin.",
                    buttonTitle: "Rotalara Git"
                ) {
                    navigate(.routes(cityId: cityId))
                }
            } else {
                VStack(spacing: AppSpacing.sm) {
                    ForEach(viewModel.savedRoutes) { route in
                        savedRouteCard(route)
                    }
                }
            }
        }
    }

    private func sectionHeader(
        title: String,
        countText: String
    ) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Spacer()

            Text(countText)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(AppColors.teal)
                .padding(.horizontal, 9)
                .padding(.vertical, 5)
                .background(AppColors.cream)
                .clipShape(Capsule())
        }
    }

    private func favoritePlaceCard(_ place: Place) -> some View {
        Button {
            navigate(.placeDetail(place: place))
        } label: {
            HStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppColors.teal.opacity(0.85),
                                    AppColors.petrol
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )

                    Image(systemName: place.category.iconName)
                        .font(.system(size: 46, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.22))

                    VStack {
                        Spacer()

                        LinearGradient(
                            colors: [
                                .clear,
                                .black.opacity(0.20)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 56)
                    }
                }
                .frame(width: 108)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 20,
                        bottomLeadingRadius: 20,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 0
                    )
                )

                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(place.category.displayName.uppercased())
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(AppColors.gold)
                                .lineLimit(1)

                            Text(place.name)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundStyle(AppColors.textPrimary)
                                .lineLimit(2)
                                .minimumScaleFactor(0.82)

                            HStack(spacing: 4) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundStyle(AppColors.teal)

                                Text(place.district)
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(AppColors.textSecondary)
                                    .lineLimit(1)
                            }
                        }

                        Spacer()

                        Button {
                            Task {
                                await viewModel.removeFavorite(place)
                            }
                        } label: {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(AppColors.gold)
                                .frame(width: 34, height: 34)
                                .background(AppColors.cardBackground)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.08), radius: 7, x: 0, y: 3)
                        }
                        .buttonStyle(.plain)
                    }

                    Text(place.shortDescription)
                        .font(.system(size: 10.5, weight: .regular))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(2)
                        .lineSpacing(1)

                    HStack(spacing: 5) {
                        smallActionButton(
                            title: "Haritada",
                            iconName: "mappin.circle.fill"
                        ) {
                            navigate(.mapExplore(cityId: cityId))
                        }

                        ShareLink(
                            item: "\(place.name) - \(place.shortDescription)"
                        ) {
                            smallActionLabel(title: "Paylaş", iconName: "square.and.arrow.up")
                        }

                        smallActionButton(
                            title: "Diğer",
                            iconName: "ellipsis"
                        ) {
                            navigate(.placeDetail(place: place))
                        }
                    }
                }
                .padding(12)
            }
            .frame(height: 152)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(.plain)
        .contextMenu {
            Button(role: .destructive) {
                Task {
                    await viewModel.removeFavorite(place)
                }
            } label: {
                Label("Favorilerden çıkar", systemImage: "heart.slash")
            }
        }
    }

    private func savedRouteCard(_ route: TripRoute) -> some View {
        Button {
            navigate(.routeDetail(route: route))
        } label: {
            HStack(spacing: AppSpacing.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppColors.teal,
                                    AppColors.petrol
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 58, height: 58)

                    Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(AppColors.gold)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(route.title)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(2)

                    Text("\(route.stops.count) duraklı gezi planı")
                        .font(.system(size: 11, weight: .regular))
                        .foregroundStyle(AppColors.textSecondary)

                    HStack(spacing: AppSpacing.xs) {
                        smallTag("Rota", iconName: "map")
                        smallTag("Kayıtlı", iconName: "bookmark.fill")
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)
            }
            .padding(12)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.055), radius: 9, x: 0, y: 4)
        }
        .buttonStyle(.plain)
        .contextMenu {
            ShareLink(
                item: RouteShareTextBuilder.shareText(for: route),
                subject: Text(RouteShareTextBuilder.shareTitle(for: route)),
                message: Text(RouteShareTextBuilder.shareText(for: route))
            ) {
                Label("Rotayı paylaş", systemImage: "square.and.arrow.up")
            }

            Button(role: .destructive) {
                Task {
                    await viewModel.removeSavedRoute(route)
                }
            } label: {
                Label("Kaydedilenlerden çıkar", systemImage: "bookmark.slash")
            }
        }
    }

    private func smallActionButton(
        title: String,
        iconName: String,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            smallActionLabel(title: title, iconName: iconName)
        }
        .buttonStyle(.plain)
    }

    private func smallActionLabel(
        title: String,
        iconName: String
    ) -> some View {
        HStack(spacing: 4) {
            Image(systemName: iconName)
                .font(.system(size: 10, weight: .semibold))

            Text(title)
                .font(.system(size: 9.5, weight: .semibold))
                .lineLimit(1)
        }
        .foregroundStyle(AppColors.petrol)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(AppColors.cardBackground)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(AppColors.border.opacity(0.7), lineWidth: 1)
        )
    }

    private func smallTag(
        _ title: String,
        iconName: String
    ) -> some View {
        HStack(spacing: 4) {
            Image(systemName: iconName)
                .font(.system(size: 9, weight: .semibold))

            Text(title)
                .font(.system(size: 9.5, weight: .semibold))
        }
        .foregroundStyle(AppColors.petrol)
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(AppColors.cream)
        .clipShape(Capsule())
    }

    private func emptyFavoriteCard(
        iconName: String,
        title: String,
        message: String,
        buttonTitle: String? = nil,
        action: (() -> Void)? = nil
    ) -> some View {
        AppCard {
            VStack(spacing: AppSpacing.sm) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppColors.teal.opacity(0.18),
                                    AppColors.gold.opacity(0.18)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 62, height: 62)

                    Image(systemName: iconName)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                }

                Text(title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Text(message)
                    .font(.system(size: 11.5, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(2)

                if let buttonTitle, let action {
                    Button {
                        action()
                    } label: {
                        HStack(spacing: AppSpacing.xs) {
                            Text(buttonTitle)
                            Image(systemName: "chevron.right")
                        }
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(AppColors.teal)
                        .padding(.top, AppSpacing.xs)
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.sm)
        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView(
            cityId: "samsun",
            authStatus: .authenticated
        )
    }
}

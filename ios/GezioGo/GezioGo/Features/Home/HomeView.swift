import SwiftUI

struct HomeView: View {
    let cityId: String
    let userDisplayName: String?

    @Environment(\.navigate) private var navigate
    @StateObject private var viewModel: HomeViewModel
    @State private var searchText = ""
    
    private var trimmedSearchText: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var isSearching: Bool {
        !trimmedSearchText.isEmpty
    }

    private var searchResults: [Place] {
        let query = trimmedSearchText.localizedLowercase

        return viewModel.places.filter { place in
            let searchableText = [
                place.name,
                place.category.displayName,
                place.subCategory ?? "",
                place.shortDescription,
                place.longDescription ?? "",
                place.district,
                place.address,
                place.tags.joined(separator: " ")
            ]
            .joined(separator: " ")
            .localizedLowercase

            return searchableText.contains(query)
        }
    }

    init(
        cityId: String,
        userDisplayName: String? = nil
    ) {
        self.cityId = cityId
        self.userDisplayName = userDisplayName
        _viewModel = StateObject(
            wrappedValue: HomeViewModel(
                cityId: cityId,
                userDisplayName: userDisplayName
            )
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    topLogoSection

                    greetingSection

                    searchSection

                    if viewModel.isLoading {
                        ProgressView("Ana sayfa yükleniyor...")
                            .frame(maxWidth: .infinity)
                            .padding(.top, AppSpacing.xl)
                    } else if let errorMessage = viewModel.errorMessage {
                        errorCard(errorMessage)
                    } else {
                        if isSearching {
                            searchResultsSection
                        } else {
                            cityHeroSection

                            categorySection

                            nearbySection

                            recommendationsSection

                            eventsSection

                            routesSection
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 110)
            }
            .scrollDismissesKeyboard(.interactively)
            .hideKeyboardOnTap()
        }
        .task {
            await viewModel.loadHomeData()
        }
    }

    private var topLogoSection: some View {
        HStack {
            HStack(spacing: 6) {
                Image("gezioGoLogoTransparent")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38, height: 38)
                    .clipShape(Circle())

                HStack(spacing: 0) {
                    Text("Gezio")
                        .foregroundStyle(AppColors.petrol)

                    Text("Go")
                        .foregroundStyle(AppColors.gold)
                }
                .font(.system(size: 20, weight: .bold, design: .rounded))
            }

            Spacer()

            Button {
                navigate(.notifications)
            } label: {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bell")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                        .frame(width: 42, height: 42)
                        .background(AppColors.cardBackground)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 5)
                }
            }
            .buttonStyle(.plain)
        }
    }
    
    private var greetingName: String {
        let name = userDisplayName?.trimmingCharacters(in: .whitespacesAndNewlines)

        if let name, !name.isEmpty {
            return name
        } else {
            return "Gezgin"
        }
    }
    
    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                    Text("Arama sonuçları")
                        .font(AppTypography.subtitle)
                        .foregroundStyle(AppColors.textPrimary)

                    Text("\(viewModel.cityName) içinde “\(trimmedSearchText)” araması")
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.textSecondary)
                }

                Spacer()

                Button {
                    searchText = ""
                } label: {
                    Text("Temizle")
                        .font(AppTypography.captionMedium)
                        .foregroundStyle(AppColors.teal)
                }
                .buttonStyle(.plain)
            }

            if searchResults.isEmpty {
                EmptyStateView(
                    title: "Sonuç bulunamadı",
                    message: "\(viewModel.cityName) içinde bu aramaya uygun mekan bulunamadı.",
                    iconName: "magnifyingglass"
                )
            } else {
                VStack(spacing: AppSpacing.md) {
                    ForEach(searchResults) { place in
                        Button {
                            navigate(.placeDetail(place: place))
                        } label: {
                            searchResultCard(place)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
    
    private func searchResultCard(_ place: Place) -> some View {
        AppCard {
            HStack(alignment: .top, spacing: AppSpacing.md) {
                ZStack {
                    RoundedRectangle(cornerRadius: AppRadius.medium)
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppColors.teal.opacity(0.18),
                                    AppColors.gold.opacity(0.16)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 58, height: 58)

                    Image(systemName: place.category.iconName)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                }

                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    HStack(spacing: AppSpacing.xs) {
                        Text(place.category.displayName)
                            .font(AppTypography.captionMedium)
                            .foregroundStyle(AppColors.teal)

                        Text("•")

                        Text(place.district)
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.textSecondary)
                    }

                    Text(place.name)
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(1)

                    Text(place.shortDescription)
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(2)
                        .lineSpacing(3)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(AppColors.textSecondary)
                    .padding(.top, AppSpacing.sm)
            }
        }
    }
    
    private var greetingSection: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Merhaba, \(greetingName)!")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Text("Bugün \(viewModel.cityName)’da nereyi keşfetmek istersin?")
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
        }
    }

    private var searchSection: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)

            TextField("Nereye keşfetmek istersin?", text: $searchText)
                .font(.system(size: 14, weight: .regular))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.done)
                .onSubmit {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil
                    )
                }

            Button {
                if isSearching {
                    searchText = ""
                }
            } label: {
                Image(systemName: isSearching ? "xmark.circle.fill" : "line.3.horizontal.decrease")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, AppSpacing.md)
        .frame(height: 50)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 5)
    }

    private var cityHeroSection: some View {
        Group {
            if let featuredPlace = viewModel.dailyFeaturedPlace {
                Button {
                    navigate(.placeDetail(place: featuredPlace))
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        AppColors.petrol,
                                        AppColors.teal,
                                        AppColors.gold.opacity(0.55)
                                    ],
                                    startPoint: .bottomLeading,
                                    endPoint: .topTrailing
                                )
                            )

                        HStack(alignment: .center, spacing: AppSpacing.md) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 6) {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 10, weight: .semibold))

                                    Text("Bugünün Öne Çıkanı")
                                        .font(.system(size: 11, weight: .semibold))
                                }
                                .foregroundStyle(AppColors.textPrimary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(AppColors.cardBackground.opacity(0.94))
                                .clipShape(Capsule())

                                Text(featuredPlace.name)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.8)
                                    .fixedSize(horizontal: false, vertical: true)

                                Text(featuredPlace.shortDescription)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(.white.opacity(0.92))
                                    .lineSpacing(1)
                                    .lineLimit(3)
                                    .fixedSize(horizontal: false, vertical: true)

                                Button {
                                    navigate(.placeDetail(place: featuredPlace))
                                } label: {
                                    HStack(spacing: 8) {
                                        Text("Keşfet")
                                            .font(.system(size: 13, weight: .semibold))

                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 11, weight: .semibold))
                                    }
                                    .foregroundStyle(AppColors.petrol)
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 8)
                                    .background(AppColors.gold.opacity(0.96))
                                    .clipShape(Capsule())
                                }
                                .buttonStyle(.plain)
                                .padding(.top, 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(AppColors.cardBackground.opacity(0.94))
                                    .frame(width: 72, height: 72)

                                Image(systemName: featuredPlace.category.iconName)
                                    .font(.system(size: 28, weight: .semibold))
                                    .foregroundStyle(AppColors.petrol)
                            }
                        }
                        .padding(.horizontal, 22)
                        .padding(.vertical, 16)
                    }
                    .frame(height: 190)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                .buttonStyle(.plain)
                .padding(.top, -10)
            }
        }
    }

    private var categorySection: some View {
        HStack(spacing: AppSpacing.sm) {
            homeCategoryButton(
                title: "Yemek",
                iconName: "fork.knife"
            ) {
                navigate(.placeList(cityId: cityId, category: .foodDrink))
            }

            homeCategoryButton(
                title: "Etkinlik",
                iconName: "music.note"
            ) {
                navigate(.events(cityId: cityId))
            }

            homeCategoryButton(
                title: "Konaklama",
                iconName: "bed.double.fill"
            ) {
                navigate(.accommodation(cityId: cityId))
            }

            homeCategoryButton(
                title: "Ulaşım",
                iconName: "bus.fill"
            ) {
                navigate(.transportation(cityId: cityId))
            }
        }
        .padding(.top, -AppSpacing.sm)
    }

    private func homeCategoryButton(
        title: String,
        iconName: String,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            VStack(spacing: 5) {
                ZStack {
                    Circle()
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
                        .frame(width: 46, height: 46)

                    Image(systemName: iconName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                }

                Text(title)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }

    private func homeCategoryButton(
        title: String,
        iconName: String,
        category: PlaceCategory?
    ) -> some View {
        Button {
            if title == "Etkinlik" {
                navigate(.events(cityId: cityId))
            } else if title == "Tümü" {
                navigate(.explore(cityId: cityId))
            } else {
                navigate(.placeList(cityId: cityId, category: category))
            }
        } label: {
            VStack(spacing: AppSpacing.xs) {
                ZStack {
                    Circle()
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

                    Image(systemName: iconName)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.white)
                }

                Text(title)
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.textPrimary)
            }
            .frame(width: 76)
        }
        .buttonStyle(.plain)
    }

    private var nearbySection: some View {
        AppCard {
            HStack(spacing: AppSpacing.md) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Şehri Haritada Keşfet")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("\(viewModel.cityName)’daki müzeleri, sahilleri ve popüler noktaları harita üzerinde incele.")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineSpacing(2)
                        .lineLimit(4)
                        .fixedSize(horizontal: false, vertical: true)

                    Button {
                        navigate(.mapExplore(cityId: cityId))
                    } label: {
                        HStack(spacing: AppSpacing.xs) {
                            Image(systemName: "location.fill")
                                .font(.system(size: 12, weight: .semibold))

                            Text("Haritayı Aç")
                                .font(.system(size: 12, weight: .semibold))
                        }
                        .foregroundStyle(AppColors.petrol)
                        .padding(.horizontal, AppSpacing.md)
                        .padding(.vertical, 9)
                        .background(AppColors.teal.opacity(0.14))
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                cityMapPreview
            }
        }
        .padding(.top, -AppSpacing.sm)
    }
    
    private var cityMapPreview: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(AppColors.cream)
                .frame(width: 132, height: 96)

            Path { path in
                path.move(to: CGPoint(x: 18, y: 68))
                path.addCurve(
                    to: CGPoint(x: 62, y: 42),
                    control1: CGPoint(x: 30, y: 46),
                    control2: CGPoint(x: 48, y: 62)
                )
                path.addCurve(
                    to: CGPoint(x: 112, y: 34),
                    control1: CGPoint(x: 76, y: 22),
                    control2: CGPoint(x: 96, y: 48)
                )
            }
            .stroke(
                AppColors.teal.opacity(0.55),
                style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [6, 5])
            )
            .frame(width: 132, height: 96)

            Image(systemName: "map.fill")
                .font(.system(size: 42))
                .foregroundStyle(AppColors.teal.opacity(0.20))
                .offset(x: -6, y: 4)

            Image(systemName: "location.fill")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(AppColors.gold)
                .offset(x: 42, y: -26)

            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(AppColors.teal)
                .offset(x: -34, y: 20)

            Image(systemName: "location.circle.fill")
                .font(.system(size: 30, weight: .semibold))
                .foregroundStyle(AppColors.petrol)
                .offset(x: 4, y: -2)
        }
        .frame(width: 132, height: 96)
    }

    private var recommendationsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionHeader(
                title: "Kategorilere Göre Keşfet",
                actionTitle: "Tümünü Gör"
            ) {
                navigate(.placeList(cityId: cityId, category: nil))
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.sm) {
                    categoryDiscoveryCard(
                        title: "Müzeler",
                        subtitle: "\(categoryCount(.museum)) yer",
                        iconName: "building.columns.fill",
                        category: .museum
                    )

                    categoryDiscoveryCard(
                        title: "Doğa",
                        subtitle: "\(categoryCount(.nature)) yer",
                        iconName: "leaf.fill",
                        category: .nature
                    )

                    categoryDiscoveryCard(
                        title: "Tarihi",
                        subtitle: "\(categoryCount(.historical)) yer",
                        iconName: "building.2.crop.circle.fill",
                        category: .historical
                    )

                    categoryDiscoveryCard(
                        title: "Yeme & İçme",
                        subtitle: "\(categoryCount(.foodDrink)) yer",
                        iconName: "fork.knife",
                        category: .foodDrink
                    )
                }
                .padding(.vertical, 4)
            }
        }
    }
    
    private func categoryCount(_ category: PlaceCategory) -> Int {
        viewModel.places.filter { $0.category == category }.count
    }
    
    private func categoryDiscoveryCard(
        title: String,
        subtitle: String,
        iconName: String,
        category: PlaceCategory
    ) -> some View {
        Button {
            navigate(.placeList(cityId: cityId, category: category))
        } label: {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 18)
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
                    .frame(width: 128, height: 102)

                Image(systemName: iconName)
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.20))
                    .offset(x: 66, y: -34)

                VStack(alignment: .leading, spacing: 4) {
                    ZStack {
                        Circle()
                            .fill(AppColors.cardBackground.opacity(0.18))
                            .frame(width: 32, height: 32)

                        Image(systemName: iconName)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    Text(title)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)

                    Text(subtitle)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.white.opacity(0.82))
                        .lineLimit(1)
                }
                .padding(12)
            }
            .frame(width: 128, height: 102)
        }
        .buttonStyle(.plain)
    }

    private func recommendationCard(_ place: Place) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(
                        LinearGradient(
                            colors: [
                                AppColors.teal.opacity(0.72),
                                AppColors.petrol.opacity(0.88)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 116)

                Image(systemName: place.category.iconName)
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.9))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                Image(systemName: "heart")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(AppSpacing.sm)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(place.name)
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(1)

                HStack(spacing: AppSpacing.xs) {
                    Image(systemName: place.category.iconName)
                    Text(place.category.displayName)
                }
                .font(AppTypography.caption)
                .foregroundStyle(AppColors.textSecondary)
                .lineLimit(1)

                HStack(spacing: AppSpacing.xs) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(AppColors.gold)

                    Text("4.8")
                        .foregroundStyle(AppColors.textPrimary)

                    Spacer()

                    Image(systemName: "mappin.and.ellipse")
                    Text(place.district)
                        .lineLimit(1)
                }
                .font(AppTypography.caption)
                .foregroundStyle(AppColors.textSecondary)
            }
            .padding(AppSpacing.sm)
        }
        .frame(width: 160)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.07), radius: 10, x: 0, y: 5)
    }

    private var eventsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionHeader(
                title: "Bu hafta \(viewModel.cityName)’da",
                actionTitle: "Tümünü Gör"
            ) {
                navigate(.events(cityId: cityId))
            }

            if viewModel.featuredEvents.isEmpty {
                EmptyStateView(
                    title: "Etkinlik bulunamadı",
                    message: "Bu şehir için henüz etkinlik eklenmemiş.",
                    iconName: "calendar"
                )
            } else {
                AppCard {
                    VStack(spacing: AppSpacing.sm) {
                        ForEach(Array(viewModel.featuredEvents.enumerated()), id: \.element.id) { index, event in
                            Button {
                                navigate(.eventDetail(event: event))
                            } label: {
                                compactEventRow(event)
                            }
                            .buttonStyle(.plain)

                            if index != viewModel.featuredEvents.count - 1 {
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func compactEventRow(_ event: Event) -> some View {
        HStack(alignment: .center, spacing: AppSpacing.md) {
            VStack(spacing: 2) {
                Text(eventDayText(event))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text(eventMonthText(event))
                    .font(.system(size: 9, weight: .bold))
                    .foregroundStyle(.white.opacity(0.9))
            }
            .frame(width: 46, height: 46)
            .background(AppColors.petrol)
            .clipShape(RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 5) {
                Text(event.title)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(1)

                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 10, weight: .semibold))

                    Text(event.venueName)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(1)
                }

                HStack(spacing: AppSpacing.xs) {
                    compactEventTag(
                        iconName: event.category.iconName,
                        title: event.category.displayName
                    )

                    compactEventTag(
                        iconName: "clock",
                        title: eventTimeText(event)
                    )
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
        }
        .padding(.vertical, 2)
    }
    
    private func compactEventTag(
        iconName: String,
        title: String
    ) -> some View {
        HStack(spacing: 4) {
            Image(systemName: iconName)
                .font(.system(size: 10, weight: .semibold))

            Text(title)
                .font(.system(size: 11, weight: .semibold))
                .lineLimit(1)
        }
        .foregroundStyle(AppColors.petrol)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(AppColors.cream)
        .clipShape(Capsule())
    }

    private func eventDayText(_ event: Event) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "dd"

        if let date = ISO8601DateFormatter().date(from: event.startDate) {
            return formatter.string(from: date)
        }

        return "--"
    }

    private func eventMonthText(_ event: Event) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "MMM"

        if let date = ISO8601DateFormatter().date(from: event.startDate) {
            return formatter.string(from: date).uppercased()
        }

        return ""
    }

    private func eventTimeText(_ event: Event) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "HH:mm"

        if let date = ISO8601DateFormatter().date(from: event.startDate) {
            return formatter.string(from: date)
        }

        return "Saat yok"
    }

    private var routesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            sectionHeader(
                title: "\(viewModel.cityName) hazır rotaları",
                actionTitle: "Tümünü Gör"
            ) {
                navigate(.routes(cityId: cityId))
            }

            Button {
                navigate(.routes(cityId: cityId))
            } label: {
                FeaturedRouteCard()
            }
            .buttonStyle(.plain)
        }
    }

    private func sectionHeader(
        title: String,
        actionTitle: String,
        action: @escaping () -> Void
    ) -> some View {
        HStack {
            Text(title)
                .font(AppTypography.subtitle)
                .foregroundStyle(AppColors.textPrimary)

            Spacer()

            Button(actionTitle) {
                action()
            }
            .font(AppTypography.captionMedium)
            .foregroundStyle(AppColors.teal)
        }
    }

    private func errorCard(_ message: String) -> some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text("Veriler yüklenemedi")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.error)

                Text(message)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
    }
}

#Preview {
    HomeView(cityId: "samsun")
}

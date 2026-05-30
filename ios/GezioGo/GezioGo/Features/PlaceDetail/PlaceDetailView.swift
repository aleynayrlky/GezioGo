import SwiftUI

struct PlaceDetailView: View {
    @StateObject private var viewModel: PlaceDetailViewModel

    @State private var showLoginRequiredAlert = false
    @State private var showReviewSheet = false
    @State private var editingReview: Review?
    @State private var reviewToDelete: Review?

    let authStatus: AppState.AuthStatus
    let userDisplayName: String?

    private let mapService = MapService()

    init(
        place: Place,
        authStatus: AppState.AuthStatus = .authenticated,
        userDisplayName: String? = nil
    ) {
        self.authStatus = authStatus
        self.userDisplayName = userDisplayName
        _viewModel = StateObject(
            wrappedValue: PlaceDetailViewModel(place: place)
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    heroSection
                    titleSection
                    quickInfoSection
                    descriptionSection
                    infoSection
                    mapSection
                    reviewsSection
                    actionSection
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 120)
            }
        }
        .navigationTitle(viewModel.place.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                ShareLink(
                    item: "\(viewModel.place.name) - \(viewModel.place.shortDescription)"
                ) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(AppColors.petrol)
                }

                Button {
                    guard authStatus == .authenticated else {
                        showLoginRequiredAlert = true
                        return
                    }

                    Task {
                        await viewModel.toggleFavorite()
                    }
                } label: {
                    Image(systemName: viewModel.favoriteButtonIcon)
                        .foregroundStyle(viewModel.isFavorite ? AppColors.gold : AppColors.petrol)
                        .opacity(authStatus == .authenticated ? 1 : 0.55)
                }
                .accessibilityLabel(viewModel.favoriteButtonTitle)
            }
        }
        .task {
            await viewModel.loadInitialData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .favoritesDidChange)) { _ in
            Task {
                if authStatus == .authenticated {
                    await viewModel.loadFavoriteState()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .reviewsDidChange)) { _ in
            Task {
                await viewModel.loadReviews()
            }
        }
        .alert("Giriş yapmalısın", isPresented: $showLoginRequiredAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text("Favorilere eklemek, yorum yapmak veya puan vermek için giriş yapman gerekiyor.")
        }
        .sheet(isPresented: $showReviewSheet) {
            ReviewSheetView(
                targetTitle: viewModel.place.name,
                initialRating: viewModel.currentUserReview?.rating ?? 5,
                initialComment: viewModel.currentUserReview?.comment ?? "",
                submitButtonTitle: viewModel.currentUserReview == nil ? "Yorumu Kaydet" : "Yorumu Güncelle",
                onSubmit: { rating, comment in
                    Task {
                        await viewModel.addReview(
                            rating: rating,
                            comment: comment,
                            displayName: userDisplayName
                        )

                        await MainActor.run {
                            showReviewSheet = false
                        }
                    }
                },
                onCancel: {
                    showReviewSheet = false
                }
            )
            .id(viewModel.currentUserReview?.id ?? "new-review")
        }
        .sheet(item: $editingReview) { review in
            ReviewSheetView(
                targetTitle: viewModel.place.name,
                initialRating: review.rating,
                initialComment: review.comment,
                submitButtonTitle: "Yorumu Güncelle",
                onSubmit: { rating, comment in
                    Task {
                        await viewModel.addReview(
                            rating: rating,
                            comment: comment,
                            displayName: userDisplayName
                        )

                        await MainActor.run {
                            editingReview = nil
                        }
                    }
                },
                onCancel: {
                    editingReview = nil
                }
            )
            .id(review.id)
        }
        .alert(
            "Yorum silinsin mi?",
            isPresented: Binding(
                get: { reviewToDelete != nil },
                set: { newValue in
                    if !newValue {
                        reviewToDelete = nil
                    }
                }
            )
        ) {
            Button("Vazgeç", role: .cancel) {
                reviewToDelete = nil
            }

            Button("Sil", role: .destructive) {
                if let reviewToDelete {
                    Task {
                        await viewModel.deleteReview(reviewToDelete)

                        await MainActor.run {
                            self.reviewToDelete = nil
                        }
                    }
                }
            }
        } message: {
            Text("Bu yorum kalıcı olarak silinecek.")
        }
    }

    private var heroSection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 26)
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
                .frame(height: 190)

            Image(systemName: viewModel.place.category.iconName)
                .font(.system(size: 72, weight: .semibold))
                .foregroundStyle(AppColors.gold.opacity(0.92))

            VStack {
                Spacer()

                HStack {
                    AppTag(
                        viewModel.place.category.displayName,
                        iconName: viewModel.place.category.iconName
                    )

                    Spacer()

                    Text(viewModel.place.priceInfo ?? viewModel.place.priceType.displayName)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                        .background(AppColors.cream)
                        .clipShape(Capsule())
                        .lineLimit(1)
                }
                .padding(14)
            }
        }
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text(viewModel.place.name)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)
                .lineLimit(2)
                .minimumScaleFactor(0.82)

            HStack(spacing: AppSpacing.xs) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 14, weight: .semibold))

                Text("\(viewModel.place.district), \(cityDisplayName)")
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
            }
            .foregroundStyle(AppColors.teal)

            HStack(spacing: AppSpacing.sm) {
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(AppColors.gold)

                    Text(viewModel.ratingText)
                        .font(.system(size: 14, weight: .bold))

                    Text("(\(viewModel.reviewCountText))")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(AppColors.textSecondary)
                }

                Spacer()

                Button {
                    guard authStatus == .authenticated else {
                        showLoginRequiredAlert = true
                        return
                    }

                    Task {
                        await viewModel.toggleFavorite()
                    }
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: viewModel.favoriteButtonIcon)
                            .font(.system(size: 13, weight: .semibold))

                        Text(viewModel.isFavorite ? "Favorilerde" : "Favorilere Ekle")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundStyle(viewModel.isFavorite ? AppColors.gold : AppColors.petrol)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(AppColors.cardBackground)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(AppColors.border.opacity(0.75), lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var quickInfoSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.xs) {
                AppTag(viewModel.place.category.displayName, iconName: viewModel.place.category.iconName)
                AppTag(viewModel.areaTypeText, iconName: "figure.walk")
                AppTag(viewModel.durationText, iconName: "clock")
                AppTag(viewModel.place.priceType.displayName, iconName: "ticket")

                if viewModel.place.isChildFriendly {
                    AppTag("Çocukla uygun", iconName: "figure.and.child.holdinghands")
                }

                if viewModel.place.isStudentFriendly {
                    AppTag("Öğrenci dostu", iconName: "graduationcap")
                }
            }
        }
    }

    private var descriptionSection: some View {
        compactCard {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text("Hakkında")
                    .font(.system(size: 19, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Text(viewModel.place.longDescription ?? viewModel.place.shortDescription)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var infoSection: some View {
        compactCard {
            VStack(spacing: 0) {
                PlaceInfoRow(
                    iconName: "mappin.and.ellipse",
                    title: "Adres",
                    value: viewModel.place.address
                )

                Divider()
                    .padding(.leading, 42)

                PlaceInfoRow(
                    iconName: "clock",
                    title: "Ziyaret Süresi",
                    value: viewModel.durationText
                )

                Divider()
                    .padding(.leading, 42)

                PlaceInfoRow(
                    iconName: "calendar",
                    title: "Açılış Saatleri",
                    value: viewModel.place.openingHours ?? "Saat bilgisi yok"
                )

                Divider()
                    .padding(.leading, 42)

                PlaceInfoRow(
                    iconName: "ticket",
                    title: "Ücret",
                    value: viewModel.place.priceInfo ?? viewModel.place.priceType.displayName
                )
            }
        }
    }

    private var mapSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionHeader("Konum")

            PlaceMapPreview(place: viewModel.place)

            Button {
                mapService.openDirections(to: viewModel.place)
            } label: {
                HStack {
                    Image(systemName: "location.fill")
                        .font(.system(size: 15, weight: .semibold))

                    Text("Yol Tarifi Al")
                        .font(.system(size: 14, weight: .semibold))

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .bold))
                }
                .foregroundStyle(AppColors.petrol)
                .padding(.horizontal, AppSpacing.md)
                .frame(height: 48)
                .background(AppColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppColors.border.opacity(0.7), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
        }
    }

    private var reviewsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                sectionHeader("Yorumlar ve Puanlar")

                Spacer()

                Button {
                    guard authStatus == .authenticated else {
                        showLoginRequiredAlert = true
                        return
                    }

                    showReviewSheet = true
                } label: {
                    Text(viewModel.currentUserReview == nil ? "Yorum Yap" : "Yorumunu Düzenle")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(AppColors.teal)
                }
                .buttonStyle(.plain)
            }

            compactCard {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    HStack(spacing: AppSpacing.md) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(viewModel.ratingText)
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(AppColors.textPrimary)

                            starRow(rating: Int(viewModel.averageRating.rounded()))
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(viewModel.reviewCountText) değerlendirme")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(AppColors.textPrimary)

                            Text(authStatus == .authenticated ? "Deneyimini paylaşarak diğer gezginlere yardımcı ol." : "Yorum yapmak ve puan vermek için giriş yapmalısın.")
                                .font(.system(size: 11.5, weight: .regular))
                                .foregroundStyle(AppColors.textSecondary)
                                .lineLimit(2)
                        }

                        Spacer()
                    }

                    Divider()

                    if viewModel.isLoadingReviews {
                        ProgressView("Yorumlar yükleniyor...")
                            .font(AppTypography.caption)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, AppSpacing.sm)
                    } else if viewModel.reviews.isEmpty {
                        Text("Henüz yorum yok. İlk yorumu sen yapabilirsin.")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(AppColors.textSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        VStack(spacing: AppSpacing.sm) {
                            ForEach(viewModel.reviews) { review in
                                reviewRow(review)
                            }
                        }
                    }
                }
            }
        }
    }

    private func reviewRow(_ review: Review) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(review.displayName)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                starRow(rating: review.rating)
            }

            Text(review.comment)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)

            HStack {
                Text(review.isEdited ? "\(review.dateText) · düzenlendi" : review.dateText)
                    .font(.system(size: 10.5, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary.opacity(0.8))

                Spacer()

                if review.userId == viewModel.currentUserId {
                    Button {
                        editingReview = review
                    } label: {
                        Text("Düzenle")
                            .font(.system(size: 10.5, weight: .semibold))
                            .foregroundStyle(AppColors.teal)
                    }
                    .buttonStyle(.plain)

                    Button {
                        reviewToDelete = review
                    } label: {
                        Text("Sil")
                            .font(.system(size: 10.5, weight: .semibold))
                            .foregroundStyle(AppColors.gold)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.vertical, 2)
        .contextMenu {
            if review.userId == viewModel.currentUserId {
                Button {
                    editingReview = review
                } label: {
                    Label("Düzenle", systemImage: "pencil")
                }

                Button(role: .destructive) {
                    reviewToDelete = review
                } label: {
                    Label("Sil", systemImage: "trash")
                }
            }
        }
    }

    private var actionSection: some View {
        HStack(spacing: AppSpacing.sm) {
            Button {
                guard authStatus == .authenticated else {
                    showLoginRequiredAlert = true
                    return
                }
            } label: {
                HStack(spacing: 7) {
                    Image(systemName: "plus.circle.fill")
                    Text("Rotaya Ekle")
                }
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(
                    LinearGradient(
                        colors: [
                            AppColors.gold,
                            AppColors.gold.opacity(0.82)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 17))
            }
            .buttonStyle(.plain)

            Button {
                guard authStatus == .authenticated else {
                    showLoginRequiredAlert = true
                    return
                }

                showReviewSheet = true
            } label: {
                HStack(spacing: 7) {
                    Image(systemName: "star.fill")
                    Text(viewModel.currentUserReview == nil ? "Puanla" : "Puanını Düzenle")
                }
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(AppColors.petrol)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(AppColors.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 17))
                .overlay(
                    RoundedRectangle(cornerRadius: 17)
                        .stroke(AppColors.border.opacity(0.75), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundStyle(AppColors.textPrimary)
    }

    private func starRow(rating: Int) -> some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(AppColors.gold)
            }
        }
    }

    private func compactCard<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        content()
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.045), radius: 8, x: 0, y: 4)
    }

    private var cityDisplayName: String {
        switch viewModel.place.cityId.lowercased() {
        case "samsun":
            return "Samsun"
        default:
            return viewModel.place.cityId.capitalized
        }
    }
}

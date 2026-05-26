import SwiftUI

private struct AccommodationReview: Identifiable {
    let id = UUID()
    let userName: String
    let rating: Int
    let comment: String
    let dateText: String
}

struct AccommodationDetailView: View {
    let item: AccommodationItem
    let authStatus: AppState.AuthStatus

    @State private var showLoginRequiredAlert = false
    @State private var showReviewSheet = false
    @State private var reviewRating = 5
    @State private var reviewText = ""

    @State private var reviews: [AccommodationReview] = [
        AccommodationReview(
            userName: "Ayşe",
            rating: 5,
            comment: "Konumu çok iyiydi, kısa Samsun gezisi için rahat bir seçenek.",
            dateText: "2 gün önce"
        ),
        AccommodationReview(
            userName: "Mert",
            rating: 4,
            comment: "Temiz ve ulaşımı kolay. Fiyat performans olarak iyi.",
            dateText: "1 hafta önce"
        )
    ]

    private var averageRating: Double {
        guard !reviews.isEmpty else {
            return item.rating
        }

        let total = reviews.reduce(0) { $0 + $1.rating }
        return Double(total) / Double(reviews.count)
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    heroSection

                    titleSection

                    featuresSection

                    aboutSection

                    infoSection

                    reviewsSection

                    actionButton
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 120)
            }
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Giriş yapmalısın", isPresented: $showLoginRequiredAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text("Yorum yapmak, puan vermek veya rezervasyon işlemleri için giriş yapman gerekiyor.")
        }
        .sheet(isPresented: $showReviewSheet) {
            reviewSheet
        }
    }

    private var heroSection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
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
                .frame(height: 180)

            Image(systemName: "bed.double.fill")
                .font(.system(size: 70, weight: .semibold))
                .foregroundStyle(AppColors.gold.opacity(0.9))

            VStack {
                Spacer()

                HStack {
                    AppTag(item.type, iconName: "bed.double.fill")

                    Spacer()

                    Text(item.priceInfo)
                        .font(.system(size: 10.5, weight: .semibold))
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
            Text(item.name)
                .font(.system(size: 27, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)
                .lineLimit(2)

            HStack(spacing: 5) {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 13, weight: .semibold))

                Text("\(item.district), Samsun")
                    .font(.system(size: 13, weight: .semibold))
            }
            .foregroundStyle(AppColors.teal)

            HStack(spacing: AppSpacing.sm) {
                Image(systemName: "star.fill")
                    .foregroundStyle(AppColors.gold)

                Text(String(format: "%.1f", averageRating))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(AppColors.textPrimary)

                Text("(\(reviews.count) yorum)")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)

                Spacer()

                Button {
                    guard authStatus == .authenticated else {
                        showLoginRequiredAlert = true
                        return
                    }

                    reviewRating = 5
                    reviewText = ""
                    showReviewSheet = true
                } label: {
                    Text("Yorum Yap")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(AppColors.teal)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var featuresSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.xs) {
                ForEach(item.features, id: \.self) { feature in
                    AppTag(feature, iconName: "checkmark.circle")
                }
            }
        }
    }

    private var aboutSection: some View {
        compactCard {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text("Hakkında")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Text(item.longDescription)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(3)
            }
        }
    }

    private var infoSection: some View {
        compactCard {
            VStack(spacing: 0) {
                infoRow(
                    iconName: "mappin.and.ellipse",
                    title: "Adres",
                    value: item.address
                )

                Divider()
                    .padding(.leading, 40)

                infoRow(
                    iconName: "wallet.pass.fill",
                    title: "Fiyat",
                    value: item.priceInfo
                )

                Divider()
                    .padding(.leading, 40)

                infoRow(
                    iconName: "bed.double.fill",
                    title: "Konaklama Tipi",
                    value: item.type
                )
            }
        }
    }

    private var reviewsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Yorumlar ve Puanlar")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            compactCard {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(String(format: "%.1f", averageRating))
                                .font(.system(size: 26, weight: .bold, design: .rounded))
                                .foregroundStyle(AppColors.textPrimary)

                            starRow(rating: Int(averageRating.rounded()))
                        }

                        Spacer()

                        Text("\(reviews.count) değerlendirme")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(AppColors.textSecondary)
                    }

                    Divider()

                    ForEach(reviews) { review in
                        reviewRow(review)
                    }
                }
            }
        }
    }

    private var actionButton: some View {
        Button {
            guard authStatus == .authenticated else {
                showLoginRequiredAlert = true
                return
            }
        } label: {
            HStack {
                Image(systemName: "calendar.badge.plus")
                    .font(.system(size: 15, weight: .semibold))

                Text("Rezervasyon Bilgisi Al")
                    .font(.system(size: 14, weight: .bold))

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
            }
            .foregroundStyle(.white)
            .padding(.horizontal, AppSpacing.md)
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
    }

    private func infoRow(
        iconName: String,
        title: String,
        value: String
    ) -> some View {
        HStack(alignment: .top, spacing: AppSpacing.sm) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppColors.cream)
                    .frame(width: 34, height: 34)

                Image(systemName: iconName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.teal)

                Text(value)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(AppColors.textPrimary)
                    .lineSpacing(2)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }

    private func reviewRow(_ review: AccommodationReview) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(review.userName)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                starRow(rating: review.rating)
            }

            Text(review.comment)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)

            Text(review.dateText)
                .font(.system(size: 10.5, weight: .medium))
                .foregroundStyle(AppColors.textSecondary.opacity(0.8))
        }
        .padding(.vertical, 2)
    }

    private var reviewSheet: some View {
        NavigationStack {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    Text("Konaklama deneyimini paylaş")
                        .font(.system(size: 23, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)

                    HStack(spacing: AppSpacing.sm) {
                        ForEach(1...5, id: \.self) { star in
                            Button {
                                reviewRating = star
                            } label: {
                                Image(systemName: star <= reviewRating ? "star.fill" : "star")
                                    .font(.system(size: 28, weight: .semibold))
                                    .foregroundStyle(AppColors.gold)
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    TextEditor(text: $reviewText)
                        .font(.system(size: 14))
                        .frame(height: 140)
                        .padding(10)
                        .background(AppColors.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(AppColors.border.opacity(0.7), lineWidth: 1)
                        )

                    AppButton(title: "Yorumu Kaydet") {
                        let trimmed = reviewText.trimmingCharacters(in: .whitespacesAndNewlines)

                        guard !trimmed.isEmpty else {
                            return
                        }

                        reviews.insert(
                            AccommodationReview(
                                userName: "Sen",
                                rating: reviewRating,
                                comment: trimmed,
                                dateText: "Az önce"
                            ),
                            at: 0
                        )

                        showReviewSheet = false
                    }

                    Spacer()
                }
                .padding(AppSpacing.lg)
            }
            .navigationTitle("Yorum Yap")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kapat") {
                        showReviewSheet = false
                    }
                    .foregroundStyle(AppColors.petrol)
                }
            }
        }
        .presentationDetents([.medium, .large])
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
}

#Preview {
    NavigationStack {
        AccommodationDetailView(
            item: AccommodationItem(
                id: "samsun-sahil-otel",
                cityId: "samsun",
                name: "Samsun Sahil Otel",
                type: "Otel",
                district: "Atakum",
                address: "Atakum Sahil Yolu, Atakum / Samsun",
                shortDescription: "Sahile yakın konumu ve şehir manzarasıyla öne çıkan konaklama noktası.",
                longDescription: "Samsun Sahil Otel, Atakum sahiline yakın konumu, rahat odaları ve merkezi ulaşım avantajıyla kısa şehir gezileri için uygun bir konaklama seçeneğidir.",
                priceInfo: "Gecelik ortalama ₺2.500 - ₺4.000",
                features: ["Sahil yakını", "Aile uygun", "Kahvaltı", "Wi-Fi"],
                rating: 4.7,
                reviewCount: 128
            ),
            authStatus: .authenticated
        )
    }
}

import SwiftUI
import UIKit

struct AccommodationItem: Identifiable, Hashable {
    let id: String
    let cityId: String
    let name: String
    let type: String
    let district: String
    let address: String
    let shortDescription: String
    let longDescription: String
    let priceInfo: String
    let features: [String]
    let rating: Double
    let reviewCount: Int
}

struct AccommodationView: View {
    let cityId: String
    let authStatus: AppState.AuthStatus

    @State private var searchText = ""

    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    private var accommodations: [AccommodationItem] {
        [
            AccommodationItem(
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
            AccommodationItem(
                id: "atakum-butik-pansiyon",
                cityId: "samsun",
                name: "Atakum Butik Pansiyon",
                type: "Pansiyon",
                district: "Atakum",
                address: "Atakum / Samsun",
                shortDescription: "Ekonomik ve samimi atmosferiyle kısa konaklamalar için uygun pansiyon.",
                longDescription: "Atakum Butik Pansiyon, ekonomik konaklama arayan gezginler için sade, pratik ve ulaşımı kolay bir alternatiftir. Sahil ve yeme içme noktalarına yakınlığıyla öne çıkar.",
                priceInfo: "Gecelik ortalama ₺1.200 - ₺2.000",
                features: ["Ekonomik", "Merkezi", "Wi-Fi", "Kısa konaklama"],
                rating: 4.4,
                reviewCount: 74
            ),
            AccommodationItem(
                id: "ilkadim-sehir-otel",
                cityId: "samsun",
                name: "İlkadım Şehir Oteli",
                type: "Otel",
                district: "İlkadım",
                address: "İlkadım Merkez / Samsun",
                shortDescription: "Şehir merkezine yakın, ulaşımı kolay ve gezi rotaları için pratik otel.",
                longDescription: "İlkadım Şehir Oteli, şehir merkezinde kalmak isteyen kullanıcılar için ulaşım, restoran ve gezi noktalarına yakınlığıyla pratik bir konaklama deneyimi sunar.",
                priceInfo: "Gecelik ortalama ₺2.000 - ₺3.500",
                features: ["Merkezi", "Ulaşım kolay", "Kahvaltı", "İş seyahati"],
                rating: 4.5,
                reviewCount: 96
            ),
            AccommodationItem(
                id: "canik-aile-apart",
                cityId: "samsun",
                name: "Canik Aile Apart",
                type: "Apart",
                district: "Canik",
                address: "Canik / Samsun",
                shortDescription: "Aileler için uygun, apart konseptinde rahat konaklama seçeneği.",
                longDescription: "Canik Aile Apart, daha uzun konaklamalar veya aile seyahatleri için mutfaklı ve geniş alanlı konaklama arayan kullanıcılar için uygun bir seçenektir.",
                priceInfo: "Gecelik ortalama ₺1.800 - ₺3.000",
                features: ["Aile uygun", "Apart", "Mutfak", "Uzun konaklama"],
                rating: 4.6,
                reviewCount: 52
            )
        ]
    }

    private var filteredAccommodations: [AccommodationItem] {
        let cityItems = accommodations.filter { $0.cityId == cityId }

        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).localizedLowercase

        guard !query.isEmpty else {
            return cityItems
        }

        return cityItems.filter { item in
            [
                item.name,
                item.type,
                item.district,
                item.address,
                item.shortDescription,
                item.features.joined(separator: " ")
            ]
            .joined(separator: " ")
            .localizedLowercase
            .contains(query)
        }
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    headerView

                    searchSection

                    contentSection
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 120)
            }
            .scrollDismissesKeyboard(.interactively)
            .hideKeyboardOnTap()
        }
        .navigationTitle("Konaklama")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 6) {
            AppTag("Konaklama", iconName: "bed.double.fill")

            Text("Konaklama")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Text("Samsun’daki otel, pansiyon ve apart önerilerini keşfet.")
                .font(.system(size: 12.5, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)
        }
    }

    private var searchSection: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)

            TextField("Konaklama ara", text: $searchText)
                .font(.system(size: 12.5, weight: .regular))
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

            if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Button {
                    withAnimation {
                        searchText = ""
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, AppSpacing.md)
        .frame(height: 44)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.045), radius: 7, x: 0, y: 3)
    }

    @ViewBuilder
    private var contentSection: some View {
        if filteredAccommodations.isEmpty {
            EmptyStateView(
                title: "Konaklama bulunamadı",
                message: "Aramana uygun konaklama önerisi bulunamadı.",
                iconName: "bed.double"
            )
        } else {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                HStack {
                    Text("Öneriler")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)

                    Spacer()

                    Text("\(filteredAccommodations.count) seçenek")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(AppColors.teal)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 5)
                        .background(AppColors.cream)
                        .clipShape(Capsule())
                }

                LazyVGrid(columns: gridColumns, spacing: 10) {
                    ForEach(filteredAccommodations) { item in
                        NavigationLink {
                            AccommodationDetailView(
                                item: item,
                                authStatus: authStatus
                            )
                        } label: {
                            accommodationCard(item)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private func accommodationCard(_ item: AccommodationItem) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 17)
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
                    .frame(height: 108)

                Image(systemName: "bed.double.fill")
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.15))
                    .offset(x: 42, y: -18)

                VStack(alignment: .leading, spacing: 5) {
                    ZStack {
                        Circle()
                            .fill(AppColors.teal.opacity(0.86))
                            .frame(width: 31, height: 31)

                        Image(systemName: "bed.double.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    Text(item.name)
                        .font(.system(size: 12.5, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.78)

                    Text(item.type)
                        .font(.system(size: 9.5, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.86))
                        .lineLimit(1)
                }
                .padding(9)
            }

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundStyle(AppColors.teal)

                    Text(item.district)
                        .font(.system(size: 9.5, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(1)
                }

                Text(item.shortDescription)
                    .font(.system(size: 9.5, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(2)
                    .lineSpacing(1)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundStyle(AppColors.gold)

                    Text(String(format: "%.1f", item.rating))
                        .font(.system(size: 9.5, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)

                    Spacer()

                    Text(item.priceInfo)
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                        .lineLimit(1)
                }
            }
            .padding(9)
        }
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 17))
        .shadow(color: .black.opacity(0.055), radius: 7, x: 0, y: 3)
    }
}

#Preview {
    NavigationStack {
        AccommodationView(
            cityId: "samsun",
            authStatus: .authenticated
        )
    }
}

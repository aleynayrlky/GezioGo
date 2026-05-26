import SwiftUI
import UIKit

struct TransportationView: View {
    let cityId: String

    @State private var searchText = ""

    private var cityName: String {
        switch cityId.lowercased() {
        case "samsun":
            return "Samsun"
        default:
            return cityId.capitalized
        }
    }

    private var transportItems: [TransportItem] {
        [
            TransportItem(
                title: "Toplu Taşıma",
                subtitle: "Şehir içi ulaşım seçeneklerini incele",
                iconName: "bus.fill",
                detail: "Otobüs, tramvay, minibüs ve şehir içi ulaşım seçenekleri burada listelenecek.",
                status: "Rehber"
            ),
            TransportItem(
                title: "Tramvay",
                subtitle: "Samsun tramvay hattı bilgileri",
                iconName: "tram.fill",
                detail: "Hat durakları, güzergah bilgileri ve çalışma saatleri Firebase sonrası dinamik hale getirilecek.",
                status: "Yakında"
            ),
            TransportItem(
                title: "Otobüs Hatları",
                subtitle: "Şehir içi otobüs hatları",
                iconName: "bus.doubledecker.fill",
                detail: "Otobüs hatları, duraklar ve güzergah detayları resmi kaynaklardan alınarak gösterilecek.",
                status: "Yakında"
            ),
            TransportItem(
                title: "Duraklar",
                subtitle: "Yakındaki veya önemli duraklar",
                iconName: "mappin.and.ellipse",
                detail: "Kullanıcı konumuna göre yakın duraklar ileride burada gösterilecek.",
                status: "Planlandı"
            ),
            TransportItem(
                title: "Havalimanı Ulaşımı",
                subtitle: "Havalimanı ve şehir merkezi bağlantıları",
                iconName: "airplane.departure",
                detail: "Havalimanına ulaşım, servis, taksi ve toplu taşıma bilgileri burada yer alacak.",
                status: "Rehber"
            ),
            TransportItem(
                title: "Taksi / Transfer",
                subtitle: "Alternatif ulaşım seçenekleri",
                iconName: "car.fill",
                detail: "Taksi, özel transfer ve araç kiralama önerileri ileride bu alanda gösterilecek.",
                status: "Yakında"
            ),
            TransportItem(
                title: "Resmi Ulaşım Sitesi",
                subtitle: "Güncel bilgiler için resmi kaynak",
                iconName: "safari.fill",
                detail: "Her şehir için resmi ulaşım sitesi bağlantısı Firebase üzerinden yönetilecek.",
                status: "Bağlantı"
            )
        ]
    }

    private var filteredItems: [TransportItem] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).localizedLowercase

        guard !query.isEmpty else {
            return transportItems
        }

        return transportItems.filter { item in
            [
                item.title,
                item.subtitle,
                item.detail,
                item.status
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

                    infoBanner

                    transportGrid

                    officialSourceCard
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 120)
            }
            .scrollDismissesKeyboard(.interactively)
            .hideKeyboardOnTap()
        }
        .navigationTitle("Ulaşım")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 6) {
            AppTag("Ulaşım", iconName: "bus.fill")

            Text("\(cityName) ulaşım rehberi")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Text("Şehir içi ulaşım, duraklar, hatlar ve pratik ulaşım önerileri burada toplanacak.")
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

            TextField("Ulaşım bilgisi ara", text: $searchText)
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

    private var infoBanner: some View {
        HStack(alignment: .top, spacing: AppSpacing.sm) {
            ZStack {
                Circle()
                    .fill(AppColors.teal.opacity(0.14))
                    .frame(width: 38, height: 38)

                Image(systemName: "info.circle.fill")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Canlı veri daha sonra eklenecek")
                    .font(.system(size: 13.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Text("Firebase ve backend bağlantısından sonra şehirlerin resmi ulaşım kaynaklarından veriler düzenli olarak çekilecek.")
                    .font(.system(size: 11.5, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(2)
            }

            Spacer()
        }
        .padding(12)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.045), radius: 8, x: 0, y: 4)
    }

    private var transportGrid: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                Text("Ulaşım seçenekleri")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(filteredItems.count) başlık")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(AppColors.teal)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(AppColors.cream)
                    .clipShape(Capsule())
            }

            VStack(spacing: AppSpacing.sm) {
                ForEach(filteredItems) { item in
                    transportCard(item)
                }
            }
        }
    }

    private func transportCard(_ item: TransportItem) -> some View {
        HStack(alignment: .top, spacing: AppSpacing.sm) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
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
                    .frame(width: 48, height: 48)

                Image(systemName: item.iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.title)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(1)

                    Spacer()

                    Text(item.status)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(AppColors.teal)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppColors.cream)
                        .clipShape(Capsule())
                }

                Text(item.subtitle)
                    .font(.system(size: 11.5, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(1)

                Text(item.detail)
                    .font(.system(size: 10.8, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(2)
                    .lineLimit(2)
            }
        }
        .padding(12)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.045), radius: 8, x: 0, y: 4)
    }

    private var officialSourceCard: some View {
        Button {
            // Firebase sonrası şehir bazlı resmi ulaşım URL'si buradan açılacak.
        } label: {
            HStack(spacing: AppSpacing.sm) {
                Image(systemName: "link")
                    .font(.system(size: 15, weight: .semibold))

                Text("Resmi ulaşım bağlantıları Firebase sonrası aktif olacak")
                    .font(.system(size: 12.5, weight: .semibold))
                    .lineLimit(2)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .bold))
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

struct TransportItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let iconName: String
    let detail: String
    let status: String
}

#Preview {
    NavigationStack {
        TransportationView(cityId: "samsun")
    }
}

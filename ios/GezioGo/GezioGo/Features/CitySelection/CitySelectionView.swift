import SwiftUI

struct CitySelectionView: View {
    let onCitySelected: (City) -> Void

    @StateObject private var viewModel = CitySelectionViewModel()
    @State private var searchText = ""

    private let allCities: [String] = [
        "Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin",
        "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa",
        "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan",
        "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta",
        "Mersin", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir",
        "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla",
        "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt",
        "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak",
        "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman",
        "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"
    ]

    private var filteredCities: [String] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).localizedLowercase

        guard !query.isEmpty else {
            return allCities
        }

        return allCities.filter {
            $0.localizedLowercase.contains(query)
        }
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: AppSpacing.md) {
                headerView

                searchSection

                if viewModel.isLoading {
                    Spacer()

                    ProgressView("Şehirler yükleniyor...")
                        .font(AppTypography.body)
                        .frame(maxWidth: .infinity)

                    Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    errorSection(errorMessage)
                } else {
                    ScrollView {
                        LazyVStack(spacing: AppSpacing.sm) {
                            ForEach(filteredCities, id: \.self) { cityName in
                                if let city = availableCity(named: cityName) {
                                    availableCityCard(city)
                                } else {
                                    comingSoonCityCard(cityName)
                                }
                            }
                        }
                        .padding(.bottom, AppSpacing.xl)
                    }
                }
            }
            .padding(.horizontal, AppSpacing.lg)
            .padding(.top, AppSpacing.md)
        }
        .task {
            await viewModel.loadCities()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("Şehir seçimi", iconName: "mappin.and.ellipse")

            Text("Hangi şehri keşfetmek istersin?")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)
                .lineSpacing(1)

            Text("GezioGo Türkiye’nin 81 ilini keşfetmen için hazırlanıyor. Şimdilik aktif pilot şehir Samsun.")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(3)
        }
    }
    private var searchSection: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)

            TextField("Şehir ara", text: $searchText)
                .font(.system(size: 14, weight: .regular))
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()

            if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, AppSpacing.md)
        .frame(height: 48)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }

    private func availableCityCard(_ city: City) -> some View {
        Button {
            onCitySelected(city)
        } label: {
            HStack(spacing: AppSpacing.md) {
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
                        .frame(width: 50, height: 50)

                    Image(systemName: "location.fill")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(AppColors.gold)
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: AppSpacing.xs) {
                        Text(city.name)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.textPrimary)

                        Text("Aktif")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background(AppColors.teal)
                            .clipShape(Capsule())
                    }

                    Text(city.region)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(AppColors.teal)

                    Text(city.shortDescription)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)
            }
            .padding(.horizontal, AppSpacing.md)
            .padding(.vertical, 12)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(.plain)
    }

    private func comingSoonCityCard(_ cityName: String) -> some View {
        HStack(spacing: AppSpacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppColors.cream)
                    .frame(width: 50, height: 50)

                Image(systemName: "mappin")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary.opacity(0.7))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(cityName)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(1)

                Text("Yakında GezioGo’da")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)

                Text("Bu şehir için içerikler hazırlanıyor.")
                    .font(.system(size: 11, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(1)
            }

            Spacer()

            Text("Yakında")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(AppColors.petrol)
                .padding(.horizontal, 9)
                .padding(.vertical, 5)
                .background(AppColors.cream)
                .clipShape(Capsule())
        }
        .padding(.horizontal, AppSpacing.md)
        .padding(.vertical, 12)
        .background(AppColors.cardBackground.opacity(0.72))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .opacity(0.74)
    }

    private func errorSection(_ message: String) -> some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text("Bir sorun oluştu")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.error)

                Text(message)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)

                AppButton(title: "Tekrar Dene") {
                    Task {
                        await viewModel.loadCities()
                    }
                }
            }
        }
    }

    private func availableCity(named name: String) -> City? {
        viewModel.cities.first {
            $0.name.localizedLowercase == name.localizedLowercase
        }
    }
}

#Preview {
    CitySelectionView { _ in }
}

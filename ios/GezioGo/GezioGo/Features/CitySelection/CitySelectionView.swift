import SwiftUI

struct CitySelectionView: View {
    let onCitySelected: (City) -> Void

    @StateObject private var viewModel = CitySelectionViewModel()

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                headerView

                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Şehirler yükleniyor...")
                        .font(AppTypography.body)
                    Spacer()
                } else if let errorMessage = viewModel.errorMessage {
                    AppCard {
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            Text("Bir sorun oluştu")
                                .font(AppTypography.subtitle)
                                .foregroundStyle(AppColors.error)

                            Text(errorMessage)
                                .font(AppTypography.body)
                                .foregroundStyle(AppColors.textSecondary)

                            AppButton(title: "Tekrar Dene") {
                                Task {
                                    await viewModel.loadCities()
                                }
                            }
                        }
                    }

                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: AppSpacing.md) {
                            ForEach(viewModel.cities) { city in
                                cityCard(city)
                            }
                        }
                    }
                }
            }
            .padding(AppSpacing.lg)
        }
        .task {
            await viewModel.loadCities()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("İlk adım", iconName: "mappin.and.ellipse")

            Text("Hangi şehri keşfetmek istersin?")
                .font(AppTypography.title)
                .foregroundStyle(AppColors.textPrimary)

            Text("GezioGo şimdilik pilot şehir olarak Samsun ile başlıyor.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
        }
    }

    private func cityCard(_ city: City) -> some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text(city.name)
                            .font(AppTypography.subtitle)
                            .foregroundStyle(AppColors.textPrimary)

                        Text(city.region)
                            .font(AppTypography.captionMedium)
                            .foregroundStyle(AppColors.teal)
                    }

                    Spacer()

                    Image(systemName: "location.fill")
                        .font(.title2)
                        .foregroundStyle(AppColors.gold)
                }

                Text(city.shortDescription)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)

                AppButton(title: "\(city.name) ile Başla") {
                    onCitySelected(city)
                }
            }
        }
    }
}

#Preview {
    CitySelectionView { _ in }
}

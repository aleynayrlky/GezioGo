import SwiftUI

struct RootView: View {
    @StateObject private var appState = AppState()

    @State private var cities: [City] = []
    @State private var places: [Place] = []
    @State private var events: [Event] = []
    @State private var errorMessage: String?

    private let dataService: DataServiceProtocol = MockDataService()

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                VStack(spacing: AppSpacing.xs) {
                    Text("GezioGo")
                        .font(AppTypography.largeTitle)
                        .foregroundStyle(AppColors.petrol)

                    Text("Şehir seninle keşfedilir")
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                }

                if let errorMessage {
                    AppCard {
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            Text("Hata")
                                .font(AppTypography.subtitle)
                                .foregroundStyle(AppColors.error)

                            Text(errorMessage)
                                .font(AppTypography.body)
                                .foregroundStyle(AppColors.textSecondary)
                        }
                    }
                } else {
                    AppCard {
                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            Text(cities.first?.name ?? "Şehir yükleniyor...")
                                .font(AppTypography.subtitle)
                                .foregroundStyle(AppColors.textPrimary)

                            Text(cities.first?.shortDescription ?? "JSON verisi bekleniyor.")
                                .font(AppTypography.body)
                                .foregroundStyle(AppColors.textSecondary)

                            HStack {
                                AppTag("\(places.count) mekan", iconName: "mappin.and.ellipse")
                                AppTag("\(events.count) etkinlik", iconName: "calendar")
                            }
                        }
                    }

                    AppButton(title: "Mock Veriyi Yenile") {
                        Task {
                            await loadMockData()
                        }
                    }
                }
            }
            .padding(AppSpacing.lg)
        }
        .task {
            await loadMockData()
        }
    }

    private func loadMockData() async {
        do {
            cities = try await dataService.fetchCities()
            places = try await dataService.fetchPlaces(cityId: "samsun")
            events = try await dataService.fetchEvents(cityId: "samsun")
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    RootView()
}

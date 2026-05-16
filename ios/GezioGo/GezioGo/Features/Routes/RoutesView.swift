import SwiftUI

struct RoutesView: View {
    let cityId: String

    @Environment(\.navigate) private var navigate
    @StateObject private var viewModel: RoutesViewModel

    init(cityId: String) {
        self.cityId = cityId
        _viewModel = StateObject(
            wrappedValue: RoutesViewModel(cityId: cityId)
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
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle("Rotalar")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadRoutes()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("Rotalar", iconName: "map")

            Text("Hazır gezi planları")
                .font(AppTypography.title)
                .foregroundStyle(AppColors.textPrimary)

            Text("Samsun’u temalı rotalarla keşfet. Sahil, tarih, müze ve doğa odaklı gezi planlarını incele.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            LoadingView("Rotalar yükleniyor...")

        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(message: errorMessage) {
                Task {
                    await viewModel.loadRoutes()
                }
            }

        } else if viewModel.featuredRoutes.isEmpty {
            EmptyStateView(
                title: "Rota bulunamadı",
                message: "Bu şehir için henüz rota eklenmemiş. Daha sonra tekrar kontrol edebilirsin.",
                iconName: "map"
            )

        } else {
            routesList
        }
    }

    private var routesList: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Önerilen rotalar")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.featuredRoutes.count) rota")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            VStack(spacing: AppSpacing.md) {
                ForEach(viewModel.featuredRoutes) { route in
                    RouteCard(route: route) {
                        navigate(.routeDetail(route: route))
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RoutesView(cityId: "samsun")
    }
}

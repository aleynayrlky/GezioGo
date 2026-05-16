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
                    
                    searchSection
                    
                    interestFilterSection
                    
                    durationFilterSection

                    transportFilterSection

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
        .onAppear {
            viewModel.refreshSavedRoutes()
        }
        .onReceive(NotificationCenter.default.publisher(for: .savedRoutesDidChange)) { _ in
            viewModel.refreshSavedRoutes()
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
    
    private var searchSection: some View {
        SearchBarView(
            text: $viewModel.searchText,
            placeholder: "Rota, durak veya ilgi alanı ara"
        )
    }
    
    private var interestFilterSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("İlgi alanı")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                if viewModel.hasActiveFilters {
                    Button("Temizle") {
                        withAnimation {
                            viewModel.clearFilters()
                        }
                    }
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.sm) {
                    Button {
                        withAnimation {
                            viewModel.selectInterest(nil)
                        }
                    } label: {
                        filterChip(
                            title: "Tümü",
                            iconName: "square.grid.2x2",
                            isSelected: viewModel.selectedInterest == nil
                        )
                    }
                    .buttonStyle(.plain)

                    ForEach(viewModel.interestOptions, id: \.self) { interest in
                        Button {
                            withAnimation {
                                viewModel.selectInterest(interest)
                            }
                        } label: {
                            filterChip(
                                title: viewModel.interestDisplayName(interest),
                                iconName: interestIconName(interest),
                                isSelected: viewModel.selectedInterest == interest
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
    
    private var durationFilterSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Süre")
                .font(AppTypography.subtitle)
                .foregroundStyle(AppColors.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.sm) {
                    Button {
                        withAnimation {
                            viewModel.selectDurationType(nil)
                        }
                    } label: {
                        filterChip(
                            title: "Tümü",
                            iconName: "square.grid.2x2",
                            isSelected: viewModel.selectedDurationType == nil
                        )
                    }
                    .buttonStyle(.plain)

                    ForEach(viewModel.durationOptions, id: \.self) { durationType in
                        Button {
                            withAnimation {
                                viewModel.selectDurationType(durationType)
                            }
                        } label: {
                            filterChip(
                                title: viewModel.durationTypeText(durationType),
                                iconName: "clock",
                                isSelected: viewModel.selectedDurationType == durationType
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
    
    private var transportFilterSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Ulaşım")
                .font(AppTypography.subtitle)
                .foregroundStyle(AppColors.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.sm) {
                    Button {
                        withAnimation {
                            viewModel.selectTransportType(nil)
                        }
                    } label: {
                        filterChip(
                            title: "Tümü",
                            iconName: "square.grid.2x2",
                            isSelected: viewModel.selectedTransportType == nil
                        )
                    }
                    .buttonStyle(.plain)

                    ForEach(viewModel.transportOptions, id: \.self) { transportType in
                        Button {
                            withAnimation {
                                viewModel.selectTransportType(transportType)
                            }
                        } label: {
                            filterChip(
                                title: transportType.displayName,
                                iconName: transportIconName(transportType),
                                isSelected: viewModel.selectedTransportType == transportType
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
    
    private func filterChip(
        title: String,
        iconName: String,
        isSelected: Bool
    ) -> some View {
        HStack(spacing: AppSpacing.xs) {
            Image(systemName: iconName)
                .font(.caption)

            Text(title)
                .font(AppTypography.captionMedium)
        }
        .foregroundStyle(isSelected ? .white : AppColors.petrol)
        .padding(.horizontal, AppSpacing.md)
        .padding(.vertical, AppSpacing.sm)
        .background(isSelected ? AppColors.petrol : AppColors.cream)
        .clipShape(Capsule())
    }
    
    private func interestIconName(_ interest: String) -> String {
        switch interest {
        case "history":
            return "building.columns"
        case "nature":
            return "leaf"
        case "museum":
            return "building.2"
        case "food_drink":
            return "fork.knife"
        case "family":
            return "figure.and.child.holdinghands"
        case "culture":
            return "theatermasks"
        default:
            return "sparkles"
        }
    }
    
    private func transportIconName(_ transportType: TransportType) -> String {
        switch transportType {
        case .walking:
            return "figure.walk"
        case .publicTransport:
            return "tram"
        case .car:
            return "car"
        case .mixed:
            return "arrow.triangle.swap"
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
                title: viewModel.emptyStateTitle,
                message: viewModel.emptyStateMessage,
                iconName: "map",
                buttonTitle: viewModel.hasActiveFilters ? "Filtreleri Temizle" : nil
            ) {
                withAnimation {
                    viewModel.clearFilters()
                }
            }

        } else {
            routesList
        }
    }

    private var routesList: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text(viewModel.resultsTitle)
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.featuredRoutes.count) rota")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            VStack(spacing: AppSpacing.md) {
                ForEach(viewModel.featuredRoutes) { route in
                    RouteCard(
                        route: route,
                        isSaved: viewModel.isSaved(route)
                    ) {
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

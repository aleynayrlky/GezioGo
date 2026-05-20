import SwiftUI

struct PlaceListView: View {
    let cityId: String
    let category: PlaceCategory?
    
    @Environment(\.navigate) private var navigate
    @StateObject private var viewModel: PlaceListViewModel
    
    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    init(cityId: String, category: PlaceCategory? = nil) {
        self.cityId = cityId
        self.category = category
        _viewModel = StateObject(
            wrappedValue: PlaceListViewModel(
                cityId: cityId,
                category: category
            )
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
                    
                    contentSection
                }
                .padding(AppSpacing.lg)
                .padding(.bottom, 100)
            }
        }
        .navigationTitle(viewModel.screenTitle)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadPlaces()
        }
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            AppTag("Mekanlar", iconName: "mappin.and.ellipse")
            
            Text(viewModel.screenTitle)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)
            
            Text(viewModel.screenDescription)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(3)
        }
    }
    
    private var searchSection: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
            
            TextField("Bu listede ara", text: $viewModel.searchText)
                .font(.system(size: 14, weight: .regular))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            
            if viewModel.hasActiveSearch {
                Button {
                    withAnimation {
                        viewModel.clearSearch()
                    }
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
    
    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            LoadingView("Mekanlar yükleniyor...")
        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(message: errorMessage) {
                Task {
                    await viewModel.loadPlaces()
                }
            }
        } else if viewModel.filteredPlaces.isEmpty {
            EmptyStateView(
                title: viewModel.emptyStateTitle,
                message: viewModel.emptyStateMessage,
                iconName: "mappin.slash",
                buttonTitle: viewModel.hasActiveSearch ? "Aramayı Temizle" : nil
            ) {
                withAnimation {
                    viewModel.clearSearch()
                }
            }
        } else {
            placesGrid
        }
    }
    
    private var placesGrid: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text(viewModel.resultsTitle)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)
                
                Spacer()
                
                Text("\(viewModel.filteredPlaces.count) mekan")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(AppColors.teal)
            }
            
            LazyVGrid(columns: gridColumns, spacing: 12) {
                ForEach(viewModel.filteredPlaces) { place in
                    Button {
                        navigate(.placeDetail(place: place))
                    } label: {
                        placeGridCard(place)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    private func placeGridCard(_ place: Place) -> some View {
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

            Image(systemName: place.category.iconName)
                .font(.system(size: 58, weight: .semibold))
                .foregroundStyle(.white.opacity(0.14))
                .offset(x: 42, y: -22)

            VStack(alignment: .leading, spacing: 6) {
                ZStack {
                    Circle()
                        .fill(AppColors.teal.opacity(0.82))
                        .frame(width: 38, height: 38)

                    Image(systemName: place.category.iconName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                }

                Spacer()

                Text(place.name)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)

                Text(place.category.displayName)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.white.opacity(0.86))
                    .lineLimit(1)

                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 10, weight: .semibold))

                    Text(place.district)
                        .lineLimit(1)
                }
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(.white.opacity(0.82))
            }
            .padding(12)
        }
        .frame(height: 142)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    NavigationStack {
        PlaceListView(cityId: "samsun", category: .museum)
    }
}

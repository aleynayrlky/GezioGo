import SwiftUI
import UIKit

struct PlaceListView: View {
    let cityId: String
    let category: PlaceCategory?

    @Environment(\.navigate) private var navigate
    @StateObject private var viewModel: PlaceListViewModel

    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
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
        .navigationTitle(viewModel.screenTitle)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadPlaces()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 6) {
            AppTag("Mekanlar", iconName: "mappin.and.ellipse")

            Text(viewModel.screenTitle)
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)
                .lineLimit(2)

            Text(viewModel.screenDescription)
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

            TextField("Bu listede ara", text: $viewModel.searchText)
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

            if viewModel.hasActiveSearch {
                Button {
                    withAnimation {
                        viewModel.clearSearch()
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
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                Text(viewModel.resultsTitle)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.filteredPlaces.count) mekan")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(AppColors.teal)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(AppColors.cream)
                    .clipShape(Capsule())
            }

            LazyVGrid(columns: gridColumns, spacing: 10) {
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

                Image(systemName: place.category.iconName)
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.15))
                    .offset(x: 42, y: -18)

                VStack(alignment: .leading, spacing: 5) {
                    ZStack {
                        Circle()
                            .fill(AppColors.teal.opacity(0.86))
                            .frame(width: 31, height: 31)

                        Image(systemName: place.category.iconName)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    Text(place.name)
                        .font(.system(size: 12.5, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.78)

                    Text(place.category.displayName)
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

                    Text(place.district)
                        .font(.system(size: 9.5, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(1)
                }

                Text(place.shortDescription)
                    .font(.system(size: 9.5, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(2)
                    .lineSpacing(1)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundStyle(AppColors.gold)

                    Text("4.8")
                        .font(.system(size: 9.5, weight: .semibold))
                        .foregroundStyle(AppColors.textPrimary)

                    Spacer()

                    Text(place.priceType.displayName)
                        .font(.system(size: 9.5, weight: .semibold))
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
        PlaceListView(cityId: "samsun", category: .foodDrink)
    }
}

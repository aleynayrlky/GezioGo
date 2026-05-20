import SwiftUI
import UIKit

struct ExploreView: View {
    let cityId: String

    @StateObject private var viewModel: ExploreViewModel
    @State private var showComingSoonAlert = false
    @State private var selectedComingSoonTitle = ""

    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    init(cityId: String) {
        self.cityId = cityId
        _viewModel = StateObject(
            wrappedValue: ExploreViewModel(cityId: cityId)
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    topLogoSection

                    headerView

                    searchSection

                    filterSection

                    discoveryGridSection

                    recommendationsSection
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 110)
            }
            .scrollDismissesKeyboard(.interactively)
            .hideKeyboardOnTap()
        }
        .alert(selectedComingSoonTitle, isPresented: $showComingSoonAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text("Türkiye geneli kişiselleştirilmiş keşif önerileri yakında burada olacak.")
        }
    }

    private var topLogoSection: some View {
        HStack {
            HStack(spacing: 6) {
                Image("gezioGoLogoTransparent")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())

                HStack(spacing: 0) {
                    Text("Gezio")
                        .foregroundStyle(AppColors.petrol)

                    Text("Go")
                        .foregroundStyle(AppColors.gold)
                }
                .font(.system(size: 19, weight: .bold, design: .rounded))
            }

            Spacer()

            Button {
                showComingSoon("Bildirimler")
            } label: {
                Image(systemName: "bell")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
                    .frame(width: 40, height: 40)
                    .background(AppColors.cardBackground)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.08), radius: 9, x: 0, y: 4)
            }
            .buttonStyle(.plain)
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Keşfet")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Text("İlgi alanına göre yeni şehirler ve farklı keşif önerileri.")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)
        }
    }

    private var searchSection: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)

            TextField("Kategori, şehir veya mekan ara", text: $viewModel.searchText)
                .font(.system(size: 13, weight: .regular))
                .textInputAutocapitalization(.words)
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
                        viewModel.searchText = ""
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 15, weight: .semibold))
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

    private var filterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.sm) {
                filterChip(
                    title: "Tümü",
                    iconName: "square.grid.2x2.fill",
                    isSelected: viewModel.selectedCategoryId == nil
                ) {
                    withAnimation {
                        viewModel.selectCategory(nil)
                    }
                }

                ForEach(viewModel.discoveryCategories) { item in
                    filterChip(
                        title: item.shortFilterTitle,
                        iconName: item.iconName,
                        isSelected: viewModel.selectedCategoryId == item.id
                    ) {
                        withAnimation {
                            if viewModel.selectedCategoryId == item.id {
                                viewModel.selectCategory(nil)
                            } else {
                                viewModel.selectCategory(item.id)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 2)
        }
    }

    private func filterChip(
        title: String,
        iconName: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 6) {
                Image(systemName: iconName)
                    .font(.system(size: 11, weight: .semibold))

                Text(title)
                    .font(.system(size: 12, weight: .semibold))
            }
            .foregroundStyle(isSelected ? .white : AppColors.petrol)
            .padding(.horizontal, 11)
            .padding(.vertical, 8)
            .background(isSelected ? AppColors.teal : AppColors.cardBackground)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.045), radius: 6, x: 0, y: 3)
        }
        .buttonStyle(.plain)
    }

    private var discoveryGridSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                Text("Kategoriler")
                    .font(.system(size: 19, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                if viewModel.hasActiveFilters {
                    Button("Temizle") {
                        withAnimation {
                            viewModel.clearFilters()
                        }
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppColors.teal)
                }
            }

            if viewModel.filteredDiscoveryCategories.isEmpty {
                EmptyStateView(
                    title: "Sonuç bulunamadı",
                    message: "Aramana uygun keşif kategorisi bulunamadı.",
                    iconName: "magnifyingglass",
                    buttonTitle: "Filtreleri Temizle"
                ) {
                    withAnimation {
                        viewModel.clearFilters()
                    }
                }
            } else {
                LazyVGrid(columns: gridColumns, spacing: 12) {
                    ForEach(viewModel.filteredDiscoveryCategories) { item in
                        discoveryCategoryCard(item)
                    }
                }
            }
        }
    }

    private func discoveryCategoryCard(_ item: ExploreDiscoveryCategory) -> some View {
        Button {
            showComingSoon(item.title)
        } label: {
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

                Image(systemName: item.iconName)
                    .font(.system(size: 44, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.16))
                    .offset(x: 42, y: -22)

                VStack(alignment: .leading, spacing: 5) {
                    ZStack {
                        Circle()
                            .fill(AppColors.teal.opacity(0.85))
                            .frame(width: 34, height: 34)

                        Image(systemName: item.iconName)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                    }

                    Spacer()

                    Text(item.title)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.78)

                    Text(item.subtitle)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(.white.opacity(0.85))
                        .lineLimit(2)
                }
                .padding(10)
            }
            .frame(height: 126)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .shadow(color: .black.opacity(0.055), radius: 7, x: 0, y: 3)
        }
        .buttonStyle(.plain)
    }

    private var recommendationsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                Text("Sana Özel Öneriler")
                    .font(.system(size: 19, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Button {
                    showComingSoon("Sana Özel Öneriler")
                } label: {
                    HStack(spacing: 4) {
                        Text("Tümünü Gör")
                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppColors.teal)
                }
                .buttonStyle(.plain)
            }

            if viewModel.filteredRecommendations.isEmpty {
                EmptyStateView(
                    title: "Öneri bulunamadı",
                    message: "Aramana uygun öneri bulunamadı.",
                    iconName: "sparkles"
                )
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: AppSpacing.sm) {
                        ForEach(viewModel.filteredRecommendations) { item in
                            recommendationCard(item)
                        }
                    }
                }
            }
        }
    }

    private func recommendationCard(_ item: ExploreRecommendationItem) -> some View {
        Button {
            showComingSoon(item.title)
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppColors.teal.opacity(0.85),
                                    AppColors.petrol
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 92)

                    Image(systemName: item.iconName)
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.22))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    Image(systemName: "heart")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(8)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(1)

                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                        Text(item.cityName)
                            .lineLimit(1)
                    }
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(AppColors.gold)

                        Text(item.ratingText)

                        Spacer()

                        Text(item.categoryTitle)
                            .lineLimit(1)
                    }
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)
                }
                .padding(8)
            }
            .frame(width: 136)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.055), radius: 7, x: 0, y: 3)
        }
        .buttonStyle(.plain)
    }

    private func showComingSoon(_ title: String) {
        selectedComingSoonTitle = title
        showComingSoonAlert = true
    }
}

private extension ExploreDiscoveryCategory {
    var shortFilterTitle: String {
        switch id {
        case "food":
            return "Yeme & İçme"
        case "scenic":
            return "Manzara"
        case "popular":
            return "Popüler"
        default:
            return title
        }
    }
}

#Preview {
    ExploreView(cityId: "samsun")
}

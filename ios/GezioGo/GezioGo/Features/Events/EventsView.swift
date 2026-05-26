import SwiftUI
import UIKit

struct EventsView: View {
    let cityId: String

    @Environment(\.navigate) private var navigate
    @StateObject private var viewModel: EventsViewModel

    init(cityId: String) {
        self.cityId = cityId
        _viewModel = StateObject(
            wrappedValue: EventsViewModel(cityId: cityId)
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

                    quickFilterSection

                    searchSection

                    contentSection
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 120)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Etkinlikler")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadEvents()
        }
    }

    private var topLogoSection: some View {
        HStack {
            HStack(spacing: 6) {
                Image("gezioGoLogoTransparent")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
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
                navigate(.mapExplore(cityId: cityId))
            } label: {
                Image(systemName: "map.fill")
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
        VStack(alignment: .leading, spacing: 6) {
            Text("Etkinlikler")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Text("Samsun’daki yaklaşan etkinlikleri, konserleri ve şehir deneyimlerini keşfet.")
                .font(.system(size: 12.5, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(2)
        }
    }

    private var quickFilterSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.sm) {
                ForEach(viewModel.quickFilters, id: \.self) { filter in
                    Button {
                        withAnimation {
                            viewModel.selectQuickFilter(filter)
                        }
                    } label: {
                        quickFilterChip(
                            title: filter.title,
                            iconName: filter.iconName,
                            isSelected: viewModel.selectedQuickFilter == filter
                        )
                    }
                    .buttonStyle(.plain)
                }

                ForEach(viewModel.categories, id: \.self) { category in
                    Button {
                        withAnimation {
                            if viewModel.selectedCategory == category {
                                viewModel.selectCategory(nil)
                            } else {
                                viewModel.selectCategory(category)
                            }
                        }
                    } label: {
                        quickFilterChip(
                            title: category.displayName,
                            iconName: category.iconName,
                            isSelected: viewModel.selectedCategory == category
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func quickFilterChip(
        title: String,
        iconName: String,
        isSelected: Bool
    ) -> some View {
        HStack(spacing: 6) {
            Image(systemName: iconName)
                .font(.system(size: 12, weight: .semibold))

            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .lineLimit(1)
        }
        .foregroundStyle(isSelected ? .white : AppColors.petrol)
        .padding(.horizontal, 13)
        .padding(.vertical, 9)
        .background(isSelected ? AppColors.teal : AppColors.cardBackground)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(isSelected ? AppColors.teal : AppColors.border.opacity(0.6), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.04), radius: 7, x: 0, y: 3)
    }

    private var searchSection: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)

            TextField("Etkinlik, mekan veya kategori ara", text: $viewModel.searchText)
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
                        viewModel.searchText = ""
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
            LoadingView("Etkinlikler yükleniyor...")

        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(message: errorMessage) {
                Task {
                    await viewModel.loadEvents()
                }
            }

        } else if viewModel.upcomingEvents.isEmpty {
            EmptyStateView(
                title: viewModel.emptyStateTitle,
                message: viewModel.emptyStateMessage,
                iconName: "calendar.badge.exclamationmark",
                buttonTitle: viewModel.hasActiveFilters ? "Filtreleri Temizle" : nil
            ) {
                withAnimation {
                    viewModel.clearFilters()
                }
            }

        } else {
            eventsContent
        }
    }

    private var eventsContent: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            if let featuredEvent = viewModel.featuredEvent {
                featuredSection(featuredEvent)
            }

            allEventsSection
        }
    }

    private func featuredSection(_ event: Event) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack(spacing: 7) {
                Image(systemName: "star.fill")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(AppColors.gold)

                Text("Öne Çıkan Etkinlik")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)
            }

            EventCard(
                event: event,
                style: .featured
            ) {
                navigate(.eventDetail(event: event))
            }
        }
    }

    private var allEventsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            HStack {
                Text("Tüm Etkinlikler")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.listEvents.count) etkinlik")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(AppColors.teal)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(AppColors.cream)
                    .clipShape(Capsule())
            }

            VStack(spacing: AppSpacing.sm) {
                ForEach(viewModel.listEvents) { event in
                    EventCard(
                        event: event,
                        style: .compact
                    ) {
                        navigate(.eventDetail(event: event))
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EventsView(cityId: "samsun")
    }
}

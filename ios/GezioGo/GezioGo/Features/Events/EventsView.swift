import SwiftUI

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
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    headerView
                    
                    searchSection

                    contentSection
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle("Etkinlikler")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadEvents()
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("Etkinlikler", iconName: "calendar")

            Text("Şehirde neler var?")
                .font(AppTypography.title)
                .foregroundStyle(AppColors.textPrimary)

            Text("Samsun’daki yaklaşan etkinlikleri, kültür-sanat programlarını ve şehir deneyimlerini keşfet.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }
    
    private var searchSection: some View {
        SearchBarView(
            text: $viewModel.searchText,
            placeholder: "Etkinlik, mekan veya kategori ara"
        )
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
                buttonTitle: viewModel.hasActiveSearch ? "Aramayı Temizle" : nil
            ) {
                withAnimation {
                    viewModel.clearSearch()
                }
            }

        } else {
            eventsList
        }
    }

    private var eventsList: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text(viewModel.resultsTitle)
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.upcomingEvents.count) etkinlik")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            VStack(spacing: AppSpacing.md) {
                ForEach(viewModel.upcomingEvents) { event in
                    EventCard(event: event) {
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
}//
//  EventsView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 16.05.2026.
//


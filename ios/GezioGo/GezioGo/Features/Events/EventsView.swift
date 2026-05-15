import SwiftUI

struct EventsView: View {
    let cityId: String

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
                title: "Etkinlik bulunamadı",
                message: "Bu şehir için henüz etkinlik eklenmemiş. Daha sonra tekrar kontrol edebilirsin.",
                iconName: "calendar.badge.exclamationmark"
            )

        } else {
            eventsList
        }
    }

    private var eventsList: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            HStack {
                Text("Yaklaşan etkinlikler")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Spacer()

                Text("\(viewModel.upcomingEvents.count) etkinlik")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)
            }

            VStack(spacing: AppSpacing.md) {
                ForEach(viewModel.upcomingEvents) { event in
                    EventCard(event: event)
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


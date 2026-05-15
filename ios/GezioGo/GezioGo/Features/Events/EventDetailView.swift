import SwiftUI

struct EventDetailView: View {
    @StateObject private var viewModel: EventDetailViewModel

    init(event: Event) {
        _viewModel = StateObject(
            wrappedValue: EventDetailViewModel(event: event)
        )
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    heroSection

                    descriptionSection

                    infoSection

                    tagsSection

                    locationSection
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle(viewModel.event.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.xlarge)
                    .fill(
                        LinearGradient(
                            colors: [
                                AppColors.petrol,
                                AppColors.teal
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 220)

                VStack(spacing: AppSpacing.md) {
                    Image(systemName: viewModel.event.category.iconName)
                        .font(.system(size: 56, weight: .semibold))
                        .foregroundStyle(AppColors.gold)

                    Text(viewModel.event.category.displayName)
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(AppColors.cream)
                }
            }

            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                AppTag(
                    viewModel.event.category.displayName,
                    iconName: viewModel.event.category.iconName
                )

                Text(viewModel.event.title)
                    .font(AppTypography.title)
                    .foregroundStyle(AppColors.textPrimary)

                HStack(spacing: AppSpacing.xs) {
                    Image(systemName: "mappin.and.ellipse")
                    Text(viewModel.event.venueName)
                }
                .font(AppTypography.bodyMedium)
                .foregroundStyle(AppColors.teal)
            }
        }
    }

    private var descriptionSection: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Etkinlik hakkında")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Text(viewModel.event.description)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(4)
            }
        }
    }

    private var infoSection: some View {
        AppCard {
            VStack(spacing: AppSpacing.md) {
                PlaceInfoRow(
                    iconName: "calendar",
                    title: "Tarih",
                    value: viewModel.dateText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "clock",
                    title: "Saat",
                    value: viewModel.timeRangeText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "mappin.and.ellipse",
                    title: "Mekan",
                    value: viewModel.event.venueName
                )

                Divider()

                PlaceInfoRow(
                    iconName: "ticket",
                    title: "Ücret",
                    value: viewModel.event.priceInfo ?? viewModel.event.priceType.displayName
                )

                Divider()

                PlaceInfoRow(
                    iconName: "person.2",
                    title: "Organizatör",
                    value: viewModel.organizerText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "building.2",
                    title: "Alan Tipi",
                    value: viewModel.areaTypeText
                )
            }
        }
    }

    private var tagsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Özellikler")
                .font(AppTypography.subtitle)
                .foregroundStyle(AppColors.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.xs) {
                    AppTag(
                        viewModel.event.category.displayName,
                        iconName: viewModel.event.category.iconName
                    )

                    AppTag(viewModel.childFriendlyText, iconName: "figure.and.child.holdinghands")

                    if viewModel.event.isOutdoor {
                        AppTag("Açık hava", iconName: "leaf")
                    }

                    if viewModel.event.isIndoor {
                        AppTag("Kapalı alan", iconName: "building.2")
                    }

                    ForEach(viewModel.event.tags, id: \.self) { tag in
                        AppTag(tag)
                    }
                }
            }
        }
    }

    private var locationSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Konum")
                .font(AppTypography.subtitle)
                .foregroundStyle(AppColors.textPrimary)

            AppCard {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    PlaceInfoRow(
                        iconName: "mappin.and.ellipse",
                        title: "Adres",
                        value: viewModel.locationText
                    )

                    if viewModel.event.latitude != nil && viewModel.event.longitude != nil {
                        Divider()

                        Text("Etkinlik konumu harita ve yol tarifi desteği için hazır.")
                            .font(AppTypography.body)
                            .foregroundStyle(AppColors.textSecondary)
                            .lineSpacing(4)

                        AppTag("Yol tarifi yakında", iconName: "map")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EventDetailView(
            event: Event(
                id: "samsun-caz-festivali-2026",
                cityId: "samsun",
                title: "Samsun Caz Festivali",
                slug: "samsun-caz-festivali-2026",
                category: .festival,
                description: "Samsun’da caz müziğini şehirle buluşturan kültür-sanat etkinliği.",
                venueName: "Samsun Kültür Merkezi",
                placeId: nil,
                district: "İlkadım",
                address: "İlkadım / Samsun",
                latitude: 41.29,
                longitude: 36.33,
                startDate: "2026-06-20T20:00:00+03:00",
                endDate: "2026-06-20T23:00:00+03:00",
                priceType: .paid,
                priceInfo: "Güncel ücret bilgisi için bilet linki kontrol edilmelidir.",
                ticketUrl: nil,
                organizer: "Samsun Kültür Sanat",
                partnerId: "samsun-kultur-sanat",
                sourceUrl: nil,
                imageUrl: nil,
                imageUrls: [],
                tags: ["caz", "festival", "konser", "kültür sanat"],
                isChildFriendly: false,
                isIndoor: true,
                isOutdoor: false,
                contentStatus: .published,
                createdBy: "system-admin",
                approvedBy: "system-admin",
                lastVerifiedAt: "2026-05-15",
                createdAt: "2026-05-15T00:00:00+03:00",
                updatedAt: "2026-05-15T00:00:00+03:00"
            )
        )
    }
}//
//  EventDetailView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 16.05.2026.
//


import SwiftUI

struct PlaceDetailView: View {
    @StateObject private var viewModel: PlaceDetailViewModel

    init(place: Place) {
        _viewModel = StateObject(
            wrappedValue: PlaceDetailViewModel(place: place)
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

                    mapSection
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle(viewModel.place.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.toggleFavorite()
                } label: {
                    Image(systemName: viewModel.favoriteButtonIcon)
                        .foregroundStyle(viewModel.isFavorite ? AppColors.gold : AppColors.petrol)
                }
                .accessibilityLabel(viewModel.favoriteButtonTitle)
            }
        }
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
                    Image(systemName: viewModel.place.category.iconName)
                        .font(.system(size: 56, weight: .semibold))
                        .foregroundStyle(AppColors.gold)

                    Text(viewModel.place.category.displayName)
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(AppColors.cream)
                }
            }

            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                AppTag(viewModel.place.category.displayName, iconName: viewModel.place.category.iconName)

                Text(viewModel.place.name)
                    .font(AppTypography.title)
                    .foregroundStyle(AppColors.textPrimary)

                HStack(spacing: AppSpacing.xs) {
                    Image(systemName: "mappin.and.ellipse")
                    Text(viewModel.place.district)
                }
                .font(AppTypography.bodyMedium)
                .foregroundStyle(AppColors.teal)
            }
        }
    }

    private var descriptionSection: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Hakkında")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Text(viewModel.place.longDescription ?? viewModel.place.shortDescription)
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
                    iconName: "mappin.and.ellipse",
                    title: "Adres",
                    value: viewModel.place.address
                )

                Divider()

                PlaceInfoRow(
                    iconName: "clock",
                    title: "Ziyaret Süresi",
                    value: viewModel.durationText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "calendar",
                    title: "Açılış Saatleri",
                    value: viewModel.place.openingHours ?? "Saat bilgisi yok"
                )

                Divider()

                PlaceInfoRow(
                    iconName: "ticket",
                    title: "Ücret",
                    value: viewModel.place.priceInfo ?? viewModel.place.priceType.displayName
                )

                Divider()

                PlaceInfoRow(
                    iconName: "figure.walk",
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
                    if viewModel.isFavorite {
                        AppTag("Favorilerde", iconName: "heart.fill")
                    }
                    AppTag(viewModel.childFriendlyText, iconName: "figure.and.child.holdinghands")
                    AppTag(viewModel.studentFriendlyText, iconName: "graduationcap")
                    AppTag(viewModel.accessibilityText, iconName: "accessibility")

                    ForEach(viewModel.place.tags, id: \.self) { tag in
                        AppTag(tag)
                    }
                }
            }
        }
    }

    private var mapSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Konum")
                .font(AppTypography.subtitle)
                .foregroundStyle(AppColors.textPrimary)

            PlaceMapPreview(place: viewModel.place)

            AppButton(title: "Yol Tarifi Al", style: .outline) {
                print("Yol tarifi: \(viewModel.place.latitude), \(viewModel.place.longitude)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        PlaceDetailView(
            place: Place(
                id: "atakum-sahili",
                cityId: "samsun",
                name: "Atakum Sahili",
                slug: "atakum-sahili",
                category: .nature,
                subCategory: nil,
                shortDescription: "Samsun’un sahil yürüyüşü, kafe ve gün batımı deneyimiyle öne çıkan noktalarından biri.",
                longDescription: "Atakum Sahili; yürüyüş yolu, kafe ve restoranları, deniz manzarası ve sosyal yaşam alanlarıyla şehirde keyifli vakit geçirmek isteyen kullanıcılar için güçlü bir duraktır.",
                district: "Atakum",
                address: "Atakum Sahil Yolu, Atakum / Samsun",
                latitude: 41.34,
                longitude: 36.25,
                openingHours: "Günün her saati açık alan",
                priceType: .free,
                priceInfo: "Açık alan ücretsizdir.",
                ticketUrl: nil,
                sourceUrl: nil,
                imageUrls: [],
                tags: ["sahil", "yürüyüş", "doğa"],
                isIndoor: false,
                isOutdoor: true,
                isChildFriendly: true,
                isStudentFriendly: true,
                isAccessible: true,
                averageVisitDurationMinutes: 90,
                partnerId: nil,
                contentStatus: .published,
                createdBy: nil,
                approvedBy: nil,
                lastVerifiedAt: nil,
                createdAt: "",
                updatedAt: ""
            )
        )
    }
}//
//  PlaceDetailView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


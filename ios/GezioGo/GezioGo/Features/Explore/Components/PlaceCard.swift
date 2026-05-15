//
//  PlaceCard.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//

import SwiftUI

struct PlaceCard: View {
    let place: Place

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                topRow

                Text(place.shortDescription)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(3)

                tagRow
            }
        }
    }

    private var topRow: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.medium)
                    .fill(AppColors.cream)
                    .frame(width: 52, height: 52)

                Image(systemName: place.category.iconName)
                    .font(.title3)
                    .foregroundStyle(AppColors.petrol)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(place.name)
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                HStack(spacing: AppSpacing.xs) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption)

                    Text(place.district)
                        .font(AppTypography.captionMedium)
                }
                .foregroundStyle(AppColors.teal)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, AppSpacing.xs)
        }
    }

    private var tagRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.xs) {
                AppTag(place.category.displayName)
                AppTag(place.priceType.displayName)

                if place.isChildFriendly {
                    AppTag("Çocukla uygun", iconName: "figure.and.child.holdinghands")
                }

                if place.isOutdoor {
                    AppTag("Açık alan", iconName: "leaf")
                }
            }
        }
    }
}

#Preview {
    PlaceCard(
        place: Place(
            id: "atakum-sahili",
            cityId: "samsun",
            name: "Atakum Sahili",
            slug: "atakum-sahili",
            category: .nature,
            subCategory: nil,
            shortDescription: "Samsun’un sahil yürüyüşü, kafe ve gün batımı deneyimiyle öne çıkan noktalarından biri.",
            longDescription: nil,
            district: "Atakum",
            address: "Atakum / Samsun",
            latitude: 41.34,
            longitude: 36.25,
            openingHours: nil,
            priceType: .free,
            priceInfo: nil,
            ticketUrl: nil,
            sourceUrl: nil,
            imageUrls: [],
            tags: [],
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
    .padding()
    .background(AppColors.background)
}

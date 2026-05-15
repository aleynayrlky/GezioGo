import SwiftUI

struct PlaceMapPreview: View {
    let place: Place

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: AppRadius.large)
                .fill(
                    LinearGradient(
                        colors: [
                            AppColors.teal.opacity(0.18),
                            AppColors.gold.opacity(0.20)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 180)

            VStack(spacing: AppSpacing.sm) {
                Image(systemName: "map.fill")
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)

                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(AppColors.gold)
            }
            .frame(maxWidth: .infinity, maxHeight: 180)

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text("Harita önizleme")
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.petrol)

                Text(place.address)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(2)
            }
            .padding(AppSpacing.md)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
            .padding(AppSpacing.md)
        }
    }
}

#Preview {
    PlaceMapPreview(
        place: Place(
            id: "atakum-sahili",
            cityId: "samsun",
            name: "Atakum Sahili",
            slug: "atakum-sahili",
            category: .nature,
            subCategory: nil,
            shortDescription: "Samsun’un sahil yürüyüşü ve gün batımıyla öne çıkan noktası.",
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
}//
//  PlaceMapPreview.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


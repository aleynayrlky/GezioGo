import SwiftUI

struct FeaturedPlaceCard: View {
    let place: Place
    let isFavorite: Bool

    init(place: Place, isFavorite: Bool = false) {
        self.place = place
        self.isFavorite = isFavorite
    }

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text(place.name)
                            .font(AppTypography.bodyMedium)
                            .foregroundStyle(AppColors.textPrimary)

                        Text(place.district)
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.teal)
                    }

                    Spacer()

                    VStack(spacing: AppSpacing.xs) {
                        FavoriteBadge(isFavorite: isFavorite)

                        Image(systemName: place.category.iconName)
                            .foregroundStyle(AppColors.gold)
                    }
                }

                Text(place.shortDescription)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(2)

                HStack {
                    AppTag(place.category.displayName)
                    AppTag(place.priceType.displayName)

                    if isFavorite {
                        AppTag("Favorilerde", iconName: "heart.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    FeaturedPlaceCard(
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
        ),
        isFavorite: true
    )
    .padding()
    .background(AppColors.background)
}

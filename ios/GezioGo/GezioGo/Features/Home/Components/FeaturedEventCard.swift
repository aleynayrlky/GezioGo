import SwiftUI

struct FeaturedEventCard: View {
    let event: Event

    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            dateBox

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(event.title)
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)

                HStack(spacing: AppSpacing.xs) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption)

                    Text(event.venueName)
                        .font(AppTypography.caption)
                        .lineLimit(1)
                }
                .foregroundStyle(AppColors.textSecondary)

                HStack(spacing: AppSpacing.xs) {
                    AppTag(event.category.displayName, iconName: event.category.iconName)

                    if !event.startDate.gezioFormattedTime.isEmpty {
                        AppTag(event.startDate.gezioFormattedTime, iconName: "clock")
                    }
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(AppColors.textSecondary)
                .padding(.top, AppSpacing.xs)
        }
    }

    private var dateBox: some View {
        VStack(spacing: 0) {
            Text(dayText)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Text(monthText)
                .font(.system(size: 9, weight: .semibold, design: .rounded))
                .foregroundStyle(AppColors.cream)
        }
        .frame(width: 48, height: 48)
        .background(AppColors.petrol)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
    }

    private var dayText: String {
        let formattedDate = event.startDate.gezioFormattedDate
        return formattedDate.components(separatedBy: " ").first ?? ""
    }

    private var monthText: String {
        let formattedDate = event.startDate.gezioFormattedDate
        let components = formattedDate.components(separatedBy: " ")

        guard components.count > 1 else {
            return ""
        }

        return String(components[1].prefix(3)).uppercased()
    }
}

#Preview {
    FeaturedEventCard(
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
    .padding()
    .background(AppColors.background)
}

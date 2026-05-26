import SwiftUI

struct PlaceMapPreview: View {
    let place: Place

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            AppColors.teal.opacity(0.16),
                            AppColors.gold.opacity(0.18)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 138)

            ZStack {
                Image(systemName: "map.fill")
                    .font(.system(size: 58, weight: .semibold))
                    .foregroundStyle(AppColors.teal.opacity(0.20))

                Image("gezioGoLogoTransparent")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 62, height: 62)
                    .clipShape(Circle())
                    .shadow(color: AppColors.petrol.opacity(0.16), radius: 10, x: 0, y: 6)
            }
            .frame(maxWidth: .infinity, maxHeight: 138)

            VStack(alignment: .leading, spacing: 3) {
                Text("Harita önizleme")
                    .font(.system(size: 11.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.petrol)

                Text(place.address)
                    .font(.system(size: 10.5, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(2)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(10)

            VStack {
                Spacer()

                HStack {
                    Spacer()

                    Image(systemName: "location.fill")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(AppColors.petrol)
                        .frame(width: 38, height: 38)
                        .background(AppColors.cardBackground)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                        .padding(12)
                }
            }
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
}

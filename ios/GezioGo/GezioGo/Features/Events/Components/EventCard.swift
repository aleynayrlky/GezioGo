import SwiftUI

struct EventCard: View {
    let event: Event
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            AppCard {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    topRow

                    Text(event.description)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)

                    dateCard

                    infoRow

                    tagRow
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(action == nil)
    }

    private var topRow: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            iconBox

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(event.title)
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)

                HStack(spacing: AppSpacing.xs) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption)

                    Text(event.venueName)
                        .font(AppTypography.captionMedium)
                        .lineLimit(1)
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

    private var iconBox: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppRadius.medium)
                .fill(
                    LinearGradient(
                        colors: [
                            AppColors.cream,
                            AppColors.gold.opacity(0.18)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 56, height: 56)

            Image(systemName: event.category.iconName)
                .font(.title3)
                .foregroundStyle(AppColors.petrol)
        }
    }

    private var dateCard: some View {
        HStack(spacing: AppSpacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.medium)
                    .fill(AppColors.petrol)
                    .frame(width: 56, height: 56)

                VStack(spacing: 0) {
                    Text(dayText)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Text(monthText)
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppColors.cream)
                }
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(event.startDate.gezioFormattedDate)
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)

                if !event.startDate.gezioFormattedTime.isEmpty {
                    Text(event.startDate.gezioFormattedTime)
                        .font(AppTypography.captionMedium)
                        .foregroundStyle(AppColors.teal)
                }
            }

            Spacer()

            AppTag(event.priceType.displayName, iconName: "ticket")
        }
        .padding(AppSpacing.sm)
        .background(AppColors.cream.opacity(0.65))
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
    }

    private var infoRow: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            if let district = event.district {
                infoItem(
                    icon: "location",
                    text: district
                )
            }

            if let organizer = event.organizer {
                infoItem(
                    icon: "person.2",
                    text: organizer
                )
            }

            infoItem(
                icon: event.isOutdoor ? "leaf" : "building.2",
                text: event.isOutdoor ? "Açık hava etkinliği" : "Kapalı alan etkinliği"
            )
        }
    }

    private func infoItem(icon: String, text: String) -> some View {
        HStack(spacing: AppSpacing.xs) {
            Image(systemName: icon)
                .font(.caption)

            Text(text)
                .font(AppTypography.caption)
                .lineLimit(1)
        }
        .foregroundStyle(AppColors.textSecondary)
    }

    private var tagRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.xs) {
                AppTag(event.category.displayName, iconName: event.category.iconName)

                if event.isChildFriendly {
                    AppTag("Çocukla uygun", iconName: "figure.and.child.holdinghands")
                }

                if event.isOutdoor {
                    AppTag("Açık hava", iconName: "leaf")
                }

                if event.isIndoor {
                    AppTag("Kapalı alan", iconName: "building.2")
                }
            }
        }
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
    EventCard(
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

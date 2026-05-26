import SwiftUI

enum EventCardStyle {
    case featured
    case compact
}

struct EventCard: View {
    let event: Event
    var style: EventCardStyle = .compact
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            switch style {
            case .featured:
                featuredCard
            case .compact:
                compactCard
            }
        }
        .buttonStyle(.plain)
        .disabled(action == nil)
    }

    private var featuredCard: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(
                        LinearGradient(
                            colors: [
                                AppColors.teal,
                                AppColors.petrol
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Image(systemName: event.category.iconName)
                    .font(.system(size: 46, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.16))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                Text("ÖNE ÇIKAN")
                    .font(.system(size: 8, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 4)
                    .background(AppColors.gold)
                    .clipShape(Capsule())
                    .padding(8)
            }
            .frame(width: 128, height: 158)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 18,
                    bottomLeadingRadius: 18,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 0
                )
            )

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(dayText)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.petrol)

                        Text(monthText)
                            .font(.system(size: 9.5, weight: .semibold, design: .rounded))
                            .foregroundStyle(AppColors.textSecondary)
                    }

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 9.5, weight: .semibold))

                        Text(event.startDate.gezioFormattedTime)
                            .font(.system(size: 10, weight: .medium))
                    }
                    .foregroundStyle(AppColors.textSecondary)
                }

                Text(event.title)
                    .font(.system(size: 13.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.82)

                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 9.5, weight: .semibold))

                    Text(event.venueName)
                        .font(.system(size: 10, weight: .medium))
                        .lineLimit(1)
                }
                .foregroundStyle(AppColors.teal)

                Text(event.description)
                    .font(.system(size: 9.8, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(2)
                    .lineSpacing(1)

                Spacer()

                HStack(spacing: 5) {
                    Image(systemName: "ticket.fill")
                        .font(.system(size: 10.5, weight: .semibold))

                    Text(event.priceType == .free ? "Detayları Gör" : "Bilet Al")
                        .font(.system(size: 11.5, weight: .bold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 32)
                .background(AppColors.gold)
                .clipShape(RoundedRectangle(cornerRadius: 11))
            }
            .padding(11)
            .frame(height: 158)
        }
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.055), radius: 8, x: 0, y: 4)
    }

    private var compactCard: some View {
        HStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 17)
                    .fill(
                        LinearGradient(
                            colors: [
                                AppColors.teal,
                                AppColors.petrol
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Image(systemName: event.category.iconName)
                    .font(.system(size: 38, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.18))
            }
            .frame(width: 96, height: 104)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 17,
                    bottomLeadingRadius: 17,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 0
                )
            )

            HStack(spacing: 10) {
                VStack(spacing: 1) {
                    Text(dayText)
                        .font(.system(size: 23, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.petrol)

                    Text(monthText)
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppColors.textSecondary)

                    Text(weekdayText)
                        .font(.system(size: 9, weight: .semibold, design: .rounded))
                        .foregroundStyle(AppColors.textSecondary.opacity(0.8))
                }
                .frame(width: 42)

                Divider()
                    .frame(height: 58)

                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 5) {
                        Image(systemName: "clock")
                            .font(.system(size: 10, weight: .semibold))

                        Text(event.startDate.gezioFormattedTime)
                            .font(.system(size: 10.5, weight: .medium))
                    }
                    .foregroundStyle(AppColors.textSecondary)

                    Text(event.title)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(1)

                    HStack(spacing: 5) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 10, weight: .semibold))

                        Text(event.venueName)
                            .font(.system(size: 10.5, weight: .regular))
                            .lineLimit(1)
                    }
                    .foregroundStyle(AppColors.teal)

                    Text(event.description)
                        .font(.system(size: 10.5, weight: .regular))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(2)
                        .lineSpacing(1)
                }

                Spacer()

                Text(event.priceType == .free ? "Detay" : "Bilet Al")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 9)
                    .background(AppColors.gold)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 12)
            .frame(height: 104)
        }
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 17))
        .shadow(color: .black.opacity(0.055), radius: 8, x: 0, y: 4)
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

    private var weekdayText: String {
        guard let date = eventDate else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "EEE"

        return formatter.string(from: date).uppercased()
    }

    private var eventDate: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]

        if let date = formatter.date(from: event.startDate) {
            return date
        }

        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: event.startDate)
    }
}

#Preview {
    VStack(spacing: 16) {
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
            ),
            style: .featured
        )

        EventCard(
            event: Event(
                id: "samsun-sahil-yuruyusu-2026",
                cityId: "samsun",
                title: "Sahil Yürüyüşü Etkinliği",
                slug: "samsun-sahil-yuruyusu-2026",
                category: .sports,
                description: "Atakum sahilinde düzenlenen açık hava yürüyüş etkinliği.",
                venueName: "Atakum Sahili",
                placeId: "atakum-sahili",
                district: "Atakum",
                address: "Atakum Sahil Yolu, Samsun",
                latitude: 41.34,
                longitude: 36.25,
                startDate: "2026-06-22T09:00:00+03:00",
                endDate: "2026-06-22T11:00:00+03:00",
                priceType: .free,
                priceInfo: "Ücretsiz açık hava etkinliği.",
                ticketUrl: nil,
                organizer: "Samsun Büyükşehir Belediyesi",
                partnerId: "samsun-buyuksehir-belediyesi",
                sourceUrl: nil,
                imageUrl: nil,
                imageUrls: [],
                tags: ["sahil", "spor", "yürüyüş", "ücretsiz"],
                isChildFriendly: true,
                isIndoor: false,
                isOutdoor: true,
                contentStatus: .published,
                createdBy: "system-admin",
                approvedBy: "system-admin",
                lastVerifiedAt: "2026-05-15",
                createdAt: "2026-05-15T00:00:00+03:00",
                updatedAt: "2026-05-15T00:00:00+03:00"
            ),
            style: .compact
        )
    }
    .padding()
    .background(AppColors.background)
}

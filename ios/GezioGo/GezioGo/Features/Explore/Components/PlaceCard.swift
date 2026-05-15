import SwiftUI

struct PlaceCard: View {
    let place: Place
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            AppCard {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    topRow

                    Text(place.shortDescription)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)

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
                Text(place.name)
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)

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

            Image(systemName: place.category.iconName)
                .font(.title3)
                .foregroundStyle(AppColors.petrol)
        }
    }

    private var infoRow: some View {
        HStack(spacing: AppSpacing.md) {
            infoItem(
                icon: "clock",
                text: durationText
            )

            infoItem(
                icon: "ticket",
                text: place.priceType.displayName
            )

            if place.isAccessible {
                infoItem(
                    icon: "figure.roll",
                    text: "Erişilebilir"
                )
            }
        }
    }

    private func infoItem(icon: String, text: String) -> some View {
        HStack(spacing: AppSpacing.xxs) {
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
                AppTag(place.category.displayName)

                if place.isChildFriendly {
                    AppTag("Çocukla uygun", iconName: "figure.and.child.holdinghands")
                }

                if place.isStudentFriendly {
                    AppTag("Öğrenci dostu", iconName: "graduationcap")
                }

                if place.isOutdoor {
                    AppTag("Açık alan", iconName: "leaf")
                }

                if place.isIndoor {
                    AppTag("Kapalı alan", iconName: "building.2")
                }
            }
        }
    }

    private var durationText: String {
        guard let minutes = place.averageVisitDurationMinutes else {
            return "Süre bilinmiyor"
        }

        if minutes < 60 {
            return "\(minutes) dk"
        } else if minutes == 60 {
            return "1 saat"
        } else {
            let hour = minutes / 60
            let remaining = minutes % 60

            if remaining == 0 {
                return "\(hour) saat"
            } else {
                return "\(hour)s \(remaining)dk"
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

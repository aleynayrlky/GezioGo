import SwiftUI

struct FeaturedRouteCard: View {
    var body: some View {
        AppCard {
            HStack(alignment: .center, spacing: AppSpacing.md) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(AppColors.petrol)
                        .frame(width: 48, height: 48)

                    Image(systemName: "map.fill")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(AppColors.gold)
                }

                VStack(alignment: .leading, spacing: 7) {
                    Text("Şehri hazır planlarla gez")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(AppColors.textPrimary)
                        .lineLimit(1)

                    Text("Tarih, doğa ve sahil odaklı gezi rotalarını incele.")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(AppColors.textSecondary)
                        .lineSpacing(2)
                        .lineLimit(2)

                    HStack(spacing: AppSpacing.xs) {
                        routeTag("Rotalar", iconName: "map")
                        routeTag("AI rota", iconName: "wand.and.stars")
                    }
                    .padding(.top, 2)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
    }

    private func routeTag(_ title: String, iconName: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: iconName)
                .font(.system(size: 10, weight: .semibold))

            Text(title)
                .font(.system(size: 11, weight: .semibold))
                .lineLimit(1)
        }
        .foregroundStyle(AppColors.petrol)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(AppColors.cream)
        .clipShape(Capsule())
    }
}

#Preview {
    FeaturedRouteCard()
        .padding()
        .background(AppColors.background)
}

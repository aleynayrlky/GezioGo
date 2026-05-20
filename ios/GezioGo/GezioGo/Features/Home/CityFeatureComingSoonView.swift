import SwiftUI

struct CityFeatureComingSoonView: View {
    let cityId: String
    let title: String
    let iconName: String
    let message: String

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppColors.teal.opacity(0.18),
                                    AppColors.gold.opacity(0.16)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 96, height: 96)

                    Image(systemName: iconName)
                        .font(.system(size: 38, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                }

                VStack(spacing: AppSpacing.sm) {
                    Text(title)
                        .font(AppTypography.title)
                        .foregroundStyle(AppColors.textPrimary)

                    Text(message)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, AppSpacing.lg)
                }

                AppTag("Yakında gelecek", iconName: "sparkles")
            }
            .padding(AppSpacing.lg)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CityFeatureComingSoonView(
            cityId: "samsun",
            title: "Konaklama",
            iconName: "bed.double.fill",
            message: "Yakında Samsun içindeki otel, pansiyon ve konaklama önerileri burada yer alacak."
        )
    }
}

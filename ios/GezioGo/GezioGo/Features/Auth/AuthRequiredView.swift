import SwiftUI

struct AuthRequiredView: View {
    let title: String
    let message: String
    let buttonTitle: String
    let onAuthTap: () -> Void

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                ZStack {
                    Circle()
                        .fill(AppColors.cream)
                        .frame(width: 88, height: 88)

                    Image(systemName: "lock.fill")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                }

                VStack(spacing: AppSpacing.sm) {
                    Text(title)
                        .font(AppTypography.title)
                        .foregroundStyle(AppColors.textPrimary)
                        .multilineTextAlignment(.center)

                    Text(message)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }

                AppButton(title: buttonTitle) {
                    onAuthTap()
                }
            }
            .padding(AppSpacing.lg)
        }
    }
}

#Preview {
    AuthRequiredView(
        title: "Favorilerini görmek için giriş yap",
        message: "Favori mekanlarını ve kaydettiğin rotaları hesabında saklamak için giriş yap veya üye ol.",
        buttonTitle: "Giriş Yap / Üye Ol",
        onAuthTap: {}
    )
}

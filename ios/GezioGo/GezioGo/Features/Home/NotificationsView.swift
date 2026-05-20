import SwiftUI

struct NotificationsView: View {
    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                ZStack {
                    Circle()
                        .fill(AppColors.cream)
                        .frame(width: 96, height: 96)

                    Image(systemName: "bell")
                        .font(.system(size: 38, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                }

                VStack(spacing: AppSpacing.sm) {
                    Text("Bildirimler")
                        .font(AppTypography.title)
                        .foregroundStyle(AppColors.textPrimary)

                    Text("Yakında burada sana özel keşif önerileri, etkinlik hatırlatmaları ve rota bildirimleri yer alacak.")
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
        .navigationTitle("Bildirimler")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NotificationsView()
    }
}

import SwiftUI

struct StartupSplashView: View {
    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.md) {
                Image("gezioGoLogoTransparent")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 96, height: 96)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.10), radius: 14, x: 0, y: 8)

                HStack(spacing: 0) {
                    Text("Gezio")
                        .foregroundStyle(AppColors.petrol)

                    Text("Go")
                        .foregroundStyle(AppColors.gold)
                }
                .font(.system(size: 34, weight: .bold, design: .rounded))

                Text("Şehri keşfetmeye hazırlanıyor...")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(AppColors.textSecondary)

                ProgressView()
                    .tint(AppColors.teal)
                    .padding(.top, AppSpacing.sm)
            }
        }
    }
}

#Preview {
    StartupSplashView()
}

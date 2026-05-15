import SwiftUI

struct RootView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                VStack(spacing: AppSpacing.xs) {
                    Text("GezioGo")
                        .font(AppTypography.largeTitle)
                        .foregroundStyle(AppColors.petrol)

                    Text("Şehir seninle keşfedilir")
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                }

                AppCard {
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Bugünkü görev tamamlanıyor")
                            .font(AppTypography.subtitle)
                            .foregroundStyle(AppColors.textPrimary)

                        Text("Design system dosyaları hazırlandı. Artık ekranlar aynı renk, buton ve kart diliyle tasarlanacak.")
                            .font(AppTypography.body)
                            .foregroundStyle(AppColors.textSecondary)

                        HStack {
                            AppTag("SwiftUI", iconName: "swift")
                            AppTag("Design System", iconName: "paintpalette")
                        }
                    }
                }

                AppButton(title: "Keşfetmeye Başla") {
                    print("Button tapped")
                }
            }
            .padding(AppSpacing.lg)
        }
    }
}

#Preview {
    RootView()
}

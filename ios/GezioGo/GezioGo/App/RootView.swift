import SwiftUI

enum AppLaunchState {
    case splash
    case onboarding
    case main
}

struct RootView: View {
    @StateObject private var appState = AppState()
    @State private var launchState: AppLaunchState = .splash

    var body: some View {
        Group {
            switch launchState {
            case .splash:
                SplashView {
                    withAnimation {
                        launchState = appState.hasSeenOnboarding ? .main : .onboarding
                    }
                }

            case .onboarding:
                OnboardingView {
                    appState.hasSeenOnboarding = true
                    withAnimation {
                        launchState = .main
                    }
                }

            case .main:
                temporaryMainView
            }
        }
    }

    private var temporaryMainView: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                Text("GezioGo")
                    .font(AppTypography.largeTitle)
                    .foregroundStyle(AppColors.petrol)

                Text("Ana akışa geçildi")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)

                AppCard {
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Sıradaki adım")
                            .font(AppTypography.subtitle)
                            .foregroundStyle(AppColors.textPrimary)

                        Text("Şehir seçimi ve ana sayfa ekranlarını bağlayacağız.")
                            .font(AppTypography.body)
                            .foregroundStyle(AppColors.textSecondary)

                        HStack {
                            AppTag("Splash tamam", iconName: "checkmark.seal")
                            AppTag("Onboarding tamam", iconName: "sparkles")
                        }
                    }
                }
            }
            .padding(AppSpacing.lg)
        }
    }
}

#Preview {
    RootView()
}

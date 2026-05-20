import SwiftUI

struct LoginView: View {
    var onLoginSuccess: () -> Void
    var onRegisterTap: () -> Void
    var onBack: () -> Void

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                HStack {
                    Button {
                        onBack()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(AppColors.petrol)
                            .frame(width: 44, height: 44)
                            .background(AppColors.cardBackground)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)

                    Spacer()
                }

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    AppTag("GezioGo", iconName: "person")

                    Text("Giriş Yap")
                        .font(AppTypography.largeTitle)
                        .foregroundStyle(AppColors.textPrimary)

                    Text("GezioGo hesabına giriş yaparak kayıtlı rotalarına ve favorilerine ulaş.")
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineSpacing(4)
                }

                AppCard {
                    VStack(spacing: AppSpacing.md) {
                        TextField("E-posta", text: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .padding()
                            .background(AppColors.cream.opacity(0.55))
                            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))

                        SecureField("Şifre", text: $password)
                            .padding()
                            .background(AppColors.cream.opacity(0.55))
                            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))

                        AppButton(title: "Giriş Yap") {
                            onLoginSuccess()
                        }

                        Button {
                            onRegisterTap()
                        } label: {
                            Text("Hesabın yok mu? Üye Ol")
                                .font(AppTypography.bodyMedium)
                                .foregroundStyle(AppColors.teal)
                        }
                        .buttonStyle(.plain)
                    }
                }

                Spacer()
            }
            .padding(AppSpacing.lg)
        }
    }
}

#Preview {
    LoginView(
        onLoginSuccess: {},
        onRegisterTap: {},
        onBack: {}
    )
}

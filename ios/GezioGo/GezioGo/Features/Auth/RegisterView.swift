import SwiftUI

struct RegisterView: View {
    var onRegisterSuccess: () -> Void
    var onLoginTap: () -> Void
    var onBack: () -> Void

    @State private var fullName = ""
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
                    AppTag("Yeni hesap", iconName: "sparkles")

                    Text("Üye Ol")
                        .font(AppTypography.largeTitle)
                        .foregroundStyle(AppColors.textPrimary)

                    Text("GezioGo ile şehirleri keşfet, rotalarını kaydet ve favorilerini yanında taşı.")
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineSpacing(4)
                }

                AppCard {
                    VStack(spacing: AppSpacing.md) {
                        TextField("Ad Soyad", text: $fullName)
                            .textInputAutocapitalization(.words)
                            .padding()
                            .background(AppColors.cream.opacity(0.55))
                            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))

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

                        AppButton(title: "Üye Ol") {
                            onRegisterSuccess()
                        }

                        Button {
                            onLoginTap()
                        } label: {
                            Text("Zaten hesabın var mı? Giriş Yap")
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
    RegisterView(
        onRegisterSuccess: {},
        onLoginTap: {},
        onBack: {}
    )
}

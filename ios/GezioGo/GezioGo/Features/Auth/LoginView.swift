import SwiftUI

struct LoginView: View {
    var onLoginSuccess: () -> Void
    var onRegisterTap: () -> Void
    var onBack: () -> Void

    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showErrorAlert = false

    private let authService = FirebaseAuthService.shared

    private var cleanedEmail: String {
        email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    private var isFormValid: Bool {
        !cleanedEmail.isEmpty &&
        !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

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
                    .disabled(isLoading)

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
                            .disabled(isLoading)

                        SecureField("Şifre", text: $password)
                            .padding()
                            .background(AppColors.cream.opacity(0.55))
                            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
                            .disabled(isLoading)

                        AppButton(title: isLoading ? "Giriş yapılıyor..." : "Giriş Yap") {
                            login()
                        }
                        .disabled(isLoading || !isFormValid)
                        .opacity(isFormValid ? 1 : 0.55)

                        Button {
                            onRegisterTap()
                        } label: {
                            Text("Hesabın yok mu? Üye Ol")
                                .font(AppTypography.bodyMedium)
                                .foregroundStyle(AppColors.teal)
                        }
                        .buttonStyle(.plain)
                        .disabled(isLoading)
                    }
                }

                Spacer()
            }
            .padding(AppSpacing.lg)
        }
        .alert("Giriş yapılamadı", isPresented: $showErrorAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(errorMessage ?? "Lütfen bilgilerini kontrol edip tekrar dene.")
        }
    }

    private func login() {
        guard isFormValid else {
            errorMessage = "E-posta ve şifre alanlarını doldurmalısın."
            showErrorAlert = true
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                try await authService.signIn(
                    email: cleanedEmail,
                    password: password
                )

                if let userId = authService.userId {
                    try await FirebaseUserService.shared.createOrUpdateUserProfile(
                        userId: userId,
                        displayName: authService.userDisplayName,
                        email: authService.userEmail
                    )
                }

                await MainActor.run {
                    isLoading = false
                    onLoginSuccess()
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    errorMessage = firebaseErrorMessage(error)
                    showErrorAlert = true
                }
            }
        }
    }

    private func firebaseErrorMessage(_ error: Error) -> String {
        let message = error.localizedDescription

        if message.localizedCaseInsensitiveContains("password") {
            return "Şifre hatalı olabilir. Lütfen tekrar dene."
        }

        if message.localizedCaseInsensitiveContains("email") {
            return "E-posta adresini kontrol edip tekrar dene."
        }

        if message.localizedCaseInsensitiveContains("network") {
            return "İnternet bağlantını kontrol edip tekrar dene."
        }

        return message
    }
}

#Preview {
    LoginView(
        onLoginSuccess: {},
        onRegisterTap: {},
        onBack: {}
    )
}

import SwiftUI

struct RegisterView: View {
    var onRegisterSuccess: () -> Void
    var onLoginTap: () -> Void
    var onBack: () -> Void

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showErrorAlert = false

    private let authService = FirebaseAuthService.shared

    private var cleanedFirstName: String {
        firstName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var cleanedLastName: String {
        lastName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var cleanedEmail: String {
        email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    private var isFormValid: Bool {
        !cleanedFirstName.isEmpty &&
        !cleanedLastName.isEmpty &&
        !cleanedEmail.isEmpty &&
        password.count >= 6
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
                        TextField("Ad", text: $firstName)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                            .padding()
                            .background(AppColors.cream.opacity(0.55))
                            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
                            .disabled(isLoading)

                        TextField("Soyad", text: $lastName)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                            .padding()
                            .background(AppColors.cream.opacity(0.55))
                            .clipShape(RoundedRectangle(cornerRadius: AppRadius.medium))
                            .disabled(isLoading)

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

                        Text("Şifre en az 6 karakter olmalı.")
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.textSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        AppButton(title: isLoading ? "Hesap oluşturuluyor..." : "Üye Ol") {
                            register()
                        }
                        .disabled(isLoading || !isFormValid)
                        .opacity(isFormValid ? 1 : 0.55)

                        Button {
                            onLoginTap()
                        } label: {
                            Text("Zaten hesabın var mı? Giriş Yap")
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
        .alert("Kayıt oluşturulamadı", isPresented: $showErrorAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(errorMessage ?? "Lütfen bilgilerini kontrol edip tekrar dene.")
        }
    }

    private func register() {
        guard isFormValid else {
            errorMessage = "Ad, soyad, e-posta ve en az 6 karakterlik şifre girmelisin."
            showErrorAlert = true
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                try await authService.register(
                    email: cleanedEmail,
                    password: password,
                    firstName: cleanedFirstName,
                    lastName: cleanedLastName
                )

                if let userId = authService.userId {
                    try await FirebaseUserService.shared.createOrUpdateUserProfile(
                        userId: userId,
                        firstName: cleanedFirstName,
                        lastName: cleanedLastName,
                        displayName: "\(cleanedFirstName) \(cleanedLastName)",
                        email: cleanedEmail
                    )
                }

                await MainActor.run {
                    isLoading = false
                    onRegisterSuccess()
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

        if message.localizedCaseInsensitiveContains("email") {
            return "Bu e-posta adresi geçersiz olabilir veya daha önce kullanılmış olabilir."
        }

        if message.localizedCaseInsensitiveContains("password") {
            return "Şifren en az 6 karakter olmalı."
        }

        if message.localizedCaseInsensitiveContains("network") {
            return "İnternet bağlantını kontrol edip tekrar dene."
        }

        return message
    }
}

#Preview {
    RegisterView(
        onRegisterSuccess: {},
        onLoginTap: {},
        onBack: {}
    )
}

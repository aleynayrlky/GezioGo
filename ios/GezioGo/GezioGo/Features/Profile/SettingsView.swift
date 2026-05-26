import SwiftUI

struct SettingsView: View {
    let userDisplayName: String?

    @State private var firstName: String
    @State private var lastName: String
    @State private var email = ""
    @State private var phone = ""

    @State private var budgetPreference = "Henüz seçilmedi"
    @State private var interestPreference = "Doğa, Tarih, Gastronomi"
    @State private var transportPreference = "Karma"

    init(userDisplayName: String? = nil) {
        self.userDisplayName = userDisplayName

        let parts = (userDisplayName ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: " ")

        if let first = parts.first {
            _firstName = State(initialValue: String(first))
            _lastName = State(initialValue: parts.dropFirst().joined(separator: " "))
        } else {
            _firstName = State(initialValue: "")
            _lastName = State(initialValue: "")
        }
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    headerView

                    personalInfoSection

                    preferencesSection

                    appSettingsSection
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, AppSpacing.xl)
            }
        }
        .navigationTitle("Ayarlar")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 5) {
            AppTag("Ayarlar", iconName: "gearshape")

            Text("Profil ayarları")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Text("Kişisel bilgilerini ve uygulama tercihlerini buradan düzenleyebilirsin.")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(3)
        }
    }

    private var personalInfoSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionTitle("Kişisel Bilgiler")

            AppCard {
                VStack(spacing: 0) {
                    editableRow(
                        iconName: "person.fill",
                        title: "Ad",
                        placeholder: "Adını yaz",
                        text: $firstName,
                        textInputAutocapitalization: .words
                    )

                    Divider()
                        .padding(.leading, 50)

                    editableRow(
                        iconName: "person.text.rectangle.fill",
                        title: "Soyad",
                        placeholder: "Soyadını yaz",
                        text: $lastName,
                        textInputAutocapitalization: .words
                    )

                    Divider()
                        .padding(.leading, 50)

                    editableRow(
                        iconName: "envelope.fill",
                        title: "E-posta",
                        placeholder: "E-posta adresi",
                        text: $email,
                        textInputAutocapitalization: .never
                    )

                    Divider()
                        .padding(.leading, 50)

                    editableRow(
                        iconName: "phone.fill",
                        title: "Telefon",
                        placeholder: "Telefon numarası",
                        text: $phone,
                        textInputAutocapitalization: .never
                    )
                }
            }
        }
    }

    private var preferencesSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionTitle("Tercihler")

            AppCard {
                VStack(spacing: 0) {
                    settingsRow(
                        iconName: "wallet.pass.fill",
                        title: "Bütçe Tercihi",
                        value: budgetPreference
                    )

                    Divider()
                        .padding(.leading, 50)

                    settingsRow(
                        iconName: "heart.fill",
                        title: "İlgi Alanları",
                        value: interestPreference
                    )

                    Divider()
                        .padding(.leading, 50)

                    settingsRow(
                        iconName: "car.fill",
                        title: "Ulaşım Tercihi",
                        value: transportPreference
                    )
                }
            }
        }
    }

    private var appSettingsSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            sectionTitle("Uygulama")

            AppCard {
                VStack(spacing: 0) {
                    settingsRow(
                        iconName: "bell.fill",
                        title: "Bildirimler",
                        value: "Profil ekranından yönetiliyor"
                    )

                    Divider()
                        .padding(.leading, 50)

                    settingsRow(
                        iconName: "globe",
                        title: "Dil",
                        value: "Türkçe"
                    )

                    Divider()
                        .padding(.leading, 50)

                    settingsRow(
                        iconName: "moon.fill",
                        title: "Tema",
                        value: "Sistem varsayılanı"
                    )

                    Divider()
                        .padding(.leading, 50)

                    settingsRow(
                        iconName: "lock.shield.fill",
                        title: "Gizlilik",
                        value: "Yakında"
                    )
                }
            }
        }
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 17, weight: .bold, design: .rounded))
            .foregroundStyle(AppColors.textPrimary)
            .padding(.leading, 2)
    }

    private func editableRow(
        iconName: String,
        title: String,
        placeholder: String,
        text: Binding<String>,
        textInputAutocapitalization: TextInputAutocapitalization = .words
    ) -> some View {
        HStack(spacing: AppSpacing.sm) {
            iconCircle(iconName)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 12.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                TextField(placeholder, text: text)
                    .font(.system(size: 12.5, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .textInputAutocapitalization(textInputAutocapitalization)
                    .autocorrectionDisabled()
            }
        }
        .padding(.vertical, 10)
    }

    private func settingsRow(
        iconName: String,
        title: String,
        value: String
    ) -> some View {
        HStack(spacing: AppSpacing.sm) {
            iconCircle(iconName)

            Text(title)
                .font(.system(size: 12.5, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Spacer()

            Text(value)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineLimit(1)

            Image(systemName: "chevron.right")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)
        }
        .padding(.vertical, 10)
    }

    private func iconCircle(_ iconName: String) -> some View {
        ZStack {
            Circle()
                .fill(AppColors.cream)
                .frame(width: 38, height: 38)

            Image(systemName: iconName)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(AppColors.petrol)
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(userDisplayName: "Aleyna Yerlikaya")
    }
}

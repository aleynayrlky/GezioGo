import SwiftUI

struct ProfileView: View {
    let cityId: String
    var onChangeCity: (() -> Void)? = nil

    @Environment(\.navigate) private var navigate

    @State private var discoveryNotifications = true
    @State private var eventNotifications = true
    @State private var campaignNotifications = false
    @State private var showLogoutAlert = false

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    topSection

                    titleSection

                    profileCard

                    preferencesSection

                    notificationsSection

                    cityAndLanguageSection

                    logoutButton
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 120)
            }
        }
        .navigationTitle("Profil")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Çıkış yapma işlemi yakında", isPresented: $showLogoutAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text("Firebase giriş sistemi bağlandığında çıkış yapma işlemi aktif olacak.")
        }
    }

    private var topSection: some View {
        HStack {
            HStack(spacing: 6) {
                Image("gezioGoLogoTransparent")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())

                HStack(spacing: 0) {
                    Text("Gezio")
                        .foregroundStyle(AppColors.petrol)

                    Text("Go")
                        .foregroundStyle(AppColors.gold)
                }
                .font(.system(size: 18, weight: .bold, design: .rounded))
            }

            Spacer()

            NavigationLink {
                SettingsView()
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
                    .frame(width: 38, height: 38)
                    .background(AppColors.cardBackground)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: 4)
            }
            .buttonStyle(.plain)
        }
    }

    private var titleSection: some View {
        Text("Profilim")
            .font(.system(size: 25, weight: .bold, design: .rounded))
            .foregroundStyle(AppColors.textPrimary)
    }

    private var profileCard: some View {
        compactCard {
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    ZStack(alignment: .bottomTrailing) {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        AppColors.teal.opacity(0.18),
                                        AppColors.gold.opacity(0.16)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 52, height: 52)

                        Image(systemName: "person.fill")
                            .font(.system(size: 23, weight: .semibold))
                            .foregroundStyle(AppColors.petrol)

                        Image(systemName: "pencil")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 19, height: 19)
                            .background(AppColors.teal)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(AppColors.cardBackground, lineWidth: 2)
                            )
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text("Gezgin")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.textPrimary)

                        Text("Gezgin ruhlu kaşif")
                            .font(.system(size: 11, weight: .regular))
                            .foregroundStyle(AppColors.textSecondary)

                        Text("Beta kullanıcı")
                            .font(.system(size: 9, weight: .semibold))
                            .foregroundStyle(AppColors.petrol)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(AppColors.cream)
                            .clipShape(Capsule())
                    }

                    Spacer()
                }

                Divider()

                HStack(spacing: 0) {
                    profileStat(
                        value: "0",
                        title: "Keşfedilen",
                        iconName: "mappin.circle.fill"
                    )

                    Divider()
                        .frame(height: 30)

                    profileStat(
                        value: "0",
                        title: "Rota",
                        iconName: "point.topleft.down.curvedto.point.bottomright.up"
                    )

                    Divider()
                        .frame(height: 30)

                    profileStat(
                        value: "0",
                        title: "Favori",
                        iconName: "star.fill"
                    )
                }
            }
        }
    }

    private func profileStat(
        value: String,
        title: String,
        iconName: String
    ) -> some View {
        VStack(spacing: 3) {
            ZStack {
                Circle()
                    .fill(AppColors.cream)
                    .frame(width: 26, height: 26)

                Image(systemName: iconName)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
            }

            Text(value)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.petrol)

            Text(title)
                .font(.system(size: 9, weight: .medium))
                .foregroundStyle(AppColors.textSecondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
    }

    private var preferencesSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            sectionTitle("Tercihlerim")

            compactCard {
                VStack(spacing: 0) {
                    profileRow(
                        iconName: "wallet.pass.fill",
                        iconColor: AppColors.gold,
                        title: "Bütçe",
                        value: "Henüz seçilmedi"
                    )

                    Divider()
                        .padding(.leading, 38)

                    profileRow(
                        iconName: "heart.fill",
                        iconColor: AppColors.teal,
                        title: "İlgi Alanları",
                        value: "Doğa, Tarih"
                    )

                    Divider()
                        .padding(.leading, 38)

                    profileRow(
                        iconName: "car.fill",
                        iconColor: AppColors.gold,
                        title: "Ulaşım",
                        value: "Karma"
                    )
                }
            }
        }
    }

    private var notificationsSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            sectionTitle("Bildirimler")

            compactCard {
                VStack(spacing: 0) {
                    notificationRow(
                        iconName: "bell.fill",
                        iconColor: AppColors.teal,
                        title: "Keşif Önerileri",
                        subtitle: "Rota ve yer önerileri",
                        isOn: $discoveryNotifications
                    )

                    Divider()
                        .padding(.leading, 38)

                    notificationRow(
                        iconName: "calendar",
                        iconColor: AppColors.gold,
                        title: "Etkinlik Hatırlatıcıları",
                        subtitle: "Etkinlik hatırlatmaları",
                        isOn: $eventNotifications
                    )

                    Divider()
                        .padding(.leading, 38)

                    notificationRow(
                        iconName: "tag.fill",
                        iconColor: AppColors.teal,
                        title: "Kampanya ve Duyurular",
                        subtitle: "Özel duyurular",
                        isOn: $campaignNotifications
                    )
                }
            }
        }
    }

    private var cityAndLanguageSection: some View {
        VStack(spacing: 8) {
            compactCard {
                Button {
                    onChangeCity?()
                } label: {
                    profileRowContent(
                        iconName: "mappin.and.ellipse",
                        iconColor: AppColors.teal,
                        title: "Seçili Şehir",
                        value: cityDisplayName,
                        showsChevron: true
                    )
                }
                .buttonStyle(.plain)
            }

            compactCard {
                profileRowContent(
                    iconName: "globe",
                    iconColor: AppColors.gold,
                    title: "Dil",
                    value: "Türkçe",
                    showsChevron: true
                )
            }
        }
    }

    private var logoutButton: some View {
        Button {
            showLogoutAlert = true
        } label: {
            HStack(spacing: AppSpacing.xs) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 14, weight: .semibold))

                Text("Çıkış Yap")
                    .font(.system(size: 13, weight: .semibold))
            }
            .foregroundStyle(AppColors.gold)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(AppColors.gold.opacity(0.75), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 15, weight: .bold, design: .rounded))
            .foregroundStyle(AppColors.textPrimary)
            .padding(.leading, 2)
    }

    private func profileRow(
        iconName: String,
        iconColor: Color,
        title: String,
        value: String
    ) -> some View {
        profileRowContent(
            iconName: iconName,
            iconColor: iconColor,
            title: title,
            value: value,
            showsChevron: true
        )
    }

    private func profileRowContent(
        iconName: String,
        iconColor: Color,
        title: String,
        value: String,
        showsChevron: Bool
    ) -> some View {
        HStack(spacing: 9) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.16))
                    .frame(width: 28, height: 28)

                Image(systemName: iconName)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(iconColor == AppColors.gold ? AppColors.gold : AppColors.petrol)
            }

            Text(title)
                .font(.system(size: 11.5, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Spacer()

            Text(value)
                .font(.system(size: 10.5, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineLimit(1)

            if showsChevron {
                Image(systemName: "chevron.right")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
        .padding(.vertical, 5)
    }

    private func notificationRow(
        iconName: String,
        iconColor: Color,
        title: String,
        subtitle: String,
        isOn: Binding<Bool>
    ) -> some View {
        HStack(spacing: 9) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.16))
                    .frame(width: 28, height: 28)

                Image(systemName: iconName)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(iconColor == AppColors.gold ? AppColors.gold : AppColors.petrol)
            }

            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .font(.system(size: 11.5, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Text(subtitle)
                    .font(.system(size: 9.8, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineLimit(1)
            }

            Spacer()

            Toggle("", isOn: isOn)
                .labelsHidden()
                .tint(AppColors.teal)
                .scaleEffect(0.68)
        }
        .padding(.vertical, 4)
    }

    private func compactCard<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        content()
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .shadow(color: .black.opacity(0.045), radius: 8, x: 0, y: 4)
    }

    private var cityDisplayName: String {
        switch cityId.lowercased() {
        case "samsun":
            return "Samsun"
        default:
            return cityId.capitalized
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(cityId: "samsun")
    }
}

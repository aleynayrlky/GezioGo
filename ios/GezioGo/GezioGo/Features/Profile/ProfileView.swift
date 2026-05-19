import SwiftUI

struct ProfileView: View {
    let cityId: String
    var onChangeCity: (() -> Void)? = nil

    @Environment(\.navigate) private var navigate

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    profileHeader

                    cityCard

                    appInfoCard

                    comingSoonCard

                    settingsButton
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle("Profil")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var profileHeader: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                HStack(spacing: AppSpacing.md) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        AppColors.petrol,
                                        AppColors.teal
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 72, height: 72)

                        Image(systemName: "person.fill")
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundStyle(.white)
                    }

                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text("GezioGo Kullanıcısı")
                            .font(AppTypography.subtitle)
                            .foregroundStyle(AppColors.textPrimary)

                        Text("Şehir seninle keşfedilir")
                            .font(AppTypography.body)
                            .foregroundStyle(AppColors.textSecondary)
                    }

                    Spacer()
                }

                HStack(spacing: AppSpacing.xs) {
                    AppTag("Beta kullanıcı", iconName: "sparkles")
                    AppTag("SwiftUI", iconName: "swift")
                }
            }
        }
    }

    private var cityCard: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                HStack {
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text("Seçili şehir")
                            .font(AppTypography.captionMedium)
                            .foregroundStyle(AppColors.teal)

                        Text(cityDisplayName)
                            .font(AppTypography.subtitle)
                            .foregroundStyle(AppColors.textPrimary)
                    }

                    Spacer()

                    Image(systemName: "mappin.and.ellipse")
                        .font(.title2)
                        .foregroundStyle(AppColors.gold)
                }

                Text("Ana Sayfa ve Keşfet içerikleri seçili şehre göre gösterilir. İstersen şehir seçimini değiştirebilirsin.")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(4)

                Button {
                    onChangeCity?()
                } label: {
                    HStack(spacing: AppSpacing.sm) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.caption)

                        Text("Şehri değiştir")
                            .font(AppTypography.captionMedium)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.caption)
                    }
                    .foregroundStyle(AppColors.teal)
                    .padding(.top, AppSpacing.xs)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var appInfoCard: some View {
        AppCard {
            VStack(spacing: AppSpacing.md) {
                infoRow(
                    iconName: "iphone",
                    title: "Uygulama",
                    value: "GezioGo"
                )

                Divider()

                infoRow(
                    iconName: "number",
                    title: "Sürüm",
                    value: "0.1 SwiftUI Demo"
                )

                Divider()

                infoRow(
                    iconName: "folder",
                    title: "Veri kaynağı",
                    value: "Local JSON / MockDataService"
                )
            }
        }
    }

    private var comingSoonCard: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Yakında")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    AppTag("Kullanıcı hesabı", iconName: "person.crop.circle")
                    AppTag("Kaydedilen rotalar", iconName: "map")
                    AppTag("Bildirim tercihleri", iconName: "bell")
                    AppTag("Kişisel öneriler", iconName: "wand.and.stars")
                }

                Text("Profil ekranı ilerleyen sürümlerde kullanıcı hesabı, tercih yönetimi ve kişisel önerilerle genişletilecek.")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(4)
            }
        }
    }

    private var settingsButton: some View {
        NavigationLink {
            SettingsView()
        } label: {
            AppCard {
                HStack(spacing: AppSpacing.md) {
                    ZStack {
                        RoundedRectangle(cornerRadius: AppRadius.medium)
                            .fill(AppColors.cream)
                            .frame(width: 44, height: 44)

                        Image(systemName: "gearshape")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(AppColors.petrol)
                    }

                    VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                        Text("Ayarlar")
                            .font(AppTypography.bodyMedium)
                            .foregroundStyle(AppColors.textPrimary)

                        Text("Uygulama tercihlerini görüntüle")
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.textSecondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(AppColors.textSecondary)
                }
            }
        }
        .buttonStyle(.plain)
    }

    private func infoRow(
        iconName: String,
        title: String,
        value: String
    ) -> some View {
        HStack(spacing: AppSpacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.medium)
                    .fill(AppColors.cream)
                    .frame(width: 44, height: 44)

                Image(systemName: iconName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(title)
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)

                Text(value)
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)
            }

            Spacer()
        }
    }

    private var cityDisplayName: String {
        switch cityId {
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
}//
//  ProfileView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


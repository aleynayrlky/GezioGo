import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    headerView

                    AppCard {
                        VStack(spacing: AppSpacing.md) {
                            settingsRow(
                                iconName: "bell",
                                title: "Bildirimler",
                                value: "Yakında"
                            )

                            Divider()

                            settingsRow(
                                iconName: "globe",
                                title: "Dil",
                                value: "Türkçe"
                            )

                            Divider()

                            settingsRow(
                                iconName: "moon",
                                title: "Tema",
                                value: "Sistem varsayılanı"
                            )

                            Divider()

                            settingsRow(
                                iconName: "lock.shield",
                                title: "Gizlilik",
                                value: "Yakında"
                            )
                        }
                    }

                    AppCard {
                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            Text("Hesap sistemi")
                                .font(AppTypography.subtitle)
                                .foregroundStyle(AppColors.textPrimary)

                            Text("Kullanıcı hesabı, giriş/çıkış ve kişisel tercihler sonraki sürümlerde eklenecek.")
                                .font(AppTypography.body)
                                .foregroundStyle(AppColors.textSecondary)
                                .lineSpacing(4)

                            AppTag("GezioGo 1.2 hedefi", iconName: "person.crop.circle")
                        }
                    }
                }
                .padding(AppSpacing.lg)
            }
        }
        .navigationTitle("Ayarlar")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("Ayarlar", iconName: "gearshape")

            Text("Uygulama ayarları")
                .font(AppTypography.title)
                .foregroundStyle(AppColors.textPrimary)

            Text("Bildirimler, dil, görünüm ve hesap ayarları burada yönetilecek.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(4)
        }
    }

    private func settingsRow(
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
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.textPrimary)

                Text(value)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.textSecondary)
            }

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}//
//  SettingsView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


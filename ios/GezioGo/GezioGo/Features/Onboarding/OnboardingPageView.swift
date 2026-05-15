//
//  OnboardingPageView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//

import SwiftUI

struct OnboardingPage: Identifiable, Hashable {
    let id = UUID()
    let iconName: String
    let title: String
    let description: String
    let tagTitle: String
}

struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: AppSpacing.xl) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                AppColors.teal.opacity(0.18),
                                AppColors.gold.opacity(0.18)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 180, height: 180)

                Image(systemName: page.iconName)
                    .font(.system(size: 64, weight: .semibold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [AppColors.petrol, AppColors.teal],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }

            VStack(spacing: AppSpacing.md) {
                AppTag(page.tagTitle, iconName: "sparkles")

                Text(page.title)
                    .font(AppTypography.title)
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.center)

                Text(page.description)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, AppSpacing.lg)
            }

            Spacer()
        }
        .padding(.top, AppSpacing.xxl)
        .padding(.horizontal, AppSpacing.lg)
    }
}

#Preview {
    OnboardingPageView(
        page: OnboardingPage(
            iconName: "map",
            title: "Şehri kolayca keşfet",
            description: "Gezilecek yerleri, etkinlikleri ve önerilen rotaları tek yerden gör.",
            tagTitle: "Keşfet"
        )
    )
    .background(AppColors.background)
}

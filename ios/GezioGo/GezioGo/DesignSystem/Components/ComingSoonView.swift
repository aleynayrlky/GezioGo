import SwiftUI

struct ComingSoonView: View {
    let title: String
    let message: String
    let iconName: String
    let tagTitle: String

    init(
        title: String,
        message: String,
        iconName: String,
        tagTitle: String = "Yakında"
    ) {
        self.title = title
        self.message = message
        self.iconName = iconName
        self.tagTitle = tagTitle
    }

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppColors.cream,
                                    AppColors.gold.opacity(0.18)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 104, height: 104)

                    Image(systemName: iconName)
                        .font(.system(size: 42, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                }

                VStack(spacing: AppSpacing.sm) {
                    Text(title)
                        .font(AppTypography.title)
                        .foregroundStyle(AppColors.textPrimary)
                        .multilineTextAlignment(.center)

                    Text(message)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, AppSpacing.xl)
                }

                AppTag(tagTitle, iconName: "clock")
            }
            .padding(AppSpacing.lg)
        }
    }
}

#Preview {
    ComingSoonView(
        title: "AI Rota",
        message: "Kişisel gezi rotaları yakında burada olacak.",
        iconName: "wand.and.stars"
    )
}//
//  ComingSoonView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


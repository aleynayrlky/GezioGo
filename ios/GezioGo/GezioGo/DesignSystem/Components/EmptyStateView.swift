import SwiftUI

struct EmptyStateView: View {
    let title: String
    let message: String
    let iconName: String
    let buttonTitle: String?
    let action: (() -> Void)?

    init(
        title: String,
        message: String,
        iconName: String = "tray",
        buttonTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.iconName = iconName
        self.buttonTitle = buttonTitle
        self.action = action
    }

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                ZStack {
                    Circle()
                        .fill(AppColors.cream)
                        .frame(width: 56, height: 56)

                    Image(systemName: iconName)
                        .font(.title2)
                        .foregroundStyle(AppColors.petrol)
                }

                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text(title)
                        .font(AppTypography.subtitle)
                        .foregroundStyle(AppColors.textPrimary)

                    Text(message)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.textSecondary)
                        .lineSpacing(4)
                }

                if let buttonTitle, let action {
                    AppButton(title: buttonTitle, style: .secondary, action: action)
                        .padding(.top, AppSpacing.xs)
                }
            }
        }
    }
}

#Preview {
    EmptyStateView(
        title: "Mekan bulunamadı",
        message: "Bu kategoride henüz mekan bulunmuyor.",
        iconName: "mappin.slash",
        buttonTitle: "Tümünü Göster"
    ) {}
    .padding()
    .background(AppColors.background)
}//
//  EmptyStateView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


import SwiftUI

struct ErrorStateView: View {
    let title: String
    let message: String
    let retryTitle: String
    let retryAction: (() -> Void)?

    init(
        title: String = "Bir sorun oluştu",
        message: String,
        retryTitle: String = "Tekrar Dene",
        retryAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.retryTitle = retryTitle
        self.retryAction = retryAction
    }

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                ZStack {
                    Circle()
                        .fill(AppColors.error.opacity(0.12))
                        .frame(width: 56, height: 56)

                    Image(systemName: "exclamationmark.triangle")
                        .font(.title2)
                        .foregroundStyle(AppColors.error)
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

                if let retryAction {
                    AppButton(title: retryTitle, action: retryAction)
                        .padding(.top, AppSpacing.xs)
                }
            }
        }
    }
}

#Preview {
    ErrorStateView(
        message: "Veriler yüklenirken bir hata oluştu."
    ) {}
    .padding()
    .background(AppColors.background)
}//
//  ErrorStateView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


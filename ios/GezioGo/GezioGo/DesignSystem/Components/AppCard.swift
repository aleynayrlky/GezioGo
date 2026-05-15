import SwiftUI

struct AppCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(AppSpacing.md)
            .background(AppColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    AppCard {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            Text("Bandırma Vapuru Müzesi")
                .font(AppTypography.subtitle)
                .foregroundStyle(AppColors.textPrimary)

            Text("Milli Mücadele’nin simge duraklarından biri.")
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
        }
    }
    .padding()
    .background(AppColors.background)
}//
//  AppCard.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


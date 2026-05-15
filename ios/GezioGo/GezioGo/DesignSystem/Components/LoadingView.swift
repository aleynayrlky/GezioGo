import SwiftUI

struct LoadingView: View {
    let message: String

    init(_ message: String = "Yükleniyor...") {
        self.message = message
    }

    var body: some View {
        VStack(spacing: AppSpacing.md) {
            ProgressView()
                .tint(AppColors.petrol)

            Text(message)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppSpacing.xl)
    }
}

#Preview {
    LoadingView("Mekanlar yükleniyor...")
        .padding()
        .background(AppColors.background)
}//
//  LoadingView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


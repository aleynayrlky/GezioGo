import SwiftUI

struct HomeHeroCard: View {
    let city: City?

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                HStack {
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text(city?.name ?? "GezioGo")
                            .font(AppTypography.title2)
                            .foregroundStyle(AppColors.textPrimary)

                        Text(city?.region ?? "Şehir keşfi")
                            .font(AppTypography.captionMedium)
                            .foregroundStyle(AppColors.teal)
                    }

                    Spacer()

                    Image(systemName: "map.fill")
                        .font(.title)
                        .foregroundStyle(AppColors.gold)
                }

                Text(city?.shortDescription ?? "Şehri keşfetmenin akıllı yolu.")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
            }
        }
    }
}

#Preview {
    HomeHeroCard(city: nil)
        .padding()
        .background(AppColors.background)
}//
//  HomeHeroCard.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


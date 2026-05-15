import SwiftUI

struct FavoriteBadge: View {
    let isFavorite: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(isFavorite ? AppColors.gold : AppColors.cream)
                .frame(width: 34, height: 34)

            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(isFavorite ? .white : AppColors.petrol)
        }
        .accessibilityLabel(isFavorite ? "Favorilerde" : "Favori değil")
    }
}

#Preview {
    HStack {
        FavoriteBadge(isFavorite: true)
        FavoriteBadge(isFavorite: false)
    }
    .padding()
    .background(AppColors.background)
}//
//  FavoriteBadge.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


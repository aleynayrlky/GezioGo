import SwiftUI

struct CategoryShortcutView: View {
    let category: PlaceCategory

    var body: some View {
        VStack(spacing: AppSpacing.xs) {
            ZStack {
                Circle()
                    .fill(AppColors.cream)
                    .frame(width: 56, height: 56)

                Image(systemName: category.iconName)
                    .font(.title3)
                    .foregroundStyle(AppColors.petrol)
            }

            Text(category.displayName)
                .font(AppTypography.small)
                .foregroundStyle(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 78)
    }
}

#Preview {
    HStack {
        CategoryShortcutView(category: .museum)
        CategoryShortcutView(category: .nature)
        CategoryShortcutView(category: .foodDrink)
    }
    .padding()
    .background(AppColors.background)
}//
//  CategoryShortcutView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


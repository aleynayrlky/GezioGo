import SwiftUI

struct CategoryCard: View {
    let category: PlaceCategory
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                HStack {
                    ZStack {
                        Circle()
                            .fill(iconBackgroundColor)
                            .frame(width: 48, height: 48)

                        Image(systemName: category.iconName)
                            .font(.title3)
                            .foregroundStyle(iconColor)
                    }

                    Spacer()

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(AppColors.gold)
                    }
                }

                VStack(alignment: .leading, spacing: AppSpacing.xs) {
                    Text(category.displayName)
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(titleColor)
                        .lineLimit(1)

                    Text(description)
                        .font(AppTypography.caption)
                        .foregroundStyle(subtitleColor)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(AppSpacing.md)
            .frame(width: 160, alignment: .leading)
            .background(cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.large)
                    .stroke(borderColor, lineWidth: isSelected ? 1.5 : 0)
            )
            .shadow(
                color: Color.black.opacity(isSelected ? 0.10 : 0.06),
                radius: isSelected ? 12 : 8,
                x: 0,
                y: 6
            )
        }
        .buttonStyle(.plain)
    }

    private var cardBackground: Color {
        isSelected ? AppColors.petrol : AppColors.cardBackground
    }

    private var iconBackgroundColor: Color {
        isSelected ? AppColors.gold.opacity(0.22) : AppColors.cream
    }

    private var iconColor: Color {
        isSelected ? AppColors.gold : AppColors.petrol
    }

    private var titleColor: Color {
        isSelected ? .white : AppColors.textPrimary
    }

    private var subtitleColor: Color {
        isSelected ? AppColors.cream.opacity(0.9) : AppColors.textSecondary
    }

    private var borderColor: Color {
        isSelected ? AppColors.gold.opacity(0.7) : .clear
    }

    private var description: String {
        switch category {
        case .historical:
            return "Tarihi durakları keşfet"
        case .museum:
            return "Müzeler ve kültür alanları"
        case .nature:
            return "Doğa ve açık alanlar"
        case .foodDrink:
            return "Kafe ve lezzet noktaları"
        case .beach:
            return "Sahil ve deniz rotaları"
        case .shopping:
            return "Alışveriş noktaları"
        case .religious:
            return "İnanç ve kültür yapıları"
        case .family:
            return "Aile dostu öneriler"
        case .hiddenGem:
            return "Az bilinen özel yerler"
        case .entertainment:
            return "Eğlence ve sosyal yaşam"
        case .other:
            return "Diğer keşifler"
        }
    }
}

#Preview {
    HStack {
        CategoryCard(category: .museum, isSelected: true) {}
        CategoryCard(category: .nature, isSelected: false) {}
    }
    .padding()
    .background(AppColors.background)
}//
//  CategoryCard.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


import SwiftUI

struct PlaceInfoRow: View {
    let iconName: String
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: AppRadius.medium)
                    .fill(AppColors.cream)
                    .frame(width: 44, height: 44)

                Image(systemName: iconName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
            }

            VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                Text(title)
                    .font(AppTypography.captionMedium)
                    .foregroundStyle(AppColors.teal)

                Text(value)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)
            }

            Spacer()
        }
    }
}

#Preview {
    PlaceInfoRow(
        iconName: "mappin.and.ellipse",
        title: "Adres",
        value: "Atakum Sahil Yolu, Atakum / Samsun"
    )
    .padding()
    .background(AppColors.background)
}//
//  PlaceInfoRow.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


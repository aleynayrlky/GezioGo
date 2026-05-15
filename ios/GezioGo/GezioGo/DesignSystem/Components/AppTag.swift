import SwiftUI

struct AppTag: View {
    let title: String
    let iconName: String?

    init(_ title: String, iconName: String? = nil) {
        self.title = title
        self.iconName = iconName
    }

    var body: some View {
        HStack(spacing: AppSpacing.xs) {
            if let iconName {
                Image(systemName: iconName)
                    .font(.system(size: 12, weight: .semibold))
            }

            Text(title)
                .font(AppTypography.captionMedium)
        }
        .foregroundStyle(AppColors.petrol)
        .padding(.horizontal, AppSpacing.sm)
        .padding(.vertical, AppSpacing.xs)
        .background(AppColors.cream)
        .clipShape(Capsule())
    }
}

#Preview {
    HStack {
        AppTag("Ücretsiz", iconName: "ticket")
        AppTag("Müze", iconName: "building.columns")
        AppTag("Çocukla Uygun", iconName: "figure.and.child.holdinghands")
    }
    .padding()
    .background(AppColors.background)
}//
//  AppTag.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


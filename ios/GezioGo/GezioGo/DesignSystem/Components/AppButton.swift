import SwiftUI

enum AppButtonStyle {
    case primary
    case secondary
    case outline
}

struct AppButton: View {
    let title: String
    let style: AppButtonStyle
    let action: () -> Void

    init(
        title: String,
        style: AppButtonStyle = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTypography.bodyMedium)
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppSpacing.md)
                .foregroundStyle(foregroundColor)
                .background(backgroundView)
                .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
                .overlay(
                    RoundedRectangle(cornerRadius: AppRadius.large)
                        .stroke(borderColor, lineWidth: style == .outline ? 1.5 : 0)
                )
        }
        .buttonStyle(.plain)
    }

    private var foregroundColor: Color {
        switch style {
        case .primary:
            return .white
        case .secondary:
            return AppColors.petrol
        case .outline:
            return AppColors.petrol
        }
    }

    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .primary:
            LinearGradient(
                colors: [AppColors.petrol, AppColors.teal],
                startPoint: .leading,
                endPoint: .trailing
            )
        case .secondary:
            AppColors.cream
        case .outline:
            Color.clear
        }
    }

    private var borderColor: Color {
        style == .outline ? AppColors.petrol : .clear
    }
}

#Preview {
    VStack(spacing: 16) {
        AppButton(title: "Keşfetmeye Başla") {}
        AppButton(title: "Daha Sonra", style: .secondary) {}
        AppButton(title: "Rotaya Ekle", style: .outline) {}
    }
    .padding()
    .background(AppColors.background)
}//
//  AppButton.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


import SwiftUI

struct RouteNotesCard: View {
    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Rota notu")
                    .font(AppTypography.subtitle)
                    .foregroundStyle(AppColors.textPrimary)

                Text("Bu rota şimdilik mock veriyle hazırlanmıştır. Rota duraklarını haritada inceleyebilir, uygun duraklara Apple Maps ile yol tarifi alabilir ve rotayı paylaşabilirsin.")
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(4)

                HStack(spacing: AppSpacing.xs) {
                    AppTag("Apple Maps", iconName: "location.fill")
                    AppTag("Paylaşılabilir rota", iconName: "square.and.arrow.up")
                }
            }
        }
    }
}

#Preview {
    RouteNotesCard()
        .padding()
        .background(AppColors.background)
}

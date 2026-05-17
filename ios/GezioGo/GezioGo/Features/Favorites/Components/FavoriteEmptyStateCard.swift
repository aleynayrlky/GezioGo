import SwiftUI

struct FavoriteEmptyStateCard: View {
    let iconName: String
    let title: String
    let message: String
    var buttonTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                HStack(alignment: .top, spacing: AppSpacing.md) {
                    ZStack {
                        RoundedRectangle(cornerRadius: AppRadius.medium)
                            .fill(AppColors.cream)
                            .frame(width: 48, height: 48)

                        Image(systemName: iconName)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(AppColors.petrol)
                    }

                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text(title)
                            .font(AppTypography.bodyMedium)
                            .foregroundStyle(AppColors.textPrimary)

                        Text(message)
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.textSecondary)
                            .lineSpacing(3)

                        if let buttonTitle, let action {
                            Button {
                                action()
                            } label: {
                                HStack(spacing: AppSpacing.xs) {
                                    Text(buttonTitle)
                                        .font(AppTypography.captionMedium)

                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .foregroundStyle(AppColors.teal)
                            }
                            .buttonStyle(.plain)
                            .padding(.top, AppSpacing.xs)
                        }
                    }

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    FavoriteEmptyStateCard(
        iconName: "heart",
        title: "Henüz favori mekan yok",
        message: "Gezilecek yerleri favorilerine ekleyerek planlarını daha kolay oluşturabilirsin.",
        buttonTitle: "Keşfetmeye Git"
    ) {}
    .padding()
    .background(AppColors.background)
}

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    let placeholder: String

    init(
        text: Binding<String>,
        placeholder: String = "Ara..."
    ) {
        self._text = text
        self.placeholder = placeholder
    }

    var body: some View {
        HStack(spacing: AppSpacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(AppColors.textSecondary)

            TextField(placeholder, text: $text)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.textPrimary)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()

            if !text.isEmpty {
                Button {
                    withAnimation {
                        text = ""
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppColors.textSecondary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Aramayı temizle")
            }
        }
        .padding(.horizontal, AppSpacing.md)
        .padding(.vertical, AppSpacing.sm)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppRadius.large))
        .overlay(
            RoundedRectangle(cornerRadius: AppRadius.large)
                .stroke(AppColors.border, lineWidth: 1)
        )
        .shadow(
            color: Color.black.opacity(0.04),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

#Preview {
    VStack(spacing: AppSpacing.md) {
        SearchBarView(
            text: .constant("atakum"),
            placeholder: "Mekan ara"
        )

        SearchBarView(
            text: .constant(""),
            placeholder: "Etkinlik ara"
        )
    }
    .padding()
    .background(AppColors.background)
}

import SwiftUI

struct PlaceInfoRow: View {
    let iconName: String
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: AppSpacing.sm) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppColors.cream)
                    .frame(width: 34, height: 34)

                Image(systemName: iconName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(AppColors.petrol)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.teal)

                Text(value)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(AppColors.textPrimary)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(2)
            }

            Spacer()
        }
        .padding(.vertical, 8)
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
}

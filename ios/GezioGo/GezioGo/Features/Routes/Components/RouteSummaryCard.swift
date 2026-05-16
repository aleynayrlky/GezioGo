import SwiftUI

struct RouteSummaryCard: View {
    let durationText: String
    let stopCountText: String
    let distanceText: String
    let transportText: String
    let tempoText: String
    let budgetText: String
    let companionText: String

    var body: some View {
        AppCard {
            VStack(spacing: AppSpacing.md) {
                PlaceInfoRow(
                    iconName: "clock",
                    title: "Toplam Süre",
                    value: durationText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "mappin.and.ellipse",
                    title: "Durak Sayısı",
                    value: stopCountText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "point.topleft.down.curvedto.point.bottomright.up",
                    title: "Mesafe",
                    value: distanceText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "figure.walk",
                    title: "Ulaşım",
                    value: transportText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "speedometer",
                    title: "Tempo",
                    value: tempoText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "creditcard",
                    title: "Tahmini Bütçe",
                    value: budgetText
                )

                Divider()

                PlaceInfoRow(
                    iconName: "person.2",
                    title: "Kimler İçin",
                    value: companionText
                )
            }
        }
    }
}

#Preview {
    RouteSummaryCard(
        durationText: "4 saat",
        stopCountText: "5 durak",
        distanceText: "6.2 km",
        transportText: "Yürüyerek",
        tempoText: "Dengeli",
        budgetText: "Orta",
        companionText: "Herkes için uygun"
    )
    .padding()
    .background(AppColors.background)
}

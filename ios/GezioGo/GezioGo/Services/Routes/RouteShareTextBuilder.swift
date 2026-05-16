import Foundation

enum RouteShareTextBuilder {
    static func shareTitle(for route: TripRoute) -> String {
        "GezioGo Rotası: \(route.title)"
    }

    static func shareText(for route: TripRoute) -> String {
        [
            shareTitle(for: route),
            "",
            shareSummaryText(for: route),
            "",
            shareStopsText(for: route),
            "",
            "Bu rota GezioGo ile hazırlandı. Şehri planlı ve keyifli şekilde keşfet."
        ]
        .filter { !$0.isEmpty }
        .joined(separator: "\n")
    }

    private static func shareSummaryText(for route: TripRoute) -> String {
        var lines: [String] = []

        lines.append("Şehir: \(route.cityId.capitalized)")

        if let totalDurationMinutes = route.totalDurationMinutes {
            lines.append("Süre: \(durationText(totalDurationMinutes))")
        } else {
            lines.append("Rota tipi: \(durationTypeText(route.durationType))")
        }

        if route.totalDurationMinutes != nil {
            lines.append("Rota tipi: \(durationTypeText(route.durationType))")
        }

        if let transportType = route.transportType {
            lines.append("Ulaşım: \(transportType.displayName)")
        }

        if let tempo = route.tempo {
            lines.append("Tempo: \(tempo.displayName)")
        }

        if let budget = route.estimatedCostLevel ?? route.budget {
            lines.append("Tahmini bütçe: \(budget.displayName)")
        }

        if !route.interests.isEmpty {
            let interests = route.interests
                .map { interestDisplayName($0) }
                .joined(separator: ", ")

            lines.append("İlgi alanları: \(interests)")
        }

        return lines.joined(separator: "\n")
    }

    private static func shareStopsText(for route: TripRoute) -> String {
        let sortedStops = route.stops.sorted { $0.order < $1.order }

        guard !sortedStops.isEmpty else {
            return "Durak bilgisi henüz eklenmemiş."
        }

        let stopLines = sortedStops.map { stop in
            if let timeLabel = stop.timeLabel {
                return "\(stop.order). \(stop.title) - \(timeLabel)"
            } else {
                return "\(stop.order). \(stop.title)"
            }
        }

        return """
        Duraklar:
        \(stopLines.joined(separator: "\n"))
        """
    }

    private static func durationText(_ minutes: Int) -> String {
        if minutes < 60 {
            return "\(minutes) dk"
        } else if minutes == 60 {
            return "1 saat"
        } else {
            let hour = minutes / 60
            let remaining = minutes % 60

            if remaining == 0 {
                return "\(hour) saat"
            } else {
                return "\(hour)s \(remaining)dk"
            }
        }
    }

    private static func durationTypeText(_ durationType: RouteDurationType) -> String {
        switch durationType {
        case .halfDay:
            return "Yarım Gün"
        case .oneDay:
            return "1 Gün"
        case .twoDays:
            return "2 Gün"
        case .custom:
            return "Özel"
        }
    }

    private static func interestDisplayName(_ interest: String) -> String {
        switch interest {
        case "history":
            return "Tarih"
        case "nature":
            return "Doğa"
        case "food_drink":
            return "Yeme İçme"
        case "museum":
            return "Müze"
        case "family":
            return "Aile"
        case "culture":
            return "Kültür"
        default:
            return interest
        }
    }
}

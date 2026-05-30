import Foundation

enum AIPlannerMockRouteBuilder {
    static func buildRoute(from request: AIPlannerRequest) -> TripRoute {
        let now = Date()
        let dateText = isoDateFormatter.string(from: request.startDate)

        let durationType = durationType(for: request.dayCount)
        let budgetLevel = budgetLevel(for: request.budget)
        let transportType = transportType(for: request.transport)
        let tempo = tempo(for: request.tempo)
        let interests = request.interests.map { interestKey(for: $0) }

        let stops = buildStops(for: request)

        return TripRoute(
            id: "ai_route_\(UUID().uuidString)",
            userId: FirebaseAuthService.shared.userId,
            cityId: request.cityId,
            title: "\(request.cityName) için AI Destekli \(request.dayCount) Günlük Rota",
            date: dateText,
            durationType: durationType,
            budget: budgetLevel,
            interests: interests,
            transportType: transportType,
            companions: "\(request.personCount) kişi",
            tempo: tempo,
            stops: stops,
            totalDurationMinutes: stops.compactMap(\.durationMinutes).reduce(0, +),
            totalDistanceKm: totalDistance(for: request),
            estimatedCostLevel: budgetLevel,
            aiPromptVersion: "mock_v1",
            isSaved: false,
            createdAt: isoDateTimeFormatter.string(from: now),
            updatedAt: isoDateTimeFormatter.string(from: now)
        )
    }

    private static func buildStops(for request: AIPlannerRequest) -> [RouteStop] {
        let city = request.cityName
        let isSamsun = request.cityId == "samsun"

        if request.dayCount <= 1 {
            return [
                RouteStop(
                    order: 1,
                    type: .place,
                    placeId: isSamsun ? "bandirma-vapuru-muzesi" : nil,
                    eventId: nil,
                    title: isSamsun ? "Bandırma Vapuru Müzesi" : "\(city) şehir merkezi keşfi",
                    timeLabel: "09:30 - 11:00",
                    durationMinutes: 90,
                    note: "Güne şehrin simge noktalarından biriyle başla. Fotoğraf ve kısa keşif için ideal.",
                    latitude: isSamsun ? 41.2894 : nil,
                    longitude: isSamsun ? 36.3350 : nil
                ),
                RouteStop(
                    order: 2,
                    type: .food,
                    placeId: nil,
                    eventId: nil,
                    title: "Yerel lezzet molası",
                    timeLabel: "12:00 - 13:15",
                    durationMinutes: 75,
                    note: "\(city) mutfağından öne çıkan lezzetleri denemek için öğle molası.",
                    latitude: isSamsun ? 41.2867 : nil,
                    longitude: isSamsun ? 36.3300 : nil
                ),
                RouteStop(
                    order: 3,
                    type: .place,
                    placeId: isSamsun ? "amazon-koyu" : nil,
                    eventId: nil,
                    title: isSamsun ? "Amazon Köyü" : "\(city) kültür durağı",
                    timeLabel: "14:00 - 15:30",
                    durationMinutes: 90,
                    note: "Tarih, kültür ve fotoğraf noktalarını birleştiren keyifli bir durak.",
                    latitude: isSamsun ? 41.3380 : nil,
                    longitude: isSamsun ? 36.2820 : nil
                ),
                RouteStop(
                    order: 4,
                    type: .breakTime,
                    placeId: nil,
                    eventId: nil,
                    title: "Kahve ve dinlenme molası",
                    timeLabel: "16:00 - 16:45",
                    durationMinutes: 45,
                    note: "Tempoyu dengelemek için kısa bir mola.",
                    latitude: isSamsun ? 41.3360 : nil,
                    longitude: isSamsun ? 36.2600 : nil
                ),
                RouteStop(
                    order: 5,
                    type: .place,
                    placeId: isSamsun ? "atakum-sahili" : nil,
                    eventId: nil,
                    title: isSamsun ? "Atakum Sahili" : "\(city) sahil / yürüyüş noktası",
                    timeLabel: "17:30 - 19:00",
                    durationMinutes: 90,
                    note: "Günü yürüyüş, gün batımı ve rahat bir akşam atmosferiyle bitir.",
                    latitude: isSamsun ? 41.3378 : nil,
                    longitude: isSamsun ? 36.2490 : nil
                )
            ]
        }

        return [
            RouteStop(
                order: 1,
                type: .place,
                placeId: isSamsun ? "bandirma-vapuru-muzesi" : nil,
                eventId: nil,
                title: isSamsun ? "Bandırma Vapuru Müzesi" : "\(city) simge noktası",
                timeLabel: "1. Gün / 09:30 - 11:00",
                durationMinutes: 90,
                note: "Rotaya şehrin karakterini anlatan güçlü bir başlangıç noktasıyla başla.",
                latitude: isSamsun ? 41.2894 : nil,
                longitude: isSamsun ? 36.3350 : nil
            ),
            RouteStop(
                order: 2,
                type: .food,
                placeId: nil,
                eventId: nil,
                title: "Yerel lezzet deneyimi",
                timeLabel: "1. Gün / 12:30 - 14:00",
                durationMinutes: 90,
                note: "Bütçene ve kişi sayına uygun yerel lezzet molası.",
                latitude: isSamsun ? 41.2867 : nil,
                longitude: isSamsun ? 36.3300 : nil
            ),
            RouteStop(
                order: 3,
                type: .place,
                placeId: isSamsun ? "amazon-koyu" : nil,
                eventId: nil,
                title: isSamsun ? "Amazon Köyü" : "\(city) kültür rotası",
                timeLabel: "1. Gün / 15:00 - 17:00",
                durationMinutes: 120,
                note: "İlgi alanlarına göre kültür, tarih ve fotoğraf odaklı bir durak.",
                latitude: isSamsun ? 41.3380 : nil,
                longitude: isSamsun ? 36.2820 : nil
            ),
            RouteStop(
                order: 4,
                type: .place,
                placeId: isSamsun ? "atakum-sahili" : nil,
                eventId: nil,
                title: isSamsun ? "Atakum Sahili" : "\(city) gün batımı noktası",
                timeLabel: "1. Gün / 18:00 - 19:30",
                durationMinutes: 90,
                note: "Günü daha rahat bir yürüyüş ve manzara molasıyla tamamla.",
                latitude: isSamsun ? 41.3378 : nil,
                longitude: isSamsun ? 36.2490 : nil
            ),
            RouteStop(
                order: 5,
                type: .place,
                placeId: nil,
                eventId: nil,
                title: "\(city) ikinci gün keşif başlangıcı",
                timeLabel: "2. Gün / 10:00 - 12:00",
                durationMinutes: 120,
                note: "İkinci güne daha sakin tempolu keşif noktalarıyla başla.",
                latitude: isSamsun ? 41.2920 : nil,
                longitude: isSamsun ? 36.3200 : nil
            ),
            RouteStop(
                order: 6,
                type: .food,
                placeId: nil,
                eventId: nil,
                title: "Öğle yemeği ve serbest zaman",
                timeLabel: "2. Gün / 12:30 - 14:00",
                durationMinutes: 90,
                note: "Yakındaki restoran/kafe seçenekleri için esnek zaman bırakıldı.",
                latitude: isSamsun ? 41.3000 : nil,
                longitude: isSamsun ? 36.3100 : nil
            ),
            RouteStop(
                order: 7,
                type: .other,
                placeId: nil,
                eventId: nil,
                title: "Kapanış durağı",
                timeLabel: "2. Gün / 16:00 - 18:00",
                durationMinutes: 120,
                note: "Alışveriş, sahil yürüyüşü veya kısa etkinlik için esnek kapanış durağı.",
                latitude: isSamsun ? 41.3200 : nil,
                longitude: isSamsun ? 36.2800 : nil
            )
        ]
    }

    private static func durationType(for dayCount: Int) -> RouteDurationType {
        switch dayCount {
        case 1:
            return .oneDay
        case 2:
            return .twoDays
        default:
            return .custom
        }
    }

    private static func budgetLevel(for budget: String) -> BudgetLevel {
        if budget.contains("₺0") || budget.contains("₺1.500") {
            return .low
        }

        if budget.contains("₺3.000") || budget.contains("₺5.000") || budget.contains("₺7.500") {
            return .medium
        }

        if budget.contains("₺10.000") || budget.contains("₺15.000") || budget.contains("₺20.000") || budget.contains("₺30.000") {
            return .high
        }

        return .unknown
    }

    private static func transportType(for transport: String) -> TransportType {
        switch transport {
        case "Yürüyüş":
            return .walking
        case "Toplu Taşıma":
            return .publicTransport
        case "Araç":
            return .car
        default:
            return .mixed
        }
    }

    private static func tempo(for tempo: String) -> TravelTempo {
        switch tempo {
        case "Rahat":
            return .slow
        case "Yoğun":
            return .intense
        default:
            return .balanced
        }
    }

    private static func interestKey(for interest: String) -> String {
        switch interest {
        case "Tarih":
            return "history"
        case "Yemek":
            return "food_drink"
        case "Doğa":
            return "nature"
        case "Sanat":
            return "culture"
        case "Alışveriş":
            return "shopping"
        default:
            return interest.localizedLowercase
        }
    }

    private static func totalDistance(for request: AIPlannerRequest) -> Double {
        if request.cityId == "samsun" {
            return request.dayCount <= 1 ? 14.8 : 28.4
        }

        return request.dayCount <= 1 ? 8.5 : 18.0
    }

    private static var isoDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    private static var isoDateTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
}

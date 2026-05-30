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
            totalDistanceKm: totalDistance(for: request, stopCount: stops.count),
            estimatedCostLevel: budgetLevel,
            aiPromptVersion: "mock_v2",
            isSaved: false,
            createdAt: isoDateTimeFormatter.string(from: now),
            updatedAt: isoDateTimeFormatter.string(from: now)
        )
    }

    private static func buildStops(for request: AIPlannerRequest) -> [RouteStop] {
        let templates = stopTemplates(for: request)
        let selectedTemplates = limitTemplatesByTempo(
            templates,
            tempo: request.tempo,
            dayCount: request.dayCount
        )

        return selectedTemplates.enumerated().map { index, template in
            let order = index + 1
            let timeLabel = timeLabel(
                order: order,
                dayCount: request.dayCount,
                tempo: request.tempo
            )

            return RouteStop(
                order: order,
                type: template.type,
                placeId: template.placeId,
                eventId: nil,
                title: template.title,
                timeLabel: timeLabel,
                durationMinutes: template.durationMinutes,
                note: note(
                    for: template,
                    request: request
                ),
                latitude: template.latitude,
                longitude: template.longitude
            )
        }
    }

    private static func stopTemplates(for request: AIPlannerRequest) -> [MockStopTemplate] {
        let isSamsun = request.cityId == "samsun"
        let city = request.cityName
        let interests = Set(request.interests)

        var templates: [MockStopTemplate] = []

        templates.append(
            MockStopTemplate(
                type: .place,
                placeId: isSamsun ? "bandirma-vapuru-muzesi" : nil,
                title: isSamsun ? "Bandırma Vapuru Müzesi" : "\(city) şehir merkezi keşfi",
                durationMinutes: 90,
                baseNote: "Güne şehrin simge noktalarından biriyle başla.",
                latitude: isSamsun ? 41.2894 : nil,
                longitude: isSamsun ? 36.3350 : nil
            )
        )

        if interests.contains("Tarih") {
            templates.append(
                MockStopTemplate(
                    type: .place,
                    placeId: isSamsun ? "bandirma-vapuru-muzesi" : nil,
                    title: isSamsun ? "Bandırma Vapuru tarihi keşfi" : "\(city) tarih rotası",
                    durationMinutes: 75,
                    baseNote: "Tarih odaklı kısa anlatım, fotoğraf ve şehir hafızası için uygun bir durak.",
                    latitude: isSamsun ? 41.2894 : nil,
                    longitude: isSamsun ? 36.3350 : nil
                )
            )
        }

        if interests.contains("Doğa") {
            templates.append(
                MockStopTemplate(
                    type: .place,
                    placeId: isSamsun ? "atakum-sahili" : nil,
                    title: isSamsun ? "Atakum Sahili yürüyüş molası" : "\(city) doğa yürüyüş noktası",
                    durationMinutes: 90,
                    baseNote: "Doğa, yürüyüş ve manzara için tempoyu dengeleyen açık alan molası.",
                    latitude: isSamsun ? 41.3378 : nil,
                    longitude: isSamsun ? 36.2490 : nil
                )
            )
        }

        if interests.contains("Yemek") {
            templates.append(
                MockStopTemplate(
                    type: .food,
                    placeId: nil,
                    title: "Yerel lezzet deneyimi",
                    durationMinutes: 80,
                    baseNote: "\(city) mutfağından öne çıkan lezzetleri denemek için planlandı.",
                    latitude: isSamsun ? 41.2867 : nil,
                    longitude: isSamsun ? 36.3300 : nil
                )
            )
        }

        if interests.contains("Sanat") {
            templates.append(
                MockStopTemplate(
                    type: .place,
                    placeId: isSamsun ? "amazon-koyu" : nil,
                    title: isSamsun ? "Amazon Köyü kültür durağı" : "\(city) sanat ve kültür durağı",
                    durationMinutes: 90,
                    baseNote: "Kültür, hikâye ve görsel keşif için rota içine eklendi.",
                    latitude: isSamsun ? 41.3380 : nil,
                    longitude: isSamsun ? 36.2820 : nil
                )
            )
        }

        if interests.contains("Alışveriş") {
            templates.append(
                MockStopTemplate(
                    type: .other,
                    placeId: nil,
                    title: "\(city) yerel alışveriş ve serbest zaman",
                    durationMinutes: 70,
                    baseNote: "Yerel ürünler, hediyelikler ve kısa serbest zaman için ayrıldı.",
                    latitude: isSamsun ? 41.2920 : nil,
                    longitude: isSamsun ? 36.3200 : nil
                )
            )
        }

        templates.append(
            MockStopTemplate(
                type: .breakTime,
                placeId: nil,
                title: "Kahve ve dinlenme molası",
                durationMinutes: 45,
                baseNote: "Rotanın temposunu dengelemek için kısa bir mola.",
                latitude: isSamsun ? 41.3360 : nil,
                longitude: isSamsun ? 36.2600 : nil
            )
        )

        templates.append(
            MockStopTemplate(
                type: .place,
                placeId: isSamsun ? "atakum-sahili" : nil,
                title: isSamsun ? "Atakum Sahili gün batımı" : "\(city) kapanış yürüyüşü",
                durationMinutes: 90,
                baseNote: "Günü yürüyüş, manzara ve rahat bir kapanışla bitir.",
                latitude: isSamsun ? 41.3378 : nil,
                longitude: isSamsun ? 36.2490 : nil
            )
        )

        if request.dayCount >= 2 {
            templates.append(
                MockStopTemplate(
                    type: .place,
                    placeId: nil,
                    title: "\(city) ikinci gün keşif başlangıcı",
                    durationMinutes: 110,
                    baseNote: "İkinci güne daha sakin ve esnek bir keşif noktasıyla başla.",
                    latitude: isSamsun ? 41.3000 : nil,
                    longitude: isSamsun ? 36.3100 : nil
                )
            )

            templates.append(
                MockStopTemplate(
                    type: .food,
                    placeId: nil,
                    title: "Öğle yemeği ve serbest zaman",
                    durationMinutes: 90,
                    baseNote: "Yakındaki restoran ve kafe seçenekleri için esnek zaman bırakıldı.",
                    latitude: isSamsun ? 41.3050 : nil,
                    longitude: isSamsun ? 36.3000 : nil
                )
            )

            templates.append(
                MockStopTemplate(
                    type: .other,
                    placeId: nil,
                    title: "\(city) kapanış durağı",
                    durationMinutes: 100,
                    baseNote: "Alışveriş, sahil yürüyüşü veya kısa etkinlik için esnek kapanış noktası.",
                    latitude: isSamsun ? 41.3200 : nil,
                    longitude: isSamsun ? 36.2800 : nil
                )
            )
        }

        return templates
    }

    private static func limitTemplatesByTempo(
        _ templates: [MockStopTemplate],
        tempo: String,
        dayCount: Int
    ) -> [MockStopTemplate] {
        let maxStopCount: Int

        if dayCount <= 1 {
            switch tempo {
            case "Rahat":
                maxStopCount = 4
            case "Yoğun":
                maxStopCount = 7
            default:
                maxStopCount = 5
            }
        } else {
            switch tempo {
            case "Rahat":
                maxStopCount = 6
            case "Yoğun":
                maxStopCount = 10
            default:
                maxStopCount = 8
            }
        }

        return Array(templates.prefix(maxStopCount))
    }

    private static func timeLabel(
        order: Int,
        dayCount: Int,
        tempo: String
    ) -> String {
        let oneDayBalanced = [
            "09:30 - 11:00",
            "11:30 - 12:45",
            "13:15 - 14:45",
            "15:15 - 16:00",
            "16:30 - 18:00",
            "18:15 - 19:30",
            "20:00 - 21:00"
        ]

        let oneDayRelaxed = [
            "10:00 - 11:30",
            "12:00 - 13:15",
            "14:30 - 16:00",
            "17:00 - 18:30",
            "19:00 - 20:00"
        ]

        let oneDayIntense = [
            "09:00 - 10:15",
            "10:45 - 12:00",
            "12:30 - 13:30",
            "14:00 - 15:15",
            "15:45 - 17:00",
            "17:30 - 18:45",
            "19:15 - 20:30"
        ]

        if dayCount <= 1 {
            let labels: [String]

            switch tempo {
            case "Rahat":
                labels = oneDayRelaxed
            case "Yoğun":
                labels = oneDayIntense
            default:
                labels = oneDayBalanced
            }

            return labels[safe: order - 1] ?? "Gün içinde esnek saat"
        }

        let day = order <= 4 ? 1 : 2
        let indexInDay = day == 1 ? order : order - 4

        let multiDayLabels = [
            "09:30 - 11:00",
            "12:00 - 13:30",
            "14:30 - 16:00",
            "17:00 - 18:30",
            "10:00 - 11:30",
            "12:30 - 14:00",
            "15:00 - 16:30",
            "17:00 - 18:30"
        ]

        let label = multiDayLabels[safe: order - 1] ?? "Gün içinde esnek saat"

        return "\(day). Gün / \(label)"
    }

    private static func note(
        for template: MockStopTemplate,
        request: AIPlannerRequest
    ) -> String {
        var parts: [String] = [template.baseNote]

        switch request.tempo {
        case "Rahat":
            parts.append("Rahat tempo seçildiği için duraklar arasında daha fazla boşluk bırakıldı.")
        case "Yoğun":
            parts.append("Yoğun tempo seçildiği için gün içine daha fazla keşif noktası eklendi.")
        default:
            parts.append("Dengeli bir tempo için keşif ve mola süreleri birlikte planlandı.")
        }

        switch request.transport {
        case "Yürüyüş":
            parts.append("Yürüyüşe uygun kısa mesafe mantığıyla düşünüldü.")
        case "Toplu Taşıma":
            parts.append("Toplu taşıma kullanımı için geçişler esnek bırakıldı.")
        case "Araç":
            parts.append("Araçla ulaşımda daha geniş alanlara yayılabilecek şekilde planlandı.")
        default:
            break
        }

        if request.budget.contains("₺0") || request.budget.contains("₺1.500") {
            parts.append("Düşük bütçeye uygun ücretsiz veya ekonomik seçenekler öne çıkarıldı.")
        } else if request.budget.contains("₺10.000") || request.budget.contains("₺20.000") || request.budget.contains("₺30.000") {
            parts.append("Daha konforlu mola ve yemek seçenekleri için bütçe esnek tutuldu.")
        }

        return parts.joined(separator: " ")
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

    private static func totalDistance(
        for request: AIPlannerRequest,
        stopCount: Int
    ) -> Double {
        let baseDistance: Double

        switch request.transport {
        case "Yürüyüş":
            baseDistance = 1.4
        case "Toplu Taşıma":
            baseDistance = 2.6
        case "Araç":
            baseDistance = 4.1
        default:
            baseDistance = 2.2
        }

        let dayMultiplier = max(Double(request.dayCount), 1)
        let distance = Double(stopCount) * baseDistance * min(dayMultiplier, 2.5)

        return (distance * 10).rounded() / 10
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

private struct MockStopTemplate {
    let type: RouteStopType
    let placeId: String?
    let title: String
    let durationMinutes: Int
    let baseNote: String
    let latitude: Double?
    let longitude: Double?
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else {
            return nil
        }

        return self[index]
    }
}

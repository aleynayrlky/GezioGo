import Foundation
import Combine

@MainActor
final class RouteDetailViewModel: ObservableObject {
    @Published var route: TripRoute
    @Published var places: [Place] = []
    @Published var isLoadingPlaces = false
    @Published var placeLoadErrorMessage: String?

    private let dataService: DataServiceProtocol

    init(
        route: TripRoute,
        dataService: DataServiceProtocol? = nil
    ) {
        self.route = route
        self.dataService = dataService ?? MockDataService()
    }

    var durationText: String {
        guard let minutes = route.totalDurationMinutes else {
            return durationTypeText
        }

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

    var durationTypeText: String {
        switch route.durationType {
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

    var transportText: String {
        route.transportType?.displayName ?? "Ulaşım bilgisi yok"
    }

    var tempoText: String {
        route.tempo?.displayName ?? "Tempo bilgisi yok"
    }

    var budgetText: String {
        if let estimatedCostLevel = route.estimatedCostLevel {
            return estimatedCostLevel.displayName
        }

        if let budget = route.budget {
            return budget.displayName
        }

        return "Bütçe bilgisi yok"
    }

    var distanceText: String {
        guard let distance = route.totalDistanceKm else {
            return "Mesafe bilgisi yok"
        }

        return String(format: "%.1f km", distance)
    }

    var companionText: String {
        guard let companions = route.companions, !companions.isEmpty else {
            return "Herkes için uygun"
        }

        return companions
    }

    var interestsText: String {
        route.interests
            .map { interestDisplayName($0) }
            .joined(separator: ", ")
    }

    var sortedStops: [RouteStop] {
        route.stops.sorted { $0.order < $1.order }
    }

    func loadPlaces() async {
        isLoadingPlaces = true
        placeLoadErrorMessage = nil

        do {
            places = try await dataService.fetchPlaces(cityId: route.cityId)
        } catch {
            placeLoadErrorMessage = error.localizedDescription
        }

        isLoadingPlaces = false
    }

    func place(for stop: RouteStop) -> Place? {
        guard let placeId = stop.placeId else {
            return nil
        }

        return places.first { $0.id == placeId }
    }

    func interestDisplayName(_ interest: String) -> String {
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

    func stopTypeText(_ type: RouteStopType) -> String {
        switch type {
        case .place:
            return "Mekan"
        case .event:
            return "Etkinlik"
        case .food:
            return "Yeme İçme"
        case .breakTime:
            return "Mola"
        case .other:
            return "Diğer"
        }
    }

    func stopTypeIcon(_ type: RouteStopType) -> String {
        switch type {
        case .place:
            return "mappin.and.ellipse"
        case .event:
            return "calendar"
        case .food:
            return "fork.knife"
        case .breakTime:
            return "cup.and.saucer"
        case .other:
            return "sparkles"
        }
    }
}

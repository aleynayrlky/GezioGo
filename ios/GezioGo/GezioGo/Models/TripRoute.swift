import Foundation

enum RouteDurationType: String, Codable, Hashable {
    case halfDay = "half_day"
    case oneDay = "one_day"
    case twoDays = "two_days"
    case custom
}

enum BudgetLevel: String, Codable, Hashable {
    case low
    case medium
    case high
    case unknown

    var displayName: String {
        switch self {
        case .low:
            return "Düşük"
        case .medium:
            return "Orta"
        case .high:
            return "Yüksek"
        case .unknown:
            return "Bilinmiyor"
        }
    }
}

enum TransportType: String, Codable, Hashable {
    case walking
    case publicTransport = "public_transport"
    case car
    case mixed

    var displayName: String {
        switch self {
        case .walking:
            return "Yürüyerek"
        case .publicTransport:
            return "Toplu Taşıma"
        case .car:
            return "Araç"
        case .mixed:
            return "Karma"
        }
    }
}

enum TravelTempo: String, Codable, Hashable {
    case slow
    case balanced
    case intense

    var displayName: String {
        switch self {
        case .slow:
            return "Rahat"
        case .balanced:
            return "Dengeli"
        case .intense:
            return "Yoğun"
        }
    }
}

struct TripRoute: Identifiable, Codable, Hashable {
    let id: String
    let userId: String?
    let cityId: String
    let title: String
    let date: String?
    let durationType: RouteDurationType
    let budget: BudgetLevel?
    let interests: [String]
    let transportType: TransportType?
    let companions: String?
    let tempo: TravelTempo?
    let stops: [RouteStop]
    let totalDurationMinutes: Int?
    let totalDistanceKm: Double?
    let estimatedCostLevel: BudgetLevel?
    let aiPromptVersion: String?
    let isSaved: Bool
    let createdAt: String
    let updatedAt: String
}//
//  TripRoute.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


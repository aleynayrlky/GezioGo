import Foundation

enum RouteStopType: String, Codable, Hashable {
    case place
    case event
    case food
    case breakTime = "break"
    case other
}

struct RouteStop: Identifiable, Codable, Hashable {
    var id: String {
        "\(order)-\(title)"
    }

    let order: Int
    let type: RouteStopType
    let placeId: String?
    let eventId: String?
    let title: String
    let timeLabel: String?
    let durationMinutes: Int?
    let note: String?
    let latitude: Double?
    let longitude: Double?
}
//
//  RouteStop.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


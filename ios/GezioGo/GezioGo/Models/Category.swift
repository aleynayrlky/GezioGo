import Foundation

enum PlaceCategory: String, Codable, Hashable, CaseIterable {
    case historical
    case museum
    case nature
    case foodDrink = "food_drink"
    case beach
    case shopping
    case religious
    case family
    case hiddenGem = "hidden_gem"
    case entertainment
    case other

    var displayName: String {
        switch self {
        case .historical:
            return "Tarihi Yerler"
        case .museum:
            return "Müzeler"
        case .nature:
            return "Doğa"
        case .foodDrink:
            return "Yeme İçme"
        case .beach:
            return "Sahil"
        case .shopping:
            return "Alışveriş"
        case .religious:
            return "İnanç Noktaları"
        case .family:
            return "Aile Dostu"
        case .hiddenGem:
            return "Gizli Rotalar"
        case .entertainment:
            return "Eğlence"
        case .other:
            return "Diğer"
        }
    }

    var iconName: String {
        switch self {
        case .historical:
            return "building.columns"
        case .museum:
            return "building.columns.fill"
        case .nature:
            return "leaf"
        case .foodDrink:
            return "fork.knife"
        case .beach:
            return "water.waves"
        case .shopping:
            return "bag"
        case .religious:
            return "sparkles"
        case .family:
            return "figure.2.and.child.holdinghands"
        case .hiddenGem:
            return "mappin.and.ellipse"
        case .entertainment:
            return "music.note"
        case .other:
            return "square.grid.2x2"
        }
    }
}

enum EventCategory: String, Codable, Hashable, CaseIterable {
    case concert
    case festival
    case theater
    case exhibition
    case workshop
    case sports
    case kids
    case culture
    case cinema
    case conference
    case other

    var displayName: String {
        switch self {
        case .concert:
            return "Konser"
        case .festival:
            return "Festival"
        case .theater:
            return "Tiyatro"
        case .exhibition:
            return "Sergi"
        case .workshop:
            return "Atölye"
        case .sports:
            return "Spor"
        case .kids:
            return "Çocuk"
        case .culture:
            return "Kültür-Sanat"
        case .cinema:
            return "Sinema"
        case .conference:
            return "Konferans"
        case .other:
            return "Diğer"
        }
    }

    var iconName: String {
        switch self {
        case .concert:
            return "music.mic"
        case .festival:
            return "party.popper"
        case .theater:
            return "theatermasks"
        case .exhibition:
            return "photo.artframe"
        case .workshop:
            return "hammer"
        case .sports:
            return "figure.run"
        case .kids:
            return "figure.and.child.holdinghands"
        case .culture:
            return "building.columns"
        case .cinema:
            return "film"
        case .conference:
            return "person.3"
        case .other:
            return "calendar"
        }
    }
}//
//  Category.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


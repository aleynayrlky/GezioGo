import Foundation

enum MainTab: Hashable {
    case home
    case explore
    case map
    case favorites
    case profile

    var title: String {
        switch self {
        case .home:
            return "Ana Sayfa"
        case .explore:
            return "Keşfet"
        case .map:
            return "Harita"
        case .favorites:
            return "Favoriler"
        case .profile:
            return "Profil"
        }
    }

    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .explore:
            return "sparkles"
        case .map:
            return "map"
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        }
    }

    var selectedIconName: String {
        switch self {
        case .home:
            return "house.fill"
        case .explore:
            return "sparkles"
        case .map:
            return "map.fill"
        case .favorites:
            return "heart.fill"
        case .profile:
            return "person.fill"
        }
    }
}//
//  MainTab.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


import Foundation

enum PriceType: String, Codable, Hashable {
    case free
    case paid
    case unknown

    var displayName: String {
        switch self {
        case .free:
            return "Ücretsiz"
        case .paid:
            return "Ücretli"
        case .unknown:
            return "Bilinmiyor"
        }
    }
}//
//  PriceType.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


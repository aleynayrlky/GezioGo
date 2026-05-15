import Foundation

enum ContentStatus: String, Codable, Hashable {
    case draft
    case pendingReview = "pending_review"
    case approved
    case published
    case rejected
    case needsRevision = "needs_revision"
    case archived

    var displayName: String {
        switch self {
        case .draft:
            return "Taslak"
        case .pendingReview:
            return "İnceleme Bekliyor"
        case .approved:
            return "Onaylandı"
        case .published:
            return "Yayında"
        case .rejected:
            return "Reddedildi"
        case .needsRevision:
            return "Revizyon Gerekli"
        case .archived:
            return "Arşivlendi"
        }
    }
}//
//  ContentStatus.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


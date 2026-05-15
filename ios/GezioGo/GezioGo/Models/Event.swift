import Foundation

struct Event: Identifiable, Codable, Hashable {
    let id: String
    let cityId: String
    let title: String
    let slug: String
    let category: EventCategory
    let description: String
    let venueName: String
    let placeId: String?
    let district: String?
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let startDate: String
    let endDate: String?
    let priceType: PriceType
    let priceInfo: String?
    let ticketUrl: String?
    let organizer: String?
    let partnerId: String?
    let sourceUrl: String?
    let imageUrl: String?
    let imageUrls: [String]
    let tags: [String]
    let isChildFriendly: Bool
    let isIndoor: Bool
    let isOutdoor: Bool
    let contentStatus: ContentStatus
    let createdBy: String?
    let approvedBy: String?
    let lastVerifiedAt: String?
    let createdAt: String
    let updatedAt: String
}//
//  Event.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


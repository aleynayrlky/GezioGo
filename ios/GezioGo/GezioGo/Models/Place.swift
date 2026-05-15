import Foundation

struct Place: Identifiable, Codable, Hashable {
    let id: String
    let cityId: String
    let name: String
    let slug: String
    let category: PlaceCategory
    let subCategory: String?
    let shortDescription: String
    let longDescription: String?
    let district: String
    let address: String
    let latitude: Double
    let longitude: Double
    let openingHours: String?
    let priceType: PriceType
    let priceInfo: String?
    let ticketUrl: String?
    let sourceUrl: String?
    let imageUrls: [String]
    let tags: [String]
    let isIndoor: Bool
    let isOutdoor: Bool
    let isChildFriendly: Bool
    let isStudentFriendly: Bool
    let isAccessible: Bool
    let averageVisitDurationMinutes: Int?
    let partnerId: String?
    let contentStatus: ContentStatus
    let createdBy: String?
    let approvedBy: String?
    let lastVerifiedAt: String?
    let createdAt: String
    let updatedAt: String
}//
//  Place.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


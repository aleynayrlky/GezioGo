//
//  City.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//

import Foundation

struct City: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let slug: String
    let country: String
    let region: String
    let shortDescription: String
    let longDescription: String?
    let coverImageUrl: String?
    let thumbnailUrl: String?
    let latitude: Double
    let longitude: Double
    let popularCategoryIds: [String]
    let weatherRegionCode: String?
    let isActive: Bool
    let createdAt: String
    let updatedAt: String
}

import Foundation

enum AppRoute: Hashable {
    case explore(cityId: String)
    case placeList(cityId: String, category: PlaceCategory?)
    case placeDetail(place: Place)
}//
//  AppRoute.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


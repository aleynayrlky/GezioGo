import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var hasSeenOnboarding: Bool = false
    @Published var selectedCityId: String? = nil
    
    func selectCity(_ city: City) {
        selectedCityId = city.id
    }
}//
//  AppState.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var hasSeenOnboarding: Bool = false
    @Published var selectedCityId: String? = nil
}//
//  AppState.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


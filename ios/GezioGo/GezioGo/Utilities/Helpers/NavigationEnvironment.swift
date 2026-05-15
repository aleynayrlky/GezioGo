import SwiftUI

private struct NavigateKey: EnvironmentKey {
    static let defaultValue: (AppRoute) -> Void = { _ in }
}

extension EnvironmentValues {
    var navigate: (AppRoute) -> Void {
        get { self[NavigateKey.self] }
        set { self[NavigateKey.self] = newValue }
    }
}//
//  NavigationEnvironment.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


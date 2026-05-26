import SwiftUI
import FirebaseCore

@main
struct GezioGoApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

import SwiftUI

struct RootView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        VStack(spacing: 16) {
            Text("GezioGo")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Şehir seninle keşfedilir")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    RootView()
}

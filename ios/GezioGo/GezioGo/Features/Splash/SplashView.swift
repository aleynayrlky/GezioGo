import SwiftUI

struct SplashView: View {
    var onFinish: () -> Void
    var onAuthTap: (() -> Void)? = nil

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AppColors.background
                    .ignoresSafeArea()

                Image("splashWelcomeBackground")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)

                Button {
                    onFinish()
                } label: {
                    Color.black.opacity(0.001)
                }
                .frame(
                    width: geometry.size.width * 0.78,
                    height: 68
                )
                .contentShape(RoundedRectangle(cornerRadius: 28))
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height * 0.807
                )
                .buttonStyle(.plain)

                Button {
                    onAuthTap?()
                } label: {
                    Color.black.opacity(0.001)
                }
                .frame(
                    width: geometry.size.width * 0.70,
                    height: 54
                )
                .contentShape(Rectangle())
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height * 0.895
                )
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    SplashView(
        onFinish: {},
        onAuthTap: {}
    )
}

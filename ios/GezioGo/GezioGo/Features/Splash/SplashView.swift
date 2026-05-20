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
                    .frame(maxHeight: .infinity, alignment: .center)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)

                VStack {
                    Spacer()

                    Button {
                        onFinish()
                    } label: {
                        Color.black.opacity(0.001)
                    }
                    .frame(
                        width: geometry.size.width * 0.78,
                        height: 76
                    )
                    .contentShape(RoundedRectangle(cornerRadius: 28))
                    .padding(.bottom, 22)

                    Button {
                        onAuthTap?()
                    } label: {
                        Color.black.opacity(0.001)
                    }
                    .frame(
                        width: geometry.size.width * 0.70,
                        height: 58
                    )
                    .contentShape(Rectangle())
                    .padding(.bottom, 36)
                }
                .zIndex(2)
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

//
//  SplashView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//

import SwiftUI

struct SplashView: View {
    var onFinish: () -> Void

    @State private var isLogoVisible = false
    @State private var isContentVisible = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    AppColors.deepPetrol,
                    AppColors.petrol,
                    AppColors.teal
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                ZStack {
                    Circle()
                        .fill(AppColors.cream.opacity(0.18))
                        .frame(width: 132, height: 132)

                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 56, weight: .bold))
                        .foregroundStyle(AppColors.gold)
                }
                .scaleEffect(isLogoVisible ? 1 : 0.75)
                .opacity(isLogoVisible ? 1 : 0)

                VStack(spacing: AppSpacing.xs) {
                    Text("GezioGo")
                        .font(AppTypography.largeTitle)
                        .foregroundStyle(.white)

                    Text("Şehir seninle keşfedilir")
                        .font(AppTypography.bodyMedium)
                        .foregroundStyle(AppColors.cream.opacity(0.9))
                }
                .opacity(isContentVisible ? 1 : 0)
                .offset(y: isContentVisible ? 0 : 12)
            }
            .padding(AppSpacing.lg)
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.75)) {
                isLogoVisible = true
            }

            withAnimation(.easeOut(duration: 0.7).delay(0.25)) {
                isContentVisible = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                onFinish()
            }
        }
    }
}

#Preview {
    SplashView {}
}

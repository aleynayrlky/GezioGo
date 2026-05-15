//
//  OnboardingView.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//

import SwiftUI

struct OnboardingView: View {
    var onFinish: () -> Void

    @State private var selectedPage = 0

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            iconName: "map",
            title: "Şehri kolayca keşfet",
            description: "Gezilecek yerleri, müzeleri, sahilleri, kafeleri ve etkinlikleri düzenli şekilde incele.",
            tagTitle: "Keşfet"
        ),
        OnboardingPage(
            iconName: "wand.and.stars",
            title: "AI ile rota oluştur",
            description: "Zamanına, bütçene ve ilgi alanlarına göre sana özel şehir rotası hazırla.",
            tagTitle: "Planla"
        ),
        OnboardingPage(
            iconName: "location.fill",
            title: "Haritada yakın yerleri bul",
            description: "Yakınındaki mekanları haritada gör, favorilerine ekle ve yol tarifine kolayca ulaş.",
            tagTitle: "Yaşa"
        )
    ]

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            VStack(spacing: AppSpacing.lg) {
                HStack {
                    VStack(alignment: .leading, spacing: AppSpacing.xxs) {
                        Text("GezioGo")
                            .font(AppTypography.subtitle)
                            .foregroundStyle(AppColors.petrol)

                        Text("Şehir seninle keşfedilir")
                            .font(AppTypography.caption)
                            .foregroundStyle(AppColors.textSecondary)
                    }

                    Spacer()

                    Button("Geç") {
                        onFinish()
                    }
                    .font(AppTypography.bodyMedium)
                    .foregroundStyle(AppColors.teal)
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.top, AppSpacing.md)

                TabView(selection: $selectedPage) {
                    ForEach(Array(pages.enumerated()), id: \.element.id) { index, page in
                        OnboardingPageView(page: page)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                pageIndicator

                AppButton(
                    title: selectedPage == pages.count - 1 ? "Keşfetmeye Başla" : "Devam Et"
                ) {
                    if selectedPage < pages.count - 1 {
                        withAnimation {
                            selectedPage += 1
                        }
                    } else {
                        onFinish()
                    }
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.bottom, AppSpacing.lg)
            }
        }
    }

    private var pageIndicator: some View {
        HStack(spacing: AppSpacing.xs) {
            ForEach(0..<pages.count, id: \.self) { index in
                Capsule()
                    .fill(index == selectedPage ? AppColors.petrol : AppColors.border)
                    .frame(width: index == selectedPage ? 28 : 8, height: 8)
                    .animation(.easeInOut(duration: 0.25), value: selectedPage)
            }
        }
    }
}

#Preview {
    OnboardingView {}
}

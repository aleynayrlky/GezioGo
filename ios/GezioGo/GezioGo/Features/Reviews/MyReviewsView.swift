import SwiftUI

struct MyReviewsView: View {
    let userDisplayName: String?

    @StateObject private var viewModel = MyReviewsViewModel()
    @State private var editingReview: Review?
    @State private var reviewToDelete: Review?

    var body: some View {
        ZStack {
            AppColors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    headerSection

                    contentSection
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.top, AppSpacing.md)
                .padding(.bottom, 120)
            }
        }
        .navigationTitle("Yorumlarım")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadReviews()
        }
        .onReceive(NotificationCenter.default.publisher(for: .reviewsDidChange)) { _ in
            Task {
                await viewModel.loadReviews()
            }
        }
        .sheet(item: $editingReview) { review in
            ReviewSheetView(
                targetTitle: review.targetTitle,
                initialRating: review.rating,
                initialComment: review.comment,
                submitButtonTitle: "Yorumu Güncelle",
                onSubmit: { rating, comment in
                    Task {
                        await viewModel.updateReview(
                            review,
                            rating: rating,
                            comment: comment,
                            displayName: userDisplayName
                        )

                        await MainActor.run {
                            editingReview = nil
                        }
                    }
                },
                onCancel: {
                    editingReview = nil
                }
            )
            .id(review.id)
        }
        .alert(
            "Yorum silinsin mi?",
            isPresented: Binding(
                get: { reviewToDelete != nil },
                set: { newValue in
                    if !newValue {
                        reviewToDelete = nil
                    }
                }
            )
        ) {
            Button("Vazgeç", role: .cancel) {
                reviewToDelete = nil
            }

            Button("Sil", role: .destructive) {
                if let reviewToDelete {
                    Task {
                        await viewModel.deleteReview(reviewToDelete)

                        await MainActor.run {
                            self.reviewToDelete = nil
                        }
                    }
                }
            }
        } message: {
            Text("Bu yorum kalıcı olarak silinecek.")
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: AppSpacing.sm) {
            AppTag("Profil", iconName: "star.bubble")

            Text("Yorumlarım")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(AppColors.textPrimary)

            Text("GezioGo’da paylaştığın yorumları buradan görüntüleyebilir, düzenleyebilir veya silebilirsin.")
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(AppColors.textSecondary)
                .lineSpacing(3)
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            LoadingView("Yorumların yükleniyor...")
        } else if let errorMessage = viewModel.errorMessage {
            ErrorStateView(message: errorMessage) {
                Task {
                    await viewModel.loadReviews()
                }
            }
        } else if viewModel.reviews.isEmpty {
            emptyState
        } else {
            VStack(spacing: AppSpacing.sm) {
                ForEach(viewModel.reviews) { review in
                    reviewCard(review)
                }
            }
        }
    }

    private var emptyState: some View {
        AppCard {
            VStack(spacing: AppSpacing.sm) {
                ZStack {
                    Circle()
                        .fill(AppColors.cream)
                        .frame(width: 64, height: 64)

                    Image(systemName: "star.bubble")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(AppColors.petrol)
                }

                Text("Henüz yorumun yok")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundStyle(AppColors.textPrimary)

                Text("Mekanları deneyimledikçe yorum yapabilir ve burada hepsini topluca görebilirsin.")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppSpacing.md)
        }
    }

    private func reviewCard(_ review: Review) -> some View {
        AppCard {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(review.targetTitle)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.textPrimary)
                            .lineLimit(2)

                        Text(review.targetType.displayName)
                            .font(.system(size: 10.5, weight: .semibold))
                            .foregroundStyle(AppColors.teal)
                    }

                    Spacer()

                    starRow(rating: review.rating)
                }

                Text(review.comment)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(AppColors.textSecondary)
                    .lineSpacing(3)

                HStack {
                    Text(review.isEdited ? "\(review.dateText) · düzenlendi" : review.dateText)
                        .font(.system(size: 10.5, weight: .medium))
                        .foregroundStyle(AppColors.textSecondary.opacity(0.8))

                    Spacer()

                    Button {
                        editingReview = review
                    } label: {
                        Text("Düzenle")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(AppColors.teal)
                    }
                    .buttonStyle(.plain)

                    Button {
                        reviewToDelete = review
                    } label: {
                        Text("Sil")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(AppColors.gold)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .contextMenu {
            Button {
                editingReview = review
            } label: {
                Label("Düzenle", systemImage: "pencil")
            }

            Button(role: .destructive) {
                reviewToDelete = review
            } label: {
                Label("Sil", systemImage: "trash")
            }
        }
    }

    private func starRow(rating: Int) -> some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .font(.system(size: 10.5, weight: .semibold))
                    .foregroundStyle(AppColors.gold)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyReviewsView(userDisplayName: "Aleyna Yerlikaya")
    }
}

import SwiftUI

struct ReviewSheetView: View {
    let targetTitle: String
    let initialRating: Int
    let initialComment: String
    let submitButtonTitle: String
    let onSubmit: (Int, String) -> Void
    let onCancel: () -> Void

    @State private var rating: Int
    @State private var comment: String

    init(
        targetTitle: String,
        initialRating: Int = 5,
        initialComment: String = "",
        submitButtonTitle: String = "Yorumu Kaydet",
        onSubmit: @escaping (Int, String) -> Void,
        onCancel: @escaping () -> Void
    ) {
        self.targetTitle = targetTitle
        self.initialRating = initialRating
        self.initialComment = initialComment
        self.submitButtonTitle = submitButtonTitle
        self.onSubmit = onSubmit
        self.onCancel = onCancel

        _rating = State(initialValue: initialRating)
        _comment = State(initialValue: initialComment)
    }

    private var isCommentValid: Bool {
        !comment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Deneyimini paylaş")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.textPrimary)

                        Text(targetTitle)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(AppColors.textSecondary)
                    }

                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Puanın")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.textPrimary)

                        HStack(spacing: AppSpacing.sm) {
                            ForEach(1...5, id: \.self) { star in
                                Button {
                                    rating = star
                                } label: {
                                    Image(systemName: star <= rating ? "star.fill" : "star")
                                        .font(.system(size: 28, weight: .semibold))
                                        .foregroundStyle(AppColors.gold)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Yorumun")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(AppColors.textPrimary)

                        TextEditor(text: $comment)
                            .font(.system(size: 14))
                            .frame(height: 140)
                            .padding(10)
                            .background(AppColors.cardBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(AppColors.border.opacity(0.7), lineWidth: 1)
                            )
                    }

                    AppButton(title: submitButtonTitle) {
                        onSubmit(rating, comment)
                    }
                    .disabled(!isCommentValid)
                    .opacity(isCommentValid ? 1 : 0.55)

                    Spacer()
                }
                .padding(AppSpacing.lg)
            }
            .navigationTitle("Yorum Yap")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Kapat") {
                        onCancel()
                    }
                    .foregroundStyle(AppColors.petrol)
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

#Preview {
    ReviewSheetView(
        targetTitle: "Atakum Sahili",
        onSubmit: { _, _ in },
        onCancel: {}
    )
}

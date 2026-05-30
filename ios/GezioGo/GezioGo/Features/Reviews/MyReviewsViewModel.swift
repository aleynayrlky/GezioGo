import Foundation
import Combine

@MainActor
final class MyReviewsViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let firebaseReviewsService: FirebaseReviewsService
    private let authService: FirebaseAuthService

    init(
        firebaseReviewsService: FirebaseReviewsService = .shared,
        authService: FirebaseAuthService = .shared
    ) {
        self.firebaseReviewsService = firebaseReviewsService
        self.authService = authService
    }

    func loadReviews() async {
        guard let userId = authService.userId else {
            reviews = []
            errorMessage = "Yorumlarını görmek için giriş yapmalısın."
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            reviews = try await firebaseReviewsService.fetchReviews(userId: userId)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func updateReview(
        _ review: Review,
        rating: Int,
        comment: String,
        displayName: String?
    ) async {
        guard let userId = authService.userId else {
            errorMessage = "Yorumunu düzenlemek için giriş yapmalısın."
            return
        }

        do {
            try await firebaseReviewsService.addReview(
                targetId: review.targetId,
                targetTitle: review.targetTitle,
                targetType: review.targetType,
                userId: userId,
                displayName: displayName ?? authService.userDisplayName ?? "Gezgin",
                rating: rating,
                comment: comment
            )

            await loadReviews()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func deleteReview(_ review: Review) async {
        guard let userId = authService.userId else {
            errorMessage = "Yorumunu silmek için giriş yapmalısın."
            return
        }

        guard review.userId == userId else {
            errorMessage = "Sadece kendi yorumunu silebilirsin."
            return
        }

        do {
            try await firebaseReviewsService.deleteReview(reviewId: review.id)
            reviews.removeAll { $0.id == review.id }
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

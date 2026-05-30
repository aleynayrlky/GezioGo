import Foundation
import Combine

@MainActor
final class PlaceDetailViewModel: ObservableObject {
    @Published var place: Place
    @Published var isFavorite: Bool = false
    @Published var reviews: [Review] = []
    @Published var errorMessage: String?
    @Published var isLoadingReviews = false

    private let firebaseFavoritesService: FirebaseFavoritesService
    private let firebaseReviewsService: FirebaseReviewsService
    private let authService: FirebaseAuthService

    init(
        place: Place,
        firebaseFavoritesService: FirebaseFavoritesService = .shared,
        firebaseReviewsService: FirebaseReviewsService = .shared,
        authService: FirebaseAuthService = .shared
    ) {
        self.place = place
        self.firebaseFavoritesService = firebaseFavoritesService
        self.firebaseReviewsService = firebaseReviewsService
        self.authService = authService
    }

    var currentUserId: String? {
        authService.userId
    }

    var currentUserReview: Review? {
        guard let currentUserId else {
            return nil
        }

        return reviews.first { $0.userId == currentUserId }
    }

    func loadInitialData() async {
        await loadReviews()
        await loadFavoriteState()
    }

    func loadFavoriteState() async {
        guard let userId = authService.userId else {
            isFavorite = false
            return
        }

        do {
            isFavorite = try await firebaseFavoritesService.isFavoritePlace(
                userId: userId,
                placeId: place.id
            )
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func toggleFavorite() async {
        guard let userId = authService.userId else {
            isFavorite = false
            errorMessage = "Favorilere eklemek için giriş yapmalısın."
            return
        }

        do {
            isFavorite = try await firebaseFavoritesService.toggleFavoritePlace(
                userId: userId,
                place: place
            )
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func loadReviews() async {
        isLoadingReviews = true
        errorMessage = nil

        do {
            reviews = try await firebaseReviewsService.fetchReviews(
                targetId: place.id,
                targetType: .place
            )
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoadingReviews = false
    }

    func addReview(
        rating: Int,
        comment: String,
        displayName: String?
    ) async {
        let trimmedComment = comment.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedComment.isEmpty else {
            return
        }

        guard let userId = authService.userId else {
            errorMessage = "Yorum yapmak için giriş yapmalısın."
            return
        }

        do {
            try await firebaseReviewsService.addReview(
                targetId: place.id,
                targetTitle: place.name,
                targetType: .place,
                userId: userId,
                displayName: displayName ?? authService.userDisplayName ?? "Gezgin",
                rating: rating,
                comment: trimmedComment
            )

            await loadReviews()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func deleteReview(_ review: Review) async {
        guard let userId = authService.userId else {
            errorMessage = "Yorum silmek için giriş yapmalısın."
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

    var favoriteButtonIcon: String {
        isFavorite ? "heart.fill" : "heart"
    }

    var favoriteButtonTitle: String {
        isFavorite ? "Favorilerden çıkar" : "Favoriye ekle"
    }

    var averageRating: Double {
        guard !reviews.isEmpty else {
            return 0
        }

        let total = reviews.reduce(0) { $0 + $1.rating }
        return Double(total) / Double(reviews.count)
    }

    var ratingText: String {
        guard !reviews.isEmpty else {
            return "-"
        }

        return String(format: "%.1f", averageRating)
    }

    var reviewCountText: String {
        "\(reviews.count)"
    }

    var durationText: String {
        guard let minutes = place.averageVisitDurationMinutes else {
            return "Süre bilgisi yok"
        }

        if minutes < 60 {
            return "\(minutes) dk"
        } else if minutes == 60 {
            return "1 saat"
        } else {
            let hour = minutes / 60
            let remaining = minutes % 60

            if remaining == 0 {
                return "\(hour) saat"
            } else {
                return "\(hour)s \(remaining)dk"
            }
        }
    }

    var accessibilityText: String {
        place.isAccessible ? "Erişilebilir" : "Erişilebilirlik bilgisi yok"
    }

    var childFriendlyText: String {
        place.isChildFriendly ? "Çocukla uygun" : "Çocuk uygunluğu belirtilmemiş"
    }

    var studentFriendlyText: String {
        place.isStudentFriendly ? "Öğrenci dostu" : "Öğrenci bilgisi yok"
    }

    var areaTypeText: String {
        if place.isIndoor && place.isOutdoor {
            return "Kapalı ve açık alan"
        } else if place.isIndoor {
            return "Kapalı alan"
        } else if place.isOutdoor {
            return "Açık alan"
        } else {
            return "Alan bilgisi yok"
        }
    }
}

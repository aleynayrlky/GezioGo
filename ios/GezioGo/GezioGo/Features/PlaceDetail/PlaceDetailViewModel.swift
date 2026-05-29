import Foundation
import Combine

struct PlaceReviewItem: Identifiable, Hashable {
    let id: String
    let userName: String
    let rating: Int
    let comment: String
    let dateText: String
}

@MainActor
final class PlaceDetailViewModel: ObservableObject {
    @Published var place: Place
    @Published var isFavorite: Bool = false
    @Published var reviews: [PlaceReviewItem] = []
    @Published var errorMessage: String?

    private let firebaseFavoritesService: FirebaseFavoritesService
    private let authService: FirebaseAuthService

    init(
        place: Place,
        firebaseFavoritesService: FirebaseFavoritesService = .shared,
        authService: FirebaseAuthService = .shared
    ) {
        self.place = place
        self.firebaseFavoritesService = firebaseFavoritesService
        self.authService = authService
        self.reviews = Self.mockReviews(for: place)
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

    func addReview(
        rating: Int,
        comment: String
    ) {
        let trimmedComment = comment.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedComment.isEmpty else {
            return
        }

        let review = PlaceReviewItem(
            id: UUID().uuidString,
            userName: "Sen",
            rating: rating,
            comment: trimmedComment,
            dateText: "Az önce"
        )

        reviews.insert(review, at: 0)
    }

    var favoriteButtonIcon: String {
        isFavorite ? "heart.fill" : "heart"
    }

    var favoriteButtonTitle: String {
        isFavorite ? "Favorilerden çıkar" : "Favoriye ekle"
    }

    var averageRating: Double {
        guard !reviews.isEmpty else {
            return 4.8
        }

        let total = reviews.reduce(0) { $0 + $1.rating }
        return Double(total) / Double(reviews.count)
    }

    var ratingText: String {
        String(format: "%.1f", averageRating)
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

    private static func mockReviews(for place: Place) -> [PlaceReviewItem] {
        [
            PlaceReviewItem(
                id: "review_1_\(place.id)",
                userName: "Ayşe",
                rating: 5,
                comment: "Çok keyifli bir deneyimdi. Özellikle konumu ve atmosferi çok güzeldi.",
                dateText: "2 gün önce"
            ),
            PlaceReviewItem(
                id: "review_2_\(place.id)",
                userName: "Mehmet",
                rating: 4,
                comment: "Kısa bir gezi için güzel bir durak. Gitmeden önce saat bilgisini kontrol etmek iyi olur.",
                dateText: "1 hafta önce"
            )
        ]
    }
}

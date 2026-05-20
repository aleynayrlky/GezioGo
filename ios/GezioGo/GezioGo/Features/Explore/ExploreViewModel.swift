import Foundation
import Combine

struct ExploreDiscoveryCategory: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let iconName: String
    let category: PlaceCategory?
}

struct ExploreRecommendationItem: Identifiable, Hashable {
    let id: String
    let title: String
    let cityName: String
    let categoryTitle: String
    let iconName: String
    let ratingText: String
}

@MainActor
final class ExploreViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedCategoryId: String? = nil

    private let cityId: String

    init(cityId: String) {
        self.cityId = cityId
    }

    var discoveryCategories: [ExploreDiscoveryCategory] {
        [
            ExploreDiscoveryCategory(
                id: "museum",
                title: "Müzeler",
                subtitle: "Türkiye’den kültür durakları",
                iconName: "building.columns.fill",
                category: .museum
            ),
            ExploreDiscoveryCategory(
                id: "historical",
                title: "Tarihi Yerler",
                subtitle: "Geçmişin izlerini keşfet",
                iconName: "castle.fill",
                category: .historical
            ),
            ExploreDiscoveryCategory(
                id: "nature",
                title: "Doğa & Parklar",
                subtitle: "Yeşil rotalar ve açık alanlar",
                iconName: "leaf.fill",
                category: .nature
            ),
            ExploreDiscoveryCategory(
                id: "food",
                title: "Yeme & İçme",
                subtitle: "Lezzet durakları",
                iconName: "fork.knife",
                category: .foodDrink
            ),
            ExploreDiscoveryCategory(
                id: "scenic",
                title: "Manzaralı Noktalar",
                subtitle: "Fotoğraflık keşif alanları",
                iconName: "camera.fill",
                category: nil
            ),
            ExploreDiscoveryCategory(
                id: "popular",
                title: "Popüler Noktalar",
                subtitle: "En çok ilgi gören yerler",
                iconName: "star.fill",
                category: nil
            )
        ]
    }

    var recommendations: [ExploreRecommendationItem] {
        [
            ExploreRecommendationItem(
                id: "istanbul-galata",
                title: "Galata Kulesi",
                cityName: "İstanbul",
                categoryTitle: "Tarihi",
                iconName: "castle.fill",
                ratingText: "4.8"
            ),
            ExploreRecommendationItem(
                id: "bolu-yedigoller",
                title: "Yedigöller",
                cityName: "Bolu",
                categoryTitle: "Doğa",
                iconName: "leaf.fill",
                ratingText: "4.9"
            ),
            ExploreRecommendationItem(
                id: "gaziantep-baklava",
                title: "Gastronomi Rotası",
                cityName: "Gaziantep",
                categoryTitle: "Yeme & İçme",
                iconName: "fork.knife",
                ratingText: "4.9"
            ),
            ExploreRecommendationItem(
                id: "mardin-sokaklari",
                title: "Mardin Sokakları",
                cityName: "Mardin",
                categoryTitle: "Tarihi",
                iconName: "building.2.fill",
                ratingText: "4.8"
            )
        ]
    }

    var filteredDiscoveryCategories: [ExploreDiscoveryCategory] {
        var result = discoveryCategories

        if let selectedCategoryId {
            result = result.filter { $0.id == selectedCategoryId }
        }

        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).localizedLowercase

        guard !query.isEmpty else {
            return result
        }

        return result.filter { item in
            let searchableText = [
                item.title,
                item.subtitle,
                item.category?.displayName ?? ""
            ]
            .joined(separator: " ")
            .localizedLowercase

            return searchableText.contains(query)
        }
    }

    var filteredRecommendations: [ExploreRecommendationItem] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).localizedLowercase

        guard !query.isEmpty else {
            return recommendations
        }

        return recommendations.filter { item in
            let searchableText = [
                item.title,
                item.cityName,
                item.categoryTitle
            ]
            .joined(separator: " ")
            .localizedLowercase

            return searchableText.contains(query)
        }
    }

    var hasActiveSearch: Bool {
        !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var hasActiveFilter: Bool {
        selectedCategoryId != nil
    }

    var hasActiveFilters: Bool {
        hasActiveSearch || hasActiveFilter
    }

    func selectCategory(_ categoryId: String?) {
        selectedCategoryId = categoryId
    }

    func clearFilters() {
        selectedCategoryId = nil
        searchText = ""
    }
}

import Foundation
import Combine
import MapKit

@MainActor
final class MapExploreViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?
    @Published var selectedCategory: PlaceCategory?
    @Published var isLoading = false
    @Published var errorMessage: String?

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 41.2867,
            longitude: 36.33
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.18,
            longitudeDelta: 0.18
        )
    )

    private let cityId: String
    private let dataService: DataServiceProtocol

    init(
        cityId: String,
        dataService: DataServiceProtocol? = nil
    ) {
        self.cityId = cityId
        self.dataService = dataService ?? MockDataService()
    }

    var categories: [PlaceCategory] {
        Array(Set(places.map { $0.category }))
            .sorted { $0.displayName < $1.displayName }
    }

    var visiblePlaces: [Place] {
        if let selectedCategory {
            return places.filter { $0.category == selectedCategory }
        }

        return places
    }

    var selectedCategoryTitle: String {
        selectedCategory?.displayName ?? "Tüm mekanlar"
    }

    func loadPlaces() async {
        isLoading = true
        errorMessage = nil

        do {
            places = try await dataService.fetchPlaces(cityId: cityId)

            selectedPlace = visiblePlaces.first

            if let firstPlace = selectedPlace {
                moveRegion(to: firstPlace)
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func selectCategory(_ category: PlaceCategory?) {
        selectedCategory = category
        selectedPlace = visiblePlaces.first

        if let selectedPlace {
            moveRegion(to: selectedPlace)
        }
    }

    func selectPlace(_ place: Place) {
        selectedPlace = place
        moveRegion(to: place)
    }

    private func moveRegion(to place: Place) {
        region.center = CLLocationCoordinate2D(
            latitude: place.latitude,
            longitude: place.longitude
        )
    }
}

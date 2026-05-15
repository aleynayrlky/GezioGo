import Foundation
import Combine
import MapKit

@MainActor
final class MapExploreViewModel: ObservableObject {
    @Published var places: [Place] = []
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

    var visiblePlaces: [Place] {
        places
    }

    func loadPlaces() async {
        isLoading = true
        errorMessage = nil

        do {
            places = try await dataService.fetchPlaces(cityId: cityId)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

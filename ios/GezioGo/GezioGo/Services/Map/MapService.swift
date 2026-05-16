import Foundation
import MapKit

final class MapService {
    func openDirections(to place: Place) {
        openDirections(
            name: place.name,
            latitude: place.latitude,
            longitude: place.longitude,
            directionsMode: MKLaunchOptionsDirectionsModeDriving
        )
    }

    func canOpenDirections(for stop: RouteStop) -> Bool {
        stop.latitude != nil && stop.longitude != nil
    }

    func openDirections(to stop: RouteStop) {
        guard let latitude = stop.latitude,
              let longitude = stop.longitude else {
            return
        }

        openDirections(
            name: stop.title,
            latitude: latitude,
            longitude: longitude,
            directionsMode: MKLaunchOptionsDirectionsModeWalking
        )
    }

    func openDirections(
        name: String,
        latitude: Double,
        longitude: Double,
        directionsMode: String = MKLaunchOptionsDirectionsModeDriving
    ) {
        let coordinate = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )

        let placemark = MKPlacemark(coordinate: coordinate)

        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name

        mapItem.openInMaps(
            launchOptions: [
                MKLaunchOptionsDirectionsModeKey: directionsMode
            ]
        )
    }
}

import Foundation
import MapKit

final class MapService {
    func openDirections(to place: Place) {
        openDirections(
            name: place.name,
            latitude: place.latitude,
            longitude: place.longitude
        )
    }

    func openDirections(
        name: String,
        latitude: Double,
        longitude: Double
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
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
            ]
        )
    }
}

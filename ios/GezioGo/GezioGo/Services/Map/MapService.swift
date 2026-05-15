import Foundation
import MapKit

final class MapService {
    func openDirections(to place: Place) {
        let coordinate = CLLocationCoordinate2D(
            latitude: place.latitude,
            longitude: place.longitude
        )

        let placemark = MKPlacemark(coordinate: coordinate)

        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = place.name

        mapItem.openInMaps(
            launchOptions: [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
            ]
        )
    }
}//
//  MapService.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


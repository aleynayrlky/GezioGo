import Foundation

enum AppRoute: Hashable {
    case explore(cityId: String)
    case placeList(cityId: String, category: PlaceCategory?)
    case placeDetail(place: Place)
    case events(cityId: String)
    case eventDetail(event: Event)
    case routes(cityId: String)
    case routeDetail(route: TripRoute)
}

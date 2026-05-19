import Foundation

enum MainTab: Hashable {
    case home
    case explore
    case planner
    case favorites
    case profile

    var title: String {
        switch self {
        case .home:
            return "Ana Sayfa"
        case .explore:
            return "Keşfet"
        case .planner:
            return "Planla"
        case .favorites:
            return "Favoriler"
        case .profile:
            return "Profil"
        }
    }

    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .explore:
            return "sparkles"
        case .planner:
            return "wand.and.stars"
        case .favorites:
            return "heart"
        case .profile:
            return "person"
        }
    }

    var selectedIconName: String {
        switch self {
        case .home:
            return "house.fill"
        case .explore:
            return "sparkles"
        case .planner:
            return "wand.and.stars.inverse"
        case .favorites:
            return "heart.fill"
        case .profile:
            return "person.fill"
        }
    }
}

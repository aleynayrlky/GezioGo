import Foundation

extension Notification.Name {
    static let savedRoutesDidChange = Notification.Name("savedRoutesDidChange")
}

final class SavedRoutesService {
    static let shared = SavedRoutesService()

    private let userDefaults: UserDefaults
    private let savedRouteIdsKey = "savedRouteIds"

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    var savedRouteIds: [String] {
        userDefaults.stringArray(forKey: savedRouteIdsKey) ?? []
    }

    func isSaved(routeId: String) -> Bool {
        savedRouteIds.contains(routeId)
    }

    func save(routeId: String) {
        var ids = savedRouteIds

        guard !ids.contains(routeId) else {
            return
        }

        ids.append(routeId)
        save(ids)
    }

    func remove(routeId: String) {
        var ids = savedRouteIds
        ids.removeAll { $0 == routeId }
        save(ids)
    }

    func toggle(routeId: String) {
        if isSaved(routeId: routeId) {
            remove(routeId: routeId)
        } else {
            save(routeId: routeId)
        }
    }

    func clearAll() {
        save([])
    }

    private func save(_ ids: [String]) {
        userDefaults.set(ids, forKey: savedRouteIdsKey)

        NotificationCenter.default.post(
            name: .savedRoutesDidChange,
            object: nil
        )
    }
}

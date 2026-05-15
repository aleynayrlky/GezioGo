import Foundation
import Combine

@MainActor
final class EventDetailViewModel: ObservableObject {
    @Published var event: Event

    init(event: Event) {
        self.event = event
    }

    var dateText: String {
        event.startDate.gezioFormattedDate
    }

    var startTimeText: String {
        event.startDate.gezioFormattedTime
    }

    var endTimeText: String {
        guard let endDate = event.endDate else {
            return ""
        }

        return endDate.gezioFormattedTime
    }

    var timeRangeText: String {
        if !startTimeText.isEmpty && !endTimeText.isEmpty {
            return "\(startTimeText) - \(endTimeText)"
        } else if !startTimeText.isEmpty {
            return startTimeText
        } else {
            return "Saat bilgisi yok"
        }
    }

    var locationText: String {
        if let address = event.address, !address.isEmpty {
            return address
        }

        return event.venueName
    }

    var areaTypeText: String {
        if event.isIndoor && event.isOutdoor {
            return "Kapalı ve açık alan"
        } else if event.isIndoor {
            return "Kapalı alan"
        } else if event.isOutdoor {
            return "Açık hava"
        } else {
            return "Alan bilgisi yok"
        }
    }

    var childFriendlyText: String {
        event.isChildFriendly ? "Çocukla uygun" : "Çocuk uygunluğu belirtilmemiş"
    }

    var organizerText: String {
        event.organizer ?? "Organizatör bilgisi yok"
    }

    var hasCoordinate: Bool {
        event.latitude != nil && event.longitude != nil
    }

    var latitude: Double? {
        event.latitude
    }

    var longitude: Double? {
        event.longitude
    }
}

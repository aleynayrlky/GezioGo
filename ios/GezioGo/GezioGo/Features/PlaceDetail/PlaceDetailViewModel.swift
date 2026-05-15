import Foundation
import Combine

@MainActor
final class PlaceDetailViewModel: ObservableObject {
    @Published var place: Place

    init(place: Place) {
        self.place = place
    }

    var durationText: String {
        guard let minutes = place.averageVisitDurationMinutes else {
            return "Süre bilgisi yok"
        }

        if minutes < 60 {
            return "\(minutes) dk"
        } else if minutes == 60 {
            return "1 saat"
        } else {
            let hour = minutes / 60
            let remaining = minutes % 60

            if remaining == 0 {
                return "\(hour) saat"
            } else {
                return "\(hour)s \(remaining)dk"
            }
        }
    }

    var accessibilityText: String {
        place.isAccessible ? "Erişilebilir" : "Erişilebilirlik bilgisi yok"
    }

    var childFriendlyText: String {
        place.isChildFriendly ? "Çocukla uygun" : "Çocuk uygunluğu belirtilmemiş"
    }

    var studentFriendlyText: String {
        place.isStudentFriendly ? "Öğrenci dostu" : "Öğrenci bilgisi yok"
    }

    var areaTypeText: String {
        if place.isIndoor && place.isOutdoor {
            return "Kapalı ve açık alan"
        } else if place.isIndoor {
            return "Kapalı alan"
        } else if place.isOutdoor {
            return "Açık alan"
        } else {
            return "Alan bilgisi yok"
        }
    }
}//
//  PlaceDetailViewModel.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 15.05.2026.
//


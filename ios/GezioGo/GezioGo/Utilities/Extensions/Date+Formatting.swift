import Foundation

extension String {
    var gezioFormattedDate: String {
        guard let date = Self.gezioISOFormatter.date(from: self) else {
            return self
        }

        return Self.gezioDateFormatter.string(from: date)
    }

    var gezioFormattedTime: String {
        guard let date = Self.gezioISOFormatter.date(from: self) else {
            return ""
        }

        return Self.gezioTimeFormatter.string(from: date)
    }

    private static let gezioISOFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime,
            .withColonSeparatorInTimeZone
        ]
        return formatter
    }()

    private static let gezioDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter
    }()

    private static let gezioTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}//
//  Date+Formatting.swift
//  GezioGo
//
//  Created by Aleyna Yerlikaya on 16.05.2026.
//


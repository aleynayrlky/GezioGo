import Foundation

struct AIPlannerRequest: Identifiable, Hashable {
    let id: String
    let cityId: String
    let cityName: String
    let startDate: Date
    let endDate: Date
    let dayCount: Int
    let budget: String
    let interests: [String]
    let tempo: String
    let transport: String
    let personCount: Int

    init(
        id: String = UUID().uuidString,
        cityId: String,
        cityName: String,
        startDate: Date,
        endDate: Date,
        dayCount: Int,
        budget: String,
        interests: [String],
        tempo: String,
        transport: String,
        personCount: Int
    ) {
        self.id = id
        self.cityId = cityId
        self.cityName = cityName
        self.startDate = startDate
        self.endDate = endDate
        self.dayCount = dayCount
        self.budget = budget
        self.interests = interests
        self.tempo = tempo
        self.transport = transport
        self.personCount = personCount
    }

    var summaryText: String {
        let interestsText = interests.joined(separator: ", ")

        return """
        Şehir: \(cityName)
        Tarih: \(formattedDateRange)
        Gün: \(dayCount)
        Bütçe: \(budget)
        İlgi alanları: \(interestsText)
        Tempo: \(tempo)
        Ulaşım: \(transport)
        Kişi sayısı: \(personCount)
        """
    }

    var formattedDateRange: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "d MMM yyyy"

        return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
    }
}

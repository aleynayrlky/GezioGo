import Foundation
import Combine

@MainActor
final class AIPlannerViewModel: ObservableObject {
    @Published var selectedCity: String?
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var selectedBudget: String?
    @Published var selectedInterests: Set<String> = []
    @Published var selectedTempo: String?
    @Published var selectedTransport: String?
    @Published var selectedPersonCount: Int = 1

    @Published var isDatePickerPresented = false
    @Published var showValidationAlert = false
    @Published var showReadyAlert = false
    @Published var alertMessage = ""
    @Published var generatedRequest: AIPlannerRequest?

    let cityId: String

    let cities: [String] = [
        "Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin",
        "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa",
        "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan",
        "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta",
        "Mersin", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir",
        "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla",
        "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt",
        "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak",
        "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman",
        "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"
    ]

    let budgetOptions: [String] = [
        "₺0 - ₺1.500",
        "₺1.500 - ₺3.000",
        "₺3.000 - ₺5.000",
        "₺5.000 - ₺7.500",
        "₺7.500 - ₺10.000",
        "₺10.000 - ₺15.000",
        "₺15.000 - ₺20.000",
        "₺20.000 - ₺30.000",
        "₺30.000+"
    ]

    let interests = [
        "Tarih",
        "Yemek",
        "Doğa",
        "Sanat",
        "Alışveriş"
    ]

    let tempos = [
        "Rahat",
        "Orta",
        "Yoğun"
    ]

    let transports = [
        "Yürüyüş",
        "Toplu Taşıma",
        "Araç"
    ]

    init(cityId: String) {
        self.cityId = cityId

        if cityId.lowercased() == "samsun" {
            self.selectedCity = "Samsun"
        }
    }

    var selectedDateRangeText: String {
        guard let startDate, let endDate else {
            return "Tarih seç"
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "d MMM"

        return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
    }

    var tripDayCount: Int? {
        guard let startDate, let endDate else {
            return nil
        }

        let start = Calendar.current.startOfDay(for: startDate)
        let end = Calendar.current.startOfDay(for: endDate)

        let difference = Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0

        return max(difference + 1, 1)
    }

    var isFormReady: Bool {
        selectedCity != nil &&
        startDate != nil &&
        endDate != nil &&
        selectedBudget != nil &&
        !selectedInterests.isEmpty &&
        selectedTempo != nil &&
        selectedTransport != nil
    }

    func toggleInterest(_ interest: String) {
        if selectedInterests.contains(interest) {
            selectedInterests.remove(interest)
        } else {
            selectedInterests.insert(interest)
        }
    }

    func selectDatesIfNeeded() {
        if startDate == nil {
            startDate = Date()
        }

        if endDate == nil {
            endDate = startDate ?? Date()
        }
    }

    func createRouteTapped() {
        guard let request = buildRequest() else {
            showValidationAlert = true
            return
        }

        generatedRequest = request
        alertMessage = """
        AI’ye gönderilecek rota isteği hazırlandı.

        \(request.summaryText)

        Bir sonraki adımda bunu Firebase Functions + OpenAI bağlantısına göndereceğiz.
        """
        showReadyAlert = true
    }

    private func buildRequest() -> AIPlannerRequest? {
        guard let selectedCity else {
            alertMessage = "Lütfen şehir seç."
            return nil
        }

        guard let startDate, let endDate else {
            alertMessage = "Lütfen başlangıç ve bitiş tarihlerini seç."
            return nil
        }

        guard let selectedBudget else {
            alertMessage = "Lütfen bütçe seç."
            return nil
        }

        guard !selectedInterests.isEmpty else {
            alertMessage = "Lütfen en az bir ilgi alanı seç."
            return nil
        }

        guard let selectedTempo else {
            alertMessage = "Lütfen seyahat temposu seç."
            return nil
        }

        guard let selectedTransport else {
            alertMessage = "Lütfen ulaşım tercihi seç."
            return nil
        }

        return AIPlannerRequest(
            cityId: normalizedCityId(for: selectedCity),
            cityName: selectedCity,
            startDate: startDate,
            endDate: endDate,
            dayCount: tripDayCount ?? 1,
            budget: selectedBudget,
            interests: Array(selectedInterests).sorted(),
            tempo: selectedTempo,
            transport: selectedTransport,
            personCount: selectedPersonCount
        )
    }

    private func normalizedCityId(for cityName: String) -> String {
        switch cityName.localizedLowercase {
        case "samsun":
            return "samsun"
        case "istanbul":
            return "istanbul"
        case "izmir":
            return "izmir"
        case "ankara":
            return "ankara"
        default:
            return cityName
                .localizedLowercase
                .replacingOccurrences(of: " ", with: "-")
        }
    }
}

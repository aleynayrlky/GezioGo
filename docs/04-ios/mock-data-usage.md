# GezioGo – Mock Data Kullanım Planı

> Hafta 4 / Gün 3 çıktısı  
> Dosya amacı: SwiftUI ekranları geliştirilirken Firebase veya gerçek backend olmadan local JSON/mock veri kullanımını planlamak.

---

## 1. Amaç

GezioGo’da ilk geliştirme aşamasında doğrudan Firebase’e bağlanmak yerine local mock data ile ilerlemek daha doğru olur.

Bunun nedeni:

- Ekranları hızlı geliştirmek
- Tasarımları gerçek veriye yakın şekilde test etmek
- Backend hazır olmadan uygulama akışını kurmak
- Model hatalarını erken görmek
- SwiftUI preview ekranlarını veriyle doldurmak

Ana ilke:

> Önce local JSON ile çalışan ekranlar, sonra Firebase/backend bağlantısı.

---

## 2. Mock Data Klasör Yapısı

Xcode içinde önerilen yapı:

```text
Resources/
└── JSON/
    ├── MockCities.json
    ├── MockPlaces.json
    ├── MockEvents.json
    └── MockRoutes.json

MockData/
├── MockCityData.swift
├── MockPlaceData.swift
├── MockEventData.swift
└── MockRouteData.swift
```

Proje doküman klasöründe ise şu yapı kullanılabilir:

```text
data/
└── mock/
    ├── MockCities.json
    ├── MockPlaces.json
    ├── MockEvents.json
    └── MockRoutes.json
```

---

## 3. Mock JSON Dosyaları

### 3.1 MockCities.json

Şehir seçimi ve ana sayfa için kullanılır.

İlk aşamada sadece Samsun yeterlidir.

### 3.2 MockPlaces.json

Mekan listesi, mekan detay, harita ve favoriler için kullanılır.

İlk aşamada 5–10 örnek mekan yeterlidir.

### 3.3 MockEvents.json

Etkinlik listesi ve etkinlik detay ekranı için kullanılır.

İlk aşamada 3–5 örnek etkinlik yeterlidir.

### 3.4 MockRoutes.json

AI rota sonucu ekranı için kullanılır.

Gerçek AI entegrasyonu gelmeden rota sonucu tasarımını test etmek için kullanılır.

---

## 4. JSONLoader Yardımcı Dosyası

Swift tarafında JSON okumak için `JSONLoader.swift` kullanılabilir.

```swift
final class JSONLoader {
    static func load<T: Decodable>(_ filename: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("JSON bulunamadı: \(filename)")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("JSON okunamadı: \(error)")
            return nil
        }
    }
}
```

---

## 5. MockDataService Planı

```swift
protocol DataServiceProtocol {
    func fetchCities() async throws -> [City]
    func fetchPlaces(cityId: String) async throws -> [Place]
    func fetchEvents cityId: String) async throws -> [Event]
    func fetchRoutes(userId: String) async throws -> [TripRoute]
}
```

Not: Yukarıdaki örnekte gerçek Swift yazarken `fetchEvents(cityId: String)` şeklinde syntax düzeltilmelidir.

Doğru taslak:

```swift
protocol DataServiceProtocol {
    func fetchCities() async throws -> [City]
    func fetchPlaces(cityId: String) async throws -> [Place]
    func fetchEvents(cityId: String) async throws -> [Event]
    func fetchRoutes(userId: String) async throws -> [TripRoute]
}
```

Mock servis:

```swift
final class MockDataService: DataServiceProtocol {
    func fetchCities() async throws -> [City] {
        JSONLoader.load("MockCities", as: [City].self) ?? []
    }

    func fetchPlaces(cityId: String) async throws -> [Place] {
        let places = JSONLoader.load("MockPlaces", as: [Place].self) ?? []
        return places.filter { $0.cityId == cityId && $0.contentStatus == "published" }
    }

    func fetchEvents(cityId: String) async throws -> [Event] {
        let events = JSONLoader.load("MockEvents", as: [Event].self) ?? []
        return events.filter { $0.cityId == cityId && $0.contentStatus == "published" }
    }

    func fetchRoutes(userId: String) async throws -> [TripRoute] {
        JSONLoader.load("MockRoutes", as: [TripRoute].self) ?? []
    }
}
```

---

## 6. ViewModel İçinde Kullanım

Örnek `HomeViewModel`:

```swift
@MainActor
final class HomeViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let dataService: DataServiceProtocol

    init(dataService: DataServiceProtocol = MockDataService()) {
        self.dataService = dataService
    }

    func loadHomeData(cityId: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            places = try await dataService.fetchPlaces(cityId: cityId)
            events = try await dataService.fetchEvents(cityId: cityId)
        } catch {
            errorMessage = "Veriler yüklenemedi."
        }
    }
}
```

---

## 7. Loading / Empty / Error Durumları

Mock data kullanırken bu durumlar da test edilmelidir:

- Veri yükleniyor
- Veri boş geldi
- JSON dosyası bulunamadı
- JSON decode hatası
- Liste başarılı yüklendi

Örnek UI durumları:

```text
isLoading = true → LoadingView
places.isEmpty → EmptyStateView
errorMessage != nil → ErrorStateView
```

---

## 8. Mock Data Kullanım Sırası

Önerilen sıra:

1. `MockCities.json` oluştur
2. `City.swift` modelini yaz
3. `JSONLoader.swift` yaz
4. `MockDataService.swift` yaz
5. `HomeViewModel` içinde mock veriyi oku
6. Home ekranında göster
7. Mekan listesi ve detay ekranına aynı veriyi bağla
8. Harita ekranında aynı `Place` verilerini pin olarak göster

---

## 9. Firebase’e Geçiş Planı

Başlangıçta:

```text
HomeViewModel → MockDataService → Local JSON
```

Sonra:

```text
HomeViewModel → FirebaseDataService → Firestore
```

Bu yüzden ekranlar doğrudan JSON veya Firebase bilmemeli. Sadece `DataServiceProtocol` üzerinden veri istemeli.

---

## 10. Sonuç

Mock data kullanımı GezioGo’nun ilk SwiftUI ekranlarını hızlı ve güvenli şekilde geliştirmeyi sağlar.

Ana ilke:

> Ekranları önce mock data ile çalıştır, sonra veri kaynağını Firebase ile değiştir.

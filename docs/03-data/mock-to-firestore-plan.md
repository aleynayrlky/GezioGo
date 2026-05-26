# Mock Veriden Firestore’a Geçiş Planı

GezioGo’daki mevcut JSON/mock veri yapısından Firebase Cloud Firestore’a güvenli geçiş planı.

## Amaç

Mevcut uygulama şu anda JSON/mock dosyalarıyla çalışıyor. Firebase’e geçerken uygulamayı bozmadan, ekranları tek tek gerçek veriye bağlamak istiyoruz.

Hedef yapı:

```text
DataServiceProtocol
├── MockDataService
└── FirebaseDataService
```

Böylece:

```text
Geliştirme sırasında mock veri kullanılabilir.
Gerçek kullanımda FirebaseDataService kullanılabilir.
Ekranlar veri kaynağından bağımsız kalır.
```

## Mevcut mock dosyalar

Mevcut veya beklenen JSON dosyaları:

```text
MockCities.json
MockPlaces.json
MockEvents.json
MockRoutes.json
```

Sonradan eklenecekler:

```text
MockAccommodations.json
MockTransportGuides.json
```

## Firestore hedef koleksiyonları

JSON dosyalarının taşınacağı koleksiyonlar:

```text
MockCities.json → cities
MockPlaces.json → places
MockEvents.json → events
MockRoutes.json → routes
MockAccommodations.json → accommodations
MockTransportGuides.json → transportGuides
```

Kullanıcıya bağlı veriler mock’tan değil uygulama içinden oluşacak:

```text
users
favorites
savedRoutes
reviews
aiRouteRequests
aiGeneratedRoutes
```

## Geçiş stratejisi

### 1. Mock sistemi korunacak

İlk aşamada hiçbir mock dosya silinmeyecek.

Neden:

```text
Firebase bağlantısı sırasında ekranlar bozulmasın.
Offline geliştirme devam etsin.
Veri hatasında hızlıca mock servise dönülebilsin.
```

### 2. FirebaseDataService eklenecek

Yeni servis dosyası:

```text
Services / Data / FirebaseDataService.swift
```

Bu servis `DataServiceProtocol` uygulayacak.

Örnek fonksiyonlar:

```swift
func fetchCities() async throws -> [City]
func fetchPlaces(cityId: String) async throws -> [Place]
func fetchEvents(cityId: String) async throws -> [Event]
func fetchRoutes(userId: String) async throws -> [TripRoute]
```

Not: `fetchRoutes(userId:)` mevcut protokole göre kullanıcı bazlı duruyorsa, hazır rotalar ve kayıtlı rotalar ayrıştırılmalı.

Önerilen ayrım:

```swift
func fetchRoutes(cityId: String) async throws -> [TripRoute]
func fetchSavedRoutes(userId: String) async throws -> [TripRoute]
```

Bu değişiklik daha sonra yapılabilir.

### 3. Veri dönüştürme kuralları

Mock JSON alanları Firestore alanlarıyla aynı tutulmaya çalışılacak.

Önemli dönüşümler:

```text
String tarih → Firestore Timestamp
String category → Swift enum decode
String priceType → Swift enum decode
imageUrls → [String]
latitude/longitude → Double
```

Şu an JSON’da tarih string olarak tutuluyor:

```json
"createdAt": "2026-05-15T00:00:00+03:00"
```

Firestore’a geçince tercih edilen:

```text
createdAt: Timestamp
updatedAt: Timestamp
```

Ama ilk geçişte string tarih desteklenmeye devam edebilir. Sonra model güncellenir.

## Import yöntemleri

### Yöntem 1 — Elle Firebase Console’dan veri girişi

Avantaj:

```text
Hızlı başlamak için kolay.
Kod gerekmez.
Az veri için yeterli.
```

Dezavantaj:

```text
Veri arttıkça çok yorucu olur.
Tekrar yükleme zordur.
Hata riski yüksektir.
```

### Yöntem 2 — Import script’i

Önerilen yöntem budur.

Script şunları yapar:

```text
JSON dosyasını okur.
Her kaydı ilgili koleksiyona yazar.
Doküman ID olarak JSON içindeki id alanını kullanır.
Tarih alanlarını Timestamp’e çevirir.
Mevcut doküman varsa merge veya overwrite yapar.
```

Script seçenekleri:

```text
Node.js + Firebase Admin SDK
Python + Firebase Admin SDK
```

Öneri:

```text
Node.js + Firebase Admin SDK
```

Çünkü Firebase dokümantasyon ve örnekleri Node tarafında daha yaygın.

## Önerilen import klasör yapısı

```text
tools
└── firestore-import
    ├── package.json
    ├── serviceAccountKey.json
    ├── import-data.js
    └── data
        ├── MockCities.json
        ├── MockPlaces.json
        ├── MockEvents.json
        └── MockRoutes.json
```

Güvenlik notu:

```text
serviceAccountKey.json GitHub’a asla atılmamalı.
.gitignore içine eklenmeli.
```

## Import akışı

### 1. Firebase Admin SDK kurulumu

```bash
npm init -y
npm install firebase-admin
```

### 2. Service account key alma

Firebase Console:

```text
Project Settings
Service accounts
Generate new private key
```

İndirilen dosya:

```text
serviceAccountKey.json
```

### 3. Script çalıştırma

```bash
node import-data.js
```

Script çıktı örneği:

```text
cities: 1 doküman yüklendi
places: 7 doküman yüklendi
events: 2 doküman yüklendi
routes: 3 doküman yüklendi
Import tamamlandı
```

## Import script mantığı

Pseudo kod:

```js
loadJson("MockCities.json") → writeCollection("cities")
loadJson("MockPlaces.json") → writeCollection("places")
loadJson("MockEvents.json") → writeCollection("events")
loadJson("MockRoutes.json") → writeCollection("routes")
```

Her kayıt için:

```js
db.collection(collectionName).doc(item.id).set(item, { merge: true })
```

Tarih dönüşümü gerekirse:

```js
createdAt: Timestamp.fromDate(new Date(item.createdAt))
updatedAt: Timestamp.fromDate(new Date(item.updatedAt))
```

## Veri doğrulama kontrol listesi

Import öncesi kontrol:

```text
Her kayıtta id var mı?
cityId doğru mu?
category enum ile uyumlu mu?
priceType enum ile uyumlu mu?
latitude/longitude sayı mı?
contentStatus published mı?
imageUrls array mi?
tags array mi?
createdAt/updatedAt geçerli mi?
```

Import sonrası kontrol:

```text
Firestore’da koleksiyonlar oluştu mu?
Doküman ID’leri doğru mu?
Samsun şehir dokümanı var mı?
places içinde cityId=samsun kayıtları var mı?
events içinde startDate doğru sıralanıyor mu?
Uygulama FirebaseDataService ile veriyi çekebiliyor mu?
```

## Ekran geçiş sırası

Firebase’e bağlanacak ekranların sırası:

```text
1. CitySelectionView
2. HomeView
3. ExploreView
4. PlaceListView
5. PlaceDetailView
6. EventsView
7. EventDetailView
8. RoutesView
9. RouteDetailView
10. FavoritesView
11. ProfileView
```

Önce sadece okuma yapılacak:

```text
cities
places
events
routes
```

Sonra kullanıcı yazma işlemleri bağlanacak:

```text
favorites
savedRoutes
reviews
users
```

## FirebaseDataService için ilk hedefler

İlk versiyon:

```swift
final class FirebaseDataService: DataServiceProtocol {
    func fetchCities() async throws -> [City]
    func fetchPlaces(cityId: String) async throws -> [Place]
    func fetchEvents(cityId: String) async throws -> [Event]
    func fetchRoutes(userId: String) async throws -> [TripRoute]
}
```

Daha doğru ikinci versiyon:

```swift
protocol DataServiceProtocol {
    func fetchCities() async throws -> [City]
    func fetchPlaces(cityId: String) async throws -> [Place]
    func fetchEvents(cityId: String) async throws -> [Event]
    func fetchRoutes(cityId: String) async throws -> [TripRoute]
}
```

Kayıtlı rotalar ayrı servis olmalı:

```swift
protocol SavedRoutesServiceProtocol {
    func fetchSavedRoutes(userId: String) async throws -> [TripRoute]
    func saveRoute(userId: String, routeId: String) async throws
    func removeSavedRoute(userId: String, routeId: String) async throws
}
```

## Mock ve Firebase arasında geçiş

Başlangıçta basit bir ayar kullanılabilir:

```swift
enum AppEnvironment {
    static let useFirebase = false
}
```

Servis seçimi:

```swift
let dataService: DataServiceProtocol = AppEnvironment.useFirebase
    ? FirebaseDataService()
    : MockDataService()
```

Daha sonra production/debug ayrımı yapılabilir:

```text
Debug → Mock veya Firebase test projesi
Release → Firebase production projesi
```

## Dikkat edilecekler

### 1. Tarih formatı

Firestore’da tarihleri Timestamp tutmak daha doğru.

Ama Swift modeller şu an string tarih bekliyorsa ya:

```text
Model güncellenecek
```

ya da:

```text
FirebaseDataService Timestamp’i stringe çevirecek
```

İlk geçişte ikinci yöntem daha az riskli olabilir.

### 2. Enum uyumu

JSON/Firebase string değerleri Swift enum raw value ile birebir uyumlu olmalı.

Örnek:

```text
food_drink
museum
historical
nature
```

### 3. Veri eksikleri

Eksik alanlar decode hatası verebilir.

Çözüm:

```text
Modelde optional yapılması gereken alanlar optional olmalı.
Firestore decode öncesi veri standardize edilmeli.
```

### 4. Güvenlik

Import script’inde kullanılan service account key GitHub’a atılmamalı.

`.gitignore` içine:

```text
serviceAccountKey.json
*.serviceAccount.json
```

### 5. Maliyet

Firestore okuma maliyetleri için ekranlar gereksiz tekrar veri çekmemeli.

Öneriler:

```text
Ana sayfa için cityHomeSummaries düşünülebilir.
Liste ekranlarında sayfalama kullanılabilir.
Yorumlar lazy load yapılabilir.
```

## İlk geçiş için minimal görev listesi

```text
1. Firebase projesi oluştur
2. iOS app ekle
3. GoogleService-Info.plist indir
4. Firebase SDK ekle
5. FirebaseApp.configure() ekle
6. Firestore’da cities / places / events koleksiyonlarını oluştur
7. Mock JSON verilerini import et
8. FirebaseDataService oluştur
9. CitySelectionView Firebase’den şehir çeksin
10. HomeView Firebase’den places/events çeksin
11. ExploreView Firebase’den places çeksin
12. PlaceDetailView Firebase verisiyle çalışsın
```

## Sonraki görev listesi

```text
1. FirebaseAuthService
2. UserProfileService
3. FirebaseFavoritesService
4. FirebaseReviewsService
5. FirebaseSavedRoutesService
6. Storage görsel yükleme sistemi
7. Admin panel
8. Cloud Functions + OpenAI
```

## Karar

Mock veriler silinmeden Firestore’a geçilecek. Önce okuma, sonra kullanıcı yazma işlemleri bağlanacak. Bu yöntem uygulamayı bozmadan Firebase’e geçmeyi sağlar.

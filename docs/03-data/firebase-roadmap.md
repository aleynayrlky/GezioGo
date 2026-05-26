# Firebase Yol Haritası

GezioGo için Firebase entegrasyonu, veri modeli, kullanıcı işlemleri ve AI planlama altyapısının adım adım kurulumu.

## Ana karar

GezioGo ilk aşamada Firebase ile başlayacak. Ürün büyüdükçe ihtiyaçlara göre bazı parçalar ayrı servislerle desteklenebilir.

Başlangıç mimarisi:

```text
Firebase Auth
Cloud Firestore
Firebase Storage
Cloud Functions
Firebase Cloud Messaging
```

İleride gerekirse:

```text
Arama ağırlaşırsa: Algolia / Meilisearch
İlişkisel veri büyürse: Supabase / PostgreSQL
Canlı ulaşım verisi gerekirse: ayrı backend / resmi API entegrasyonları
AI işlemleri büyürse: özel backend + kuyruk sistemi
```

## 1. Aşama — Firebase projesini hazırlama

Firebase Console üzerinden GezioGo için yeni proje açılacak.

Aktifleştirilecek servisler:

```text
Authentication
Cloud Firestore
Firebase Storage
Cloud Functions
Firebase Cloud Messaging
```

İlk etapta aktif kullanılacaklar:

```text
Authentication
Cloud Firestore
```

Daha sonra kullanılacaklar:

```text
Storage → mekan, etkinlik, konaklama görselleri
Functions → OpenAI / AI rota oluşturma
Messaging → bildirimler
```

## 2. Aşama — iOS projesine Firebase ekleme

Xcode projesine Firebase SDK eklenecek.

İlk gerekli paketler:

```swift
FirebaseCore
FirebaseAuth
FirebaseFirestore
FirebaseStorage
```

Firebase Console’dan indirilen dosya:

```text
GoogleService-Info.plist
```

Bu dosya Xcode projesine eklenecek.

`GezioGoApp.swift` içinde Firebase başlatılacak:

```swift
import FirebaseCore

@main
struct GezioGoApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
```

Not: Repo public olacaksa `GoogleService-Info.plist` güvenlik açısından ayrıca değerlendirilecek.

## 3. Aşama — MockDataService korunacak

Mevcut JSON/mock sistemi hemen silinmeyecek.

Hedef yapı:

```text
DataServiceProtocol
MockDataService
FirebaseDataService
```

Ekranlar doğrudan Firebase’e bağlı olmayacak. Hepsi `DataServiceProtocol` üzerinden beslenecek.

Bu sayede:

```text
Test için MockDataService kullanılabilir.
Gerçek veri için FirebaseDataService kullanılabilir.
Ekranları tek tek bozmadan Firebase’e geçilebilir.
```

## 4. Aşama — Authentication

İlk etap:

```text
E-posta ile giriş
E-posta ile kayıt
Çıkış yap
Misafir olarak devam et
```

Sonraki etap:

```text
Apple ile giriş
Google ile giriş
Şifre sıfırlama
```

Misafir kullanıcı şunları yapabilir:

```text
Ana sayfayı görebilir
Keşfet ekranını görebilir
Mekan detaylarını görebilir
Etkinlik detaylarını görebilir
Planla ekranındaki seçimleri görebilir
```

Misafir kullanıcı şunları yapamaz:

```text
Favoriye ekleme
Rota kaydetme
Yorum yapma
Puan verme
Profil bilgisi kaydetme
```

Giriş yapan kullanıcı şunları yapabilir:

```text
Favori ekleme / çıkarma
Rota kaydetme
Yorum yapma
Puan verme
Profil bilgisi güncelleme
```

## 5. Aşama — Firestore veri modelini kurma

İlk MVP için zorunlu koleksiyonlar:

```text
cities
places
events
users
favorites
savedRoutes
reviews
```

Sonraki koleksiyonlar:

```text
accommodations
transportGuides
routes
aiRouteRequests
aiGeneratedRoutes
partners
adminSubmissions
```

Detaylı alanlar `firestore-schema.md` dosyasında tutulacak.

## 6. Aşama — JSON verilerini Firestore’a taşıma

Mevcut veriler:

```text
MockCities.json
MockPlaces.json
MockEvents.json
MockRoutes.json
```

İlk veri geçişi için iki yöntem var:

```text
1. Firebase Console’dan elle veri girişi
2. JSON import script’i ile otomatik taşıma
```

Önerilen yöntem:

```text
JSON import script’i yazmak.
```

Böylece veriler gerektiğinde tekrar yüklenebilir.

Detay plan `mock-to-firestore-plan.md` dosyasında tutulacak.

## 7. Aşama — Ekranları Firebase’e bağlama sırası

Hepsini aynı anda bağlamayacağız. Güvenli geçiş sırası:

```text
1. Auth sistemi
2. Şehir seçimi
3. Ana sayfa verileri
4. Keşfet / mekan listesi
5. Mekan detay
6. Favoriler
7. Etkinlikler
8. Rotalar
9. Yorum ve puanlama
10. Profil
11. Konaklama
12. Ulaşım rehberi
13. AI planlama
```

İlk kritik set:

```text
Auth
Cities
Places
Favorites
Reviews
```

## 8. Aşama — Favoriler

Mevcut local favori sistemi Firebase’e taşınacak.

Davranış:

```text
Misafir kullanıcı favoriye basarsa giriş uyarısı alır.
Giriş yapan kullanıcı favori ekleyebilir.
Favoriler Firestore’da kullanıcıya özel tutulur.
```

Önerilen koleksiyon:

```text
favorites
```

Doküman ID önerisi:

```text
{userId}_{placeId}
```

## 9. Aşama — Yorum ve puanlama

Yorumlar ayrı koleksiyonda tutulacak.

Önemli karar:

```text
Yorumları place/event/accommodation dokümanının içine gömmüyoruz.
```

Sebep:

```text
Yorum sayısı büyüyebilir.
Mekan dokümanı şişmemeli.
Moderasyon daha kolay olmalı.
```

Mekan üzerinde sadece özet alanlar tutulacak:

```text
averageRating
reviewCount
```

Yorum yazma davranışı:

```text
Misafir kullanıcı yorum yapamaz.
Giriş yapan kullanıcı yorum yapabilir.
Yorum status alanıyla pending/approved/rejected olabilir.
```

## 10. Aşama — Admin panel

İlk aşamada uygulama Firebase’e bağlanacak. Admin panel daha sonra yapılacak.

Admin panelde olacaklar:

```text
Şehir ekle / düzenle
Mekan ekle / düzenle
Etkinlik ekle / düzenle
Konaklama ekle / düzenle
Ulaşım bilgisi ekle / düzenle
Yorumları onayla / gizle
Partner içeriklerini yönet
```

Önerilen teknoloji:

```text
React + Firebase Auth + Firestore
```

## 11. Aşama — AI rota oluşturma

AI planlama Firebase bağlantısından sonra yapılacak.

Mimari:

```text
iOS Planla ekranı
↓
Cloud Function
↓
Firestore’dan aday şehir/mekan/etkinlik/restoran verileri alınır
↓
OpenAI API’ye düzenli veri gönderilir
↓
JSON rota alınır
↓
aiGeneratedRoutes koleksiyonuna kaydedilir
↓
iOS rota detay ekranında gösterilir
```

Önemli kural:

```text
AI olmayan mekan uydurmayacak.
Sadece veritabanındaki adaylar içinden rota oluşturacak.
```

AI’ya gönderilecek veri örneği:

```text
Şehir: Samsun
Tarih aralığı: 2 gün
İlgi alanları: tarih, doğa, yemek
Bütçe: orta
Tempo: rahat
Ulaşım: toplu taşıma
Kişi sayısı: 2
Aday mekanlar: 20 mekan
Aday etkinlikler: 5 etkinlik
Aday restoranlar: 5 restoran
```

## 12. Aşama — Ulaşım verileri

İlk sürümde canlı ulaşım verisi hedeflenmeyecek.

İlk sürüm:

```text
Şehir içi ulaşım rehberi
Tramvay bilgisi
Otobüs bağlantıları
Havalimanı ulaşımı
Taksi / transfer notları
Resmi ulaşım sitesi linkleri
```

Sonraki sürüm:

```text
Hat listeleri
Durak bilgileri
Canlı saatler
Resmi API varsa entegrasyon
```

## Haftalık başlangıç planı

### Gün 1

```text
Firebase projesi aç
iOS app ekle
GoogleService-Info.plist ekle
Firebase SDK kur
FirebaseApp.configure() ekle
```

### Gün 2

```text
FirebaseAuthService oluştur
LoginView Firebase’e bağla
RegisterView Firebase’e bağla
Logout bağla
AppState auth durumunu Firebase’den okusun
```

### Gün 3

```text
FirebaseDataService oluştur
City / Place / Event fetch fonksiyonlarını yaz
MockDataService bozulmadan dursun
```

### Gün 4

```text
cities Firestore’dan gelsin
places Firestore’dan gelsin
Ana sayfa Firebase’den beslensin
Keşfet Firebase’den beslensin
```

### Gün 5

```text
FavoritesService Firebase’e taşınsın
Misafir kullanıcı uyarı alsın
Giriş yapan kullanıcı favori ekleyebilsin
Favoriler sayfası Firebase’den okusun
```

### Gün 6

```text
reviews koleksiyonu oluştur
Mekan detay yorum eklesin
Puan ortalaması güncellensin
Giriş yapmayan kullanıcı yorum yapamasın
```

### Gün 7

```text
events Firebase’den gelsin
routes Firebase’den gelsin
savedRoutes Firebase’e yazılsın
```

## Son karar

GezioGo Firebase ile başlayacak. Mimari temiz kurulacak. Ürün büyürse bazı parçalar daha güçlü servislere taşınabilecek.

# GezioGo – Service Layer Planı

> Hafta 4 / Gün 6 çıktısı  
> Dosya amacı: GezioGo iOS uygulamasında veri, konum, harita, favori, AI rota, kullanıcı ve bildirim işlemlerini yönetecek servis katmanını planlamak.

---

## 1. Amaç

SwiftUI ekranları doğrudan JSON, Firebase, konum veya AI API ile konuşmamalıdır.

Bunun yerine servis katmanı kullanılmalıdır.

Ana ilke:

> View sadece arayüzü gösterir, ViewModel servislerden veri ister, servisler teknik işlemleri yapar.

---

## 2. Önerilen Servis Klasör Yapısı

```text
Services/
├── Data/
│   ├── DataServiceProtocol.swift
│   ├── MockDataService.swift
│   └── FirebaseDataService.swift
├── Location/
│   └── LocationService.swift
├── Favorites/
│   └── FavoritesService.swift
├── Map/
│   └── MapService.swift
├── TripPlanner/
│   └── TripPlannerService.swift
├── Auth/
│   └── AuthService.swift
└── Notifications/
    └── NotificationService.swift
```

---

## 3. DataServiceProtocol

### Görevi

Uygulamanın veri okuma işlemleri için ortak arayüz sağlar.

```swift
protocol DataServiceProtocol {
    func fetchCities() async throws -> [City]
    func fetchPlaces(cityId: String) async throws -> [Place]
    func fetchEvents(cityId: String) async throws -> [Event]
    func fetchRoutes(userId: String) async throws -> [TripRoute]
}
```

### Neden gerekli?

Çünkü başlangıçta mock data kullanılacak, sonra Firebase’e geçilecek.

Ekranlar veri kaynağını bilmemelidir.

```text
HomeViewModel → DataServiceProtocol
```

Bu sayede veri kaynağı değişse bile ekran kodu bozulmaz.

---

## 4. MockDataService

### Görevi

Local JSON dosyalarından veri okur.

Kullanılacağı dönem:

```text
0.5 Statik Demo
1.0 MVP başlangıcı
```

### Okuyacağı dosyalar

```text
MockCities.json
MockPlaces.json
MockEvents.json
MockRoutes.json
```

---

## 5. FirebaseDataService

### Görevi

Firestore’dan gerçek verileri okur.

Kullanılacağı dönem:

```text
1.0 sonu / 1.1 sonrası
```

### Sorumlulukları

- Şehir verilerini çekmek
- Mekanları şehir bazlı çekmek
- Etkinlikleri şehir bazlı çekmek
- Yayında olmayan içerikleri filtrelemek
- Görseller için Storage URL kullanmak

---

## 6. LocationService

### Görevi

Kullanıcının konum izni ve mevcut konumunu yönetir.

### Sorumlulukları

- Konum izni istemek
- Konum izni durumunu okumak
- Kullanıcının mevcut konumunu almak
- Konum izni yoksa uygun durum mesajı döndürmek

### Kullanıldığı ekranlar

- Ana Sayfa
- Harita
- Yakınımdaki yerler
- AI rota

---

## 7. FavoritesService

### Görevi

Kullanıcının favori mekan, etkinlik ve rota verilerini yönetir.

### MVP yaklaşımı

İlk sürümde local storage kullanılabilir:

```text
UserDefaults / AppStorage
```

### Sonraki yaklaşım

Kullanıcı hesabı eklendiğinde Firestore’a taşınabilir.

### Sorumlulukları

- Mekanı favoriye eklemek
- Mekanı favoriden çıkarmak
- Favori mekanları getirmek
- Etkinlik favorisi tutmak
- Rota favorisi tutmak

---

## 8. MapService

### Görevi

Harita ve yol tarifi işlemlerini düzenler.

### Sorumlulukları

- Place verisini harita pinine dönüştürmek
- Event verisini harita pinine dönüştürmek
- Apple Maps ile yol tarifi açmak
- Koordinat doğrulamak

### Kullanıldığı ekranlar

- Mekan Detay
- Etkinlik Detay
- Haritada Keşfet
- AI Rota Haritası

---

## 9. TripPlannerService

### Görevi

AI rota oluşturma sürecini yönetir.

### İlk aşama

Mock rota döndürür:

```text
MockRoutes.json
```

### Sonraki aşama

Backend üzerinden AI API çağrısı yapar.

### Sorumlulukları

- Kullanıcı tercihlerini almak
- Rota isteği oluşturmak
- AI sonucunu parse etmek
- TripRoute modeline dönüştürmek
- Hata durumunu yönetmek

---

## 10. AuthService

### Görevi

Kullanıcı girişi ve hesap yönetimini sağlar.

### Kullanılacağı sürüm

```text
1.2 Kullanıcı Hesabı
```

### Sorumlulukları

- E-posta ile giriş
- Apple ile giriş
- Çıkış
- Aktif kullanıcıyı okuma
- Kullanıcı profilini getirme

---

## 11. NotificationService

### Görevi

Bildirim izinleri ve kullanıcı bildirim tercihlerini yönetir.

### Kullanılacağı sürüm

```text
1.2+ / 1.5+
```

### Sorumlulukları

- Bildirim izni istemek
- Etkinlik hatırlatmaları
- Rota hatırlatmaları
- Şehir öneri bildirimleri

---

## 12. MVP İçin Zorunlu Servisler

MVP başlangıcında şu servisler yeterlidir:

```text
DataServiceProtocol
MockDataService
LocationService
FavoritesService
MapService
```

AI için sonra:

```text
TripPlannerService
```

Kullanıcı hesabı için sonra:

```text
AuthService
NotificationService
```

---

## 13. ViewModel ve Servis İlişkisi

Örnek:

```text
HomeView
   ↓
HomeViewModel
   ↓
DataServiceProtocol
   ↓
MockDataService / FirebaseDataService
```

Ekran doğrudan `MockDataService` bilmemelidir.

---

## 14. Sonuç

Service layer, GezioGo’nun büyüdükçe karışmasını engeller.

Ana ilke:

> Ekranlar veri kaynağını bilmesin; servis protokolleri üzerinden çalışsın.

# GezioGo – Swift Model Dosyaları Planı

> Hafta 4 / Gün 2 çıktısı  
> Dosya amacı: 3. haftada hazırlanan veri modellerinin SwiftUI projesindeki karşılıklarını planlamak.

---

## 1. Amaç

3. haftada GezioGo için veri modelleri belirlendi:

- City
- Place
- Event
- User
- Route
- Partner
- ContentStatus

Bu hafta bu modellerin Swift tarafında nasıl dosyalara dönüşeceği planlanır.

Ana ilke:

> JSON veri modeli ile Swift modeli mümkün olduğunca uyumlu olmalıdır.

---

## 2. Model Dosyaları

SwiftUI projesinde `Models/` klasörü altında şu dosyalar yer almalıdır:

```text
Models/
├── City.swift
├── Place.swift
├── Event.swift
├── AppUser.swift
├── TripRoute.swift
├── RouteStop.swift
├── Partner.swift
├── PartnerPermissions.swift
├── ContentStatus.swift
├── Category.swift
├── PriceType.swift
└── UserRole.swift
```

---

## 3. City.swift

```swift
struct City: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let slug: String
    let country: String
    let region: String
    let shortDescription: String
    let longDescription: String?
    let coverImageUrl: String?
    let thumbnailUrl: String?
    let latitude: Double
    let longitude: Double
    let popularCategoryIds: [String]
    let weatherRegionCode: String?
    let isActive: Bool
    let createdAt: String
    let updatedAt: String
}
```

### Kullanıldığı ekranlar

- Şehir Seçimi
- Ana Sayfa
- Harita
- AI Rota Formu

---

## 4. Place.swift

```swift
struct Place: Identifiable, Codable, Hashable {
    let id: String
    let cityId: String
    let name: String
    let slug: String
    let category: String
    let subCategory: String?
    let shortDescription: String
    let longDescription: String?
    let district: String
    let address: String
    let latitude: Double
    let longitude: Double
    let openingHours: String?
    let priceType: String
    let priceInfo: String?
    let ticketUrl: String?
    let sourceUrl: String?
    let imageUrls: [String]
    let tags: [String]
    let isIndoor: Bool
    let isOutdoor: Bool
    let isChildFriendly: Bool
    let isStudentFriendly: Bool
    let isAccessible: Bool
    let averageVisitDurationMinutes: Int?
    let partnerId: String?
    let contentStatus: String
    let createdBy: String?
    let approvedBy: String?
    let lastVerifiedAt: String?
    let createdAt: String
    let updatedAt: String
}
```

### Kullanıldığı ekranlar

- Ana Sayfa
- Keşfet
- Mekan Listesi
- Mekan Detay
- Harita
- Favoriler
- AI Rota Sonucu

---

## 5. Event.swift

```swift
struct Event: Identifiable, Codable, Hashable {
    let id: String
    let cityId: String
    let title: String
    let slug: String
    let category: String
    let description: String
    let venueName: String
    let placeId: String?
    let district: String?
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let startDate: String
    let endDate: String?
    let priceType: String
    let priceInfo: String?
    let ticketUrl: String?
    let organizer: String?
    let partnerId: String?
    let sourceUrl: String?
    let imageUrl: String?
    let imageUrls: [String]
    let tags: [String]
    let isChildFriendly: Bool
    let isIndoor: Bool
    let isOutdoor: Bool
    let contentStatus: String
    let createdBy: String?
    let approvedBy: String?
    let lastVerifiedAt: String?
    let createdAt: String
    let updatedAt: String
}
```

### Kullanıldığı ekranlar

- Etkinlik Listesi
- Etkinlik Detay
- Ana Sayfa
- Favoriler
- AI Rota

---

## 6. AppUser.swift

```swift
struct AppUser: Identifiable, Codable, Hashable {
    let id: String
    let userType: String
    let role: String
    let name: String?
    let email: String
    let phone: String?
    let selectedCityId: String?
    let partnerId: String?
    let authorizedCityIds: [String]
    let interests: [String]
    let budgetPreference: String?
    let transportPreference: String?
    let accessibilityNeeds: [String]
    let favoritePlaceIds: [String]
    let favoriteEventIds: [String]
    let savedRouteIds: [String]
    let language: String?
    let notificationSettings: NotificationSettings?
    let isActive: Bool
    let createdAt: String
    let updatedAt: String
}

struct NotificationSettings: Codable, Hashable {
    let events: Bool?
    let routes: Bool?
    let marketing: Bool?
    let contentApprovals: Bool?
    let partnerRequests: Bool?
}
```

### Kullanıldığı ekranlar

- Profil
- Favoriler
- Kaydedilen Rotalar
- Ayarlar
- Panel tarafı ileride

---

## 7. TripRoute.swift ve RouteStop.swift

```swift
struct TripRoute: Identifiable, Codable, Hashable {
    let id: String
    let userId: String?
    let cityId: String
    let title: String
    let date: String?
    let durationType: String
    let budget: String?
    let interests: [String]
    let transportType: String?
    let companions: String?
    let tempo: String?
    let stops: [RouteStop]
    let totalDurationMinutes: Int?
    let totalDistanceKm: Double?
    let estimatedCostLevel: String?
    let aiPromptVersion: String?
    let isSaved: Bool
    let createdAt: String
    let updatedAt: String
}

struct RouteStop: Identifiable, Codable, Hashable {
    var id: String { "\(order)-\(title)" }
    let order: Int
    let type: String
    let placeId: String?
    let eventId: String?
    let title: String
    let timeLabel: String?
    let durationMinutes: Int?
    let note: String?
    let latitude: Double?
    let longitude: Double?
}
```

### Kullanıldığı ekranlar

- AI Rota Formu
- AI Rota Sonucu
- Rota Detay
- Kaydedilen Rotalar

---

## 8. Partner.swift

```swift
struct Partner: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let slug: String
    let type: String
    let cityId: String?
    let authorizedCityIds: [String]
    let authorizedUserIds: [String]
    let contactEmail: String?
    let contactPhone: String?
    let address: String?
    let websiteUrl: String?
    let logoUrl: String?
    let status: String
    let permissions: PartnerPermissions
    let createdAt: String
    let updatedAt: String
}

struct PartnerPermissions: Codable, Hashable {
    let canCreatePlace: Bool
    let canEditPlace: Bool
    let canCreateEvent: Bool
    let canEditEvent: Bool
    let canPublishDirectly: Bool
    let canViewReports: Bool
    let canManageUsers: Bool
    let requiresApproval: Bool
}
```

### Kullanıldığı yerler

- Panel tarafı
- İçerik sahipliği
- Kurum/işletme yetkileri

Mobil MVP’de doğrudan kullanılmayabilir.

---

## 9. Enum Dosyaları

Başlangıçta kategorileri `String` olarak tutmak daha kolaydır. Ancak proje büyüyünce enum yapısına geçilebilir.

### ContentStatus.swift

```swift
enum ContentStatus: String, Codable {
    case draft
    case pendingReview = "pending_review"
    case approved
    case published
    case rejected
    case needsRevision = "needs_revision"
    case archived
}
```

### PriceType.swift

```swift
enum PriceType: String, Codable {
    case free
    case paid
    case unknown
}
```

### UserRole.swift

```swift
enum UserRole: String, Codable {
    case mobileUser = "mobile_user"
    case superAdmin = "super_admin"
    case gezioEditor = "gezio_editor"
    case municipalityAdmin = "municipality_admin"
    case provinceCultureAdmin = "province_culture_admin"
    case ministryViewer = "ministry_viewer"
    case businessOwner = "business_owner"
    case eventOrganizer = "event_organizer"
    case contentApprover = "content_approver"
}
```

---

## 10. Başlangıç İçin Öneri

İlk SwiftUI MVP’de minimum şu modellerle başlanabilir:

```text
City.swift
Place.swift
Event.swift
TripRoute.swift
RouteStop.swift
ContentStatus.swift
```

`AppUser`, `Partner` ve panel odaklı modeller daha sonra detaylandırılabilir.

---

## 11. Sonuç

Swift model dosyaları JSON şablonlarıyla uyumlu olursa mock data, Firebase ve AI servisleri arasında geçiş kolay olur.

Ana ilke:

> Önce Codable modelleri temiz kur, sonra ekranları bu modellerle besle.

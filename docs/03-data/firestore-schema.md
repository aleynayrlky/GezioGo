# Firestore Veri Modeli

GezioGo uygulamasında Firebase Cloud Firestore üzerinde kullanılacak koleksiyonlar, alanlar ve temel veri ilişkileri.

## Genel prensipler

- Her ana dokümanda `id`, `createdAt`, `updatedAt` alanları standart olacak.
- Kullanıcı üretimi içeriklerde `userId` tutulacak.
- Şehir bazlı içeriklerde `cityId` zorunlu olacak.
- Yayınlanabilir içeriklerde `contentStatus` kullanılacak.
- Yorumlar ayrı koleksiyonda tutulacak.
- Mekan, etkinlik ve konaklama dokümanlarında sadece puan özeti tutulacak.

Standart status değerleri:

```text
draft
pending
published
rejected
archived
```

## Koleksiyonlar

```text
cities
places
events
accommodations
transportGuides
routes
users
favorites
savedRoutes
reviews
aiRouteRequests
aiGeneratedRoutes
partners
adminSubmissions
```

---

# cities

Şehir bilgileri.

Örnek path:

```text
cities/samsun
```

Alanlar:

```text
id: String
name: String
slug: String
region: String
shortDescription: String
longDescription: String?
heroImageUrl: String?
latitude: Double
longitude: Double
isActive: Bool
sortOrder: Int
createdAt: Timestamp
updatedAt: Timestamp
```

Örnek:

```json
{
  "id": "samsun",
  "name": "Samsun",
  "slug": "samsun",
  "region": "Karadeniz",
  "shortDescription": "Karadeniz’in tarih, doğa ve sahil deneyimini bir arada sunan şehirlerinden biri.",
  "latitude": 41.2867,
  "longitude": 36.33,
  "isActive": true,
  "sortOrder": 1
}
```

---

# places

Mekanlar, gezilecek yerler, restoranlar ve benzeri şehir içerikleri.

Örnek path:

```text
places/bandirma-vapuru-muzesi
```

Alanlar:

```text
id: String
cityId: String
name: String
slug: String
category: String
subCategory: String?
shortDescription: String
longDescription: String?
district: String
address: String
latitude: Double
longitude: Double
openingHours: String?
priceType: String
priceInfo: String?
ticketUrl: String?
sourceUrl: String?
imageUrls: [String]
tags: [String]
isIndoor: Bool
isOutdoor: Bool
isChildFriendly: Bool
isStudentFriendly: Bool
isAccessible: Bool
averageVisitDurationMinutes: Int?
averageRating: Double
reviewCount: Int
partnerId: String?
contentStatus: String
createdBy: String?
approvedBy: String?
lastVerifiedAt: Timestamp?
createdAt: Timestamp
updatedAt: Timestamp
```

Kategori örnekleri:

```text
museum
historical
nature
food_drink
beach
shopping
religious
family
hidden_gem
entertainment
other
```

Price type örnekleri:

```text
free
paid
unknown
```

Sorgu örnekleri:

```text
places where cityId == "samsun" and contentStatus == "published"
places where cityId == "samsun" and category == "food_drink"
places where cityId == "samsun" and isChildFriendly == true
```

---

# events

Şehirdeki etkinlikler.

Örnek path:

```text
events/samsun-caz-festivali-2026
```

Alanlar:

```text
id: String
cityId: String
title: String
slug: String
category: String
description: String
venueName: String
placeId: String?
district: String?
address: String?
latitude: Double?
longitude: Double?
startDate: Timestamp
endDate: Timestamp?
priceType: String
priceInfo: String?
ticketUrl: String?
organizer: String?
partnerId: String?
sourceUrl: String?
imageUrl: String?
imageUrls: [String]
tags: [String]
isChildFriendly: Bool
isIndoor: Bool
isOutdoor: Bool
averageRating: Double
reviewCount: Int
contentStatus: String
createdBy: String?
approvedBy: String?
lastVerifiedAt: Timestamp?
createdAt: Timestamp
updatedAt: Timestamp
```

Kategori örnekleri:

```text
concert
festival
sports
exhibition
theater
workshop
family
other
```

Sorgu örnekleri:

```text
events where cityId == "samsun" and contentStatus == "published" and startDate >= now
events where cityId == "samsun" and category == "festival"
events where cityId == "samsun" and priceType == "free"
```

---

# accommodations

Konaklama önerileri.

Örnek path:

```text
accommodations/samsun-sahil-otel
```

Alanlar:

```text
id: String
cityId: String
name: String
slug: String
type: String
district: String
address: String
latitude: Double?
longitude: Double?
shortDescription: String
longDescription: String?
priceInfo: String?
features: [String]
imageUrls: [String]
averageRating: Double
reviewCount: Int
sourceUrl: String?
reservationUrl: String?
partnerId: String?
contentStatus: String
createdAt: Timestamp
updatedAt: Timestamp
```

Type örnekleri:

```text
hotel
pension
apart
hostel
bungalow
camping
other
```

---

# transportGuides

Şehir bazlı ulaşım rehberi.

Örnek path:

```text
transportGuides/samsun
```

Alanlar:

```text
id: String
cityId: String
title: String
summary: String
officialTransportUrl: String?
officialMunicipalityUrl: String?
airportTransportInfo: String?
tramInfo: String?
busInfo: String?
taxiInfo: String?
items: [Map]
lastVerifiedAt: Timestamp?
contentStatus: String
createdAt: Timestamp
updatedAt: Timestamp
```

`items` örneği:

```json
[
  {
    "title": "Tramvay",
    "subtitle": "Samsun tramvay hattı bilgileri",
    "iconName": "tram.fill",
    "detail": "Hat durakları ve çalışma saatleri burada gösterilecek.",
    "status": "Yakında"
  }
]
```

---

# routes

Hazır gezi rotaları.

Örnek path:

```text
routes/route-samsun-001
```

Alanlar:

```text
id: String
cityId: String
title: String
summary: String
durationType: String
budget: String
interests: [String]
transportType: String
companions: String?
tempo: String
stops: [Map]
contentStatus: String
createdAt: Timestamp
updatedAt: Timestamp
```

Stop örneği:

```json
{
  "id": "stop_001",
  "order": 1,
  "type": "place",
  "placeId": "bandirma-vapuru-muzesi",
  "eventId": null,
  "title": "Bandırma Vapuru Müzesi",
  "timeLabel": "09:30 - 11:00",
  "note": "Milli Mücadele tarihini keşfet."
}
```

---

# users

Kullanıcı profilleri.

Örnek path:

```text
users/{userId}
```

Alanlar:

```text
id: String
displayName: String?
email: String?
phone: String?
photoUrl: String?
selectedCityId: String?
budgetPreference: String?
interestPreferences: [String]
transportPreference: String?
notificationSettings: Map
role: String
createdAt: Timestamp
updatedAt: Timestamp
```

Role örnekleri:

```text
user
admin
partner
editor
```

Notification settings örneği:

```json
{
  "discovery": true,
  "events": true,
  "campaigns": false
}
```

---

# favorites

Kullanıcının favori mekanları.

Örnek path:

```text
favorites/{userId}_{placeId}
```

Alanlar:

```text
id: String
userId: String
placeId: String
cityId: String
createdAt: Timestamp
```

Önerilen ID:

```text
{userId}_{placeId}
```

Sorgu:

```text
favorites where userId == currentUserId
```

---

# savedRoutes

Kullanıcının kaydettiği rotalar.

Örnek path:

```text
savedRoutes/{savedRouteId}
```

Alanlar:

```text
id: String
userId: String
routeId: String?
aiGeneratedRouteId: String?
cityId: String
createdAt: Timestamp
```

---

# reviews

Mekan, etkinlik veya konaklama yorumları.

Örnek path:

```text
reviews/{reviewId}
```

Alanlar:

```text
id: String
targetType: String
targetId: String
cityId: String?
userId: String
userName: String
rating: Int
comment: String
status: String
createdAt: Timestamp
updatedAt: Timestamp?
```

Target type örnekleri:

```text
place
event
accommodation
route
```

Status örnekleri:

```text
pending
approved
rejected
hidden
```

Sorgular:

```text
reviews where targetType == "place" and targetId == "bandirma-vapuru-muzesi" and status == "approved"
reviews where userId == currentUserId
```

---

# aiRouteRequests

AI rota oluşturma istekleri.

Örnek path:

```text
aiRouteRequests/{requestId}
```

Alanlar:

```text
id: String
userId: String
cityId: String
startDate: Timestamp?
endDate: Timestamp?
budgetRange: String?
interests: [String]
tempo: String?
transportType: String?
peopleCount: Int
status: String
errorMessage: String?
createdAt: Timestamp
updatedAt: Timestamp
```

Status örnekleri:

```text
pending
processing
completed
failed
```

---

# aiGeneratedRoutes

AI tarafından üretilmiş rotalar.

Örnek path:

```text
aiGeneratedRoutes/{routeId}
```

Alanlar:

```text
id: String
requestId: String
userId: String
cityId: String
title: String
summary: String
days: [Map]
usedPlaceIds: [String]
usedEventIds: [String]
status: String
createdAt: Timestamp
updatedAt: Timestamp
```

Day örneği:

```json
{
  "day": 1,
  "title": "Tarih ve sahil rotası",
  "stops": [
    {
      "time": "10:00",
      "title": "Bandırma Vapuru Müzesi",
      "type": "place",
      "placeId": "bandirma-vapuru-muzesi",
      "note": "Milli Mücadele tarihini keşfet."
    }
  ]
}
```

---

# partners

Belediye, kurum veya işletme partnerleri.

Örnek path:

```text
partners/samsun-buyuksehir-belediyesi
```

Alanlar:

```text
id: String
name: String
type: String
cityId: String?
contactName: String?
contactEmail: String?
websiteUrl: String?
status: String
createdAt: Timestamp
updatedAt: Timestamp
```

Type örnekleri:

```text
municipality
ministry
business
hotel
restaurant
agency
other
```

---

# adminSubmissions

Admin veya partner içerik önerileri.

Örnek path:

```text
adminSubmissions/{submissionId}
```

Alanlar:

```text
id: String
submittedBy: String
partnerId: String?
targetCollection: String
targetId: String?
payload: Map
status: String
reviewedBy: String?
reviewNote: String?
createdAt: Timestamp
updatedAt: Timestamp
```

Status örnekleri:

```text
pending
approved
rejected
needs_revision
```

---

# Güvenlik kuralları mantığı

Temel okuma/yazma mantığı:

```text
cities: herkes aktif şehirleri okuyabilir, admin yazabilir
places: herkes published mekanları okuyabilir, admin yazabilir
events: herkes published etkinlikleri okuyabilir, admin yazabilir
accommodations: herkes published kayıtları okuyabilir, admin yazabilir
transportGuides: herkes published kayıtları okuyabilir, admin yazabilir
users: kullanıcı sadece kendi profilini okuyup yazabilir
favorites: kullanıcı sadece kendi favorilerini okuyup yazabilir
savedRoutes: kullanıcı sadece kendi kayıtlı rotalarını okuyup yazabilir
reviews: herkes approved yorumları okuyabilir, giriş yapan yorum oluşturabilir, admin status değiştirebilir
aiRouteRequests: kullanıcı sadece kendi isteklerini oluşturabilir/okuyabilir
aiGeneratedRoutes: kullanıcı sadece kendi AI rotalarını okuyabilir
partners: admin yönetir
adminSubmissions: admin ve yetkili partnerler yönetir
```

# İndeks ihtiyacı olacak sorgular

Muhtemel composite index gerektiren sorgular:

```text
places: cityId + contentStatus + category
places: cityId + contentStatus + isChildFriendly
places: cityId + contentStatus + priceType
places: cityId + contentStatus + averageRating

events: cityId + contentStatus + startDate
events: cityId + contentStatus + category + startDate
events: cityId + contentStatus + priceType + startDate

reviews: targetType + targetId + status + createdAt
favorites: userId + createdAt
savedRoutes: userId + createdAt
```

# Notlar

- Büyük listelerde sayfalama kullanılmalı.
- Ana sayfa için özet doküman düşünülebilir: `cityHomeSummaries/{cityId}`.
- Arama büyürse Firestore yerine Algolia veya Meilisearch eklenebilir.
- Görseller Firestore’da değil Firebase Storage’da tutulmalı; Firestore’da sadece URL tutulmalı.

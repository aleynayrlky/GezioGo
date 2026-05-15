# GezioGo – User Model / Kullanıcı Modeli

> Hafta 3 / Gün 5 çıktısı  
> Dosya amacı: Mobil kullanıcı ve panel kullanıcı verilerinin nasıl tutulacağını tanımlamak.

---

## 1. Modelin Amacı

`User` modeli iki farklı kullanıcı türünü desteklemelidir:

```text
1. Mobil uygulama kullanıcısı
2. Panel / admin / iş ortağı kullanıcısı
```

Mobil kullanıcı için model; favoriler, tercihler, kaydedilen rotalar ve kişiselleştirme için kullanılır.

Panel kullanıcısı için model; rol, yetki, bağlı kurum/işletme ve erişim kontrolü için kullanılır.

---

## 2. Temel Alanlar

| Alan | Tip | Zorunlu | Açıklama |
|---|---|---|---|
| `id` | String | Evet | Kullanıcı ID |
| `userType` | String | Evet | mobile / admin / partner |
| `role` | String | Evet | Kullanıcı rolü |
| `name` | String | Hayır | Ad soyad |
| `email` | String | Evet | E-posta |
| `phone` | String | Hayır | Telefon |
| `selectedCityId` | String | Hayır | Seçili şehir |
| `partnerId` | String | Hayır | Bağlı kurum/işletme ID |
| `authorizedCityIds` | Array<String> | Hayır | Yetkili şehirler |
| `interests` | Array<String> | Hayır | İlgi alanları |
| `budgetPreference` | String | Hayır | low / medium / high |
| `transportPreference` | String | Hayır | walking / public_transport / car |
| `accessibilityNeeds` | Array<String> | Hayır | Erişilebilirlik ihtiyaçları |
| `favoritePlaceIds` | Array<String> | Hayır | Favori mekanlar |
| `favoriteEventIds` | Array<String> | Hayır | Favori etkinlikler |
| `savedRouteIds` | Array<String> | Hayır | Kaydedilen rotalar |
| `language` | String | Hayır | Dil tercihi |
| `notificationSettings` | Object | Hayır | Bildirim ayarları |
| `isActive` | Boolean | Evet | Kullanıcı aktif mi? |
| `createdAt` | String | Evet | Oluşturulma tarihi |
| `updatedAt` | String | Evet | Güncellenme tarihi |

---

## 3. User Type Değerleri

```text
mobile
admin
partner
```

---

## 4. Role Değerleri

```text
mobile_user
super_admin
gezio_editor
municipality_admin
province_culture_admin
ministry_viewer
business_owner
hotel_agency_owner
event_organizer
content_approver
```

---

## 5. Örnek Mobil Kullanıcı JSON

```json
{
  "id": "user_001",
  "userType": "mobile",
  "role": "mobile_user",
  "name": "Elif Yılmaz",
  "email": "elif@example.com",
  "phone": "",
  "selectedCityId": "samsun",
  "partnerId": "",
  "authorizedCityIds": [],
  "interests": ["history", "nature", "food_drink"],
  "budgetPreference": "medium",
  "transportPreference": "walking",
  "accessibilityNeeds": [],
  "favoritePlaceIds": ["bandirma-vapuru-muzesi"],
  "favoriteEventIds": [],
  "savedRouteIds": [],
  "language": "tr",
  "notificationSettings": {
    "events": true,
    "routes": true,
    "marketing": false
  },
  "isActive": true,
  "createdAt": "2026-05-15T00:00:00+03:00",
  "updatedAt": "2026-05-15T00:00:00+03:00"
}
```

---

## 6. Örnek Panel Kullanıcısı JSON

```json
{
  "id": "admin_001",
  "userType": "admin",
  "role": "super_admin",
  "name": "GezioGo Admin",
  "email": "admin@geziogo.com",
  "phone": "",
  "selectedCityId": "",
  "partnerId": "",
  "authorizedCityIds": ["samsun"],
  "interests": [],
  "budgetPreference": "",
  "transportPreference": "",
  "accessibilityNeeds": [],
  "favoritePlaceIds": [],
  "favoriteEventIds": [],
  "savedRouteIds": [],
  "language": "tr",
  "notificationSettings": {
    "contentApprovals": true,
    "partnerRequests": true
  },
  "isActive": true,
  "createdAt": "2026-05-15T00:00:00+03:00",
  "updatedAt": "2026-05-15T00:00:00+03:00"
}
```

---

## 7. Swift Model Taslağı

```swift
struct AppUser: Identifiable, Codable {
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

struct NotificationSettings: Codable {
    let events: Bool?
    let routes: Bool?
    let marketing: Bool?
    let contentApprovals: Bool?
    let partnerRequests: Bool?
}
```

---

## 8. Yetki Notları

- `super_admin` tüm sistemi görebilir.
- `municipality_admin` yalnızca kendi `authorizedCityIds` içindeki şehirleri görebilir.
- `business_owner` yalnızca kendi `partnerId` verilerini görebilir.
- `content_approver` yalnızca kendisine yetki verilen içerikleri onaylayabilir.

---

## 9. MVP İçin Minimum Alanlar

Mobil MVP için:

```text
id
userType
role
selectedCityId
favoritePlaceIds
favoriteEventIds
savedRouteIds
language
```

Panel MVP için:

```text
id
userType
role
email
partnerId
authorizedCityIds
isActive
```

---

## 10. Sonuç

`User` modeli GezioGo’nun kişiselleştirme ve rol bazlı panel erişimi için temel modelidir. Mobil ve panel kullanıcıları aynı modelde tutulabilir; ancak `userType` ve `role` alanlarıyla ayrılmalıdır.

# GezioGo – Partner Model / İş Ortağı Modeli

> Hafta 3 / Gün 6 çıktısı  
> Dosya amacı: GezioGo panelinde yer alacak belediye, kurum, bakanlık, restoran/kafe, otel/acente ve etkinlik organizatörü gibi paydaşların veri modelini tanımlamak.

---

## 1. Modelin Amacı

`Partner` modeli, GezioGo’nun çok paydaşlı panel yapısının temelidir.

Bu model şu kullanıcı ve kurumları temsil eder:

- Belediye
- İl Kültür ve Turizm Müdürlüğü
- Bakanlık
- Restoran
- Kafe
- Otel
- Acente
- Etkinlik organizatörü
- Müze / kurum
- Diğer iş ortakları

Ana ilke:

> Her partner yalnızca kendi yetki alanındaki içerikleri görebilmeli ve yönetebilmelidir.

---

## 2. Partner Type Değerleri

```text
municipality
province_culture_directorate
ministry
restaurant
cafe
hotel
agency
event_organizer
museum
public_institution
private_business
other
```

---

## 3. Temel Alanlar

| Alan | Tip | Zorunlu | Açıklama |
|---|---|---|---|
| `id` | String | Evet | Partner ID |
| `name` | String | Evet | Kurum/işletme adı |
| `slug` | String | Evet | URL/dosya dostu ad |
| `type` | String | Evet | Partner türü |
| `cityId` | String | Hayır | Bağlı olduğu şehir |
| `authorizedCityIds` | Array<String> | Hayır | Yetkili olduğu şehirler |
| `authorizedUserIds` | Array<String> | Hayır | Bu partnere bağlı kullanıcılar |
| `contactEmail` | String | Hayır | İletişim e-postası |
| `contactPhone` | String | Hayır | Telefon |
| `address` | String | Hayır | Adres |
| `websiteUrl` | String | Hayır | Web sitesi |
| `logoUrl` | String | Hayır | Logo görseli |
| `status` | String | Evet | active / pending / suspended |
| `permissions` | Object | Evet | Yetki ayarları |
| `createdAt` | String | Evet | Oluşturulma tarihi |
| `updatedAt` | String | Evet | Güncellenme tarihi |

---

## 4. Permission Alanları

Önerilen `permissions` yapısı:

```json
{
  "canCreatePlace": true,
  "canEditPlace": true,
  "canCreateEvent": true,
  "canEditEvent": true,
  "canPublishDirectly": false,
  "canViewReports": true,
  "canManageUsers": false,
  "requiresApproval": true
}
```

---

## 5. Örnek Belediye Partner JSON

```json
{
  "id": "samsun-buyuksehir-belediyesi",
  "name": "Samsun Büyükşehir Belediyesi",
  "slug": "samsun-buyuksehir-belediyesi",
  "type": "municipality",
  "cityId": "samsun",
  "authorizedCityIds": ["samsun"],
  "authorizedUserIds": ["admin_samsun_001"],
  "contactEmail": "",
  "contactPhone": "",
  "address": "Samsun / Türkiye",
  "websiteUrl": "",
  "logoUrl": "",
  "status": "active",
  "permissions": {
    "canCreatePlace": true,
    "canEditPlace": true,
    "canCreateEvent": true,
    "canEditEvent": true,
    "canPublishDirectly": false,
    "canViewReports": true,
    "canManageUsers": false,
    "requiresApproval": true
  },
  "createdAt": "2026-05-15T00:00:00+03:00",
  "updatedAt": "2026-05-15T00:00:00+03:00"
}
```

---

## 6. Örnek Restoran / Kafe Partner JSON

```json
{
  "id": "sahil-kafe-samsun",
  "name": "Sahil Kafe",
  "slug": "sahil-kafe-samsun",
  "type": "cafe",
  "cityId": "samsun",
  "authorizedCityIds": ["samsun"],
  "authorizedUserIds": ["business_001"],
  "contactEmail": "",
  "contactPhone": "",
  "address": "Atakum / Samsun",
  "websiteUrl": "",
  "logoUrl": "",
  "status": "active",
  "permissions": {
    "canCreatePlace": false,
    "canEditPlace": true,
    "canCreateEvent": false,
    "canEditEvent": false,
    "canPublishDirectly": false,
    "canViewReports": true,
    "canManageUsers": false,
    "requiresApproval": true
  },
  "createdAt": "2026-05-15T00:00:00+03:00",
  "updatedAt": "2026-05-15T00:00:00+03:00"
}
```

---

## 7. Swift Model Taslağı

```swift
struct Partner: Identifiable, Codable {
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

struct PartnerPermissions: Codable {
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

---

## 8. Yetki Kuralları

- Belediye yalnızca kendi şehrindeki içerikleri yönetmelidir.
- İl müdürlüğü yalnızca kendi ilindeki kültür/turizm içeriklerini yönetmelidir.
- Bakanlık genel raporları görebilir ama günlük işletme içeriğini düzenlememelidir.
- Restoran/kafe yalnızca kendi işletmesini görebilmelidir.
- Etkinlik organizatörü yalnızca kendi etkinliklerini yönetebilmelidir.
- İçerik yayını çoğu partner için onaya bağlı olmalıdır.

---

## 9. MVP İçin Minimum Alanlar

```text
id
name
type
cityId
authorizedUserIds
status
permissions
```

---

## 10. Sonuç

`Partner` modeli, GezioGo’nun panel tarafındaki rol bazlı ve çok paydaşlı yapıyı sürdürülebilir hale getirir.

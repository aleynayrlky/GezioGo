# GezioGo – Route Model / AI Rota Modeli

> Hafta 3 / Gün 5 çıktısı  
> Dosya amacı: AI tarafından oluşturulan gezi rotalarının veri yapısını tanımlamak.

---

## 1. Modelin Amacı

`Route` modeli, GezioGo’nun AI rota oluşturma özelliğinin temel veri yapısıdır.

Bu model şu alanlarda kullanılır:

- AI rota sonucu ekranı
- Rota haritası
- Kaydedilen rotalar
- Kullanıcı geçmişi
- Favori rotalar
- Paylaşılabilir rota planı

---

## 2. Route Ana Alanları

| Alan | Tip | Zorunlu | Açıklama |
|---|---|---|---|
| `id` | String | Evet | Rota ID |
| `userId` | String | Hayır | Rotayı oluşturan kullanıcı |
| `cityId` | String | Evet | Rota şehri |
| `title` | String | Evet | Rota başlığı |
| `date` | String | Hayır | Rota tarihi |
| `durationType` | String | Evet | half_day / one_day / two_days vb. |
| `budget` | String | Hayır | low / medium / high |
| `interests` | Array<String> | Hayır | İlgi alanları |
| `transportType` | String | Hayır | walking / public_transport / car |
| `companions` | String | Hayır | alone / friends / family vb. |
| `tempo` | String | Hayır | slow / balanced / intense |
| `stops` | Array<RouteStop> | Evet | Rota durakları |
| `totalDurationMinutes` | Int | Hayır | Toplam süre |
| `totalDistanceKm` | Double | Hayır | Toplam mesafe |
| `estimatedCostLevel` | String | Hayır | low / medium / high |
| `aiPromptVersion` | String | Hayır | Kullanılan prompt versiyonu |
| `isSaved` | Boolean | Evet | Kullanıcı kaydetti mi? |
| `createdAt` | String | Evet | Oluşturulma tarihi |
| `updatedAt` | String | Evet | Güncellenme tarihi |

---

## 3. Route Stop Alanları

| Alan | Tip | Zorunlu | Açıklama |
|---|---|---|---|
| `order` | Int | Evet | Rota sırası |
| `type` | String | Evet | place / event / break / food |
| `placeId` | String | Hayır | Mekan ID |
| `eventId` | String | Hayır | Etkinlik ID |
| `title` | String | Evet | Durak başlığı |
| `timeLabel` | String | Hayır | 09:00 - 10:00 gibi |
| `durationMinutes` | Int | Hayır | Durakta kalma süresi |
| `note` | String | Hayır | AI açıklaması |
| `latitude` | Double | Hayır | Enlem |
| `longitude` | Double | Hayır | Boylam |

---

## 4. Örnek JSON

```json
{
  "id": "route_samsun_001",
  "userId": "user_001",
  "cityId": "samsun",
  "title": "Samsun’da 1 Günlük Tarih ve Sahil Rotası",
  "date": "2026-06-01",
  "durationType": "one_day",
  "budget": "medium",
  "interests": ["history", "nature", "food_drink"],
  "transportType": "walking",
  "companions": "friends",
  "tempo": "balanced",
  "stops": [
    {
      "order": 1,
      "type": "place",
      "placeId": "bandirma-vapuru-muzesi",
      "eventId": "",
      "title": "Bandırma Vapuru Müzesi",
      "timeLabel": "09:30 - 10:30",
      "durationMinutes": 60,
      "note": "Güne Samsun’un simge tarihi duraklarından biriyle başla.",
      "latitude": 41.286,
      "longitude": 36.36
    },
    {
      "order": 2,
      "type": "place",
      "placeId": "atakum-sahili",
      "eventId": "",
      "title": "Atakum Sahili",
      "timeLabel": "12:00 - 13:30",
      "durationMinutes": 90,
      "note": "Sahil yürüyüşü ve öğle molası için uygun bir durak.",
      "latitude": 41.34,
      "longitude": 36.25
    }
  ],
  "totalDurationMinutes": 360,
  "totalDistanceKm": 12.4,
  "estimatedCostLevel": "medium",
  "aiPromptVersion": "v1",
  "isSaved": true,
  "createdAt": "2026-05-15T00:00:00+03:00",
  "updatedAt": "2026-05-15T00:00:00+03:00"
}
```

---

## 5. Swift Model Taslağı

```swift
struct TripRoute: Identifiable, Codable {
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

struct RouteStop: Codable {
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

---

## 6. AI Güvenlik Notları

- AI yalnızca `published` durumundaki mekan ve etkinlikleri kullanmalıdır.
- AI, fiyat ve saat gibi değişken bilgileri kesin ifade etmemelidir.
- Kaynağı belirsiz yerleri rota içine almamalıdır.
- Kullanıcıya alternatif rota sunarken doğrulanmış verileri tercih etmelidir.

---

## 7. MVP İçin Minimum Alanlar

```text
id
cityId
title
durationType
budget
interests
transportType
stops
totalDurationMinutes
totalDistanceKm
createdAt
```

---

## 8. Sonuç

`Route` modeli GezioGo’nun “listeleyen değil, planlayan şehir rehberi” farkını taşıyan ana veri modelidir.

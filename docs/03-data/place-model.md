# GezioGo – Place Model / Mekan Modeli

> Hafta 3 / Gün 3 çıktısı  
> Dosya amacı: GezioGo’da gezilecek yer, müze, doğa alanı, restoran, kafe ve benzeri mekanların veri yapısını tanımlamak.

---

## 1. Modelin Amacı

`Place` modeli, GezioGo’nun en kritik veri modelidir.

Mekan verisi şu alanlarda kullanılır:

- Mekan listesi
- Mekan detay sayfası
- Harita pinleri
- Favoriler
- AI rota oluşturma
- Sesli rehber
- Panel üzerinden içerik girişi
- İçerik onay süreci

---

## 2. Temel Alanlar

| Alan | Tip | Zorunlu | Açıklama |
|---|---|---|---|
| `id` | String | Evet | Mekan benzersiz ID değeri |
| `cityId` | String | Evet | Bağlı olduğu şehir ID’si |
| `name` | String | Evet | Mekan adı |
| `slug` | String | Evet | URL/dosya dostu ad |
| `category` | String | Evet | Ana kategori |
| `subCategory` | String | Hayır | Alt kategori |
| `shortDescription` | String | Evet | Kısa açıklama |
| `longDescription` | String | Hayır | Detaylı açıklama |
| `district` | String | Evet | İlçe |
| `address` | String | Evet | Açık adres |
| `latitude` | Double | Evet | Enlem |
| `longitude` | Double | Evet | Boylam |
| `openingHours` | String | Hayır | Açılış/kapanış bilgisi |
| `priceType` | String | Evet | free / paid / unknown |
| `priceInfo` | String | Hayır | Ücret açıklaması |
| `ticketUrl` | String | Hayır | Bilet veya rezervasyon bağlantısı |
| `sourceUrl` | String | Hayır | Bilgi kaynağı |
| `imageUrls` | Array<String> | Hayır | Görsel bağlantıları |
| `tags` | Array<String> | Hayır | Arama/filtre etiketleri |
| `isIndoor` | Boolean | Evet | Kapalı alan mı? |
| `isOutdoor` | Boolean | Evet | Açık alan mı? |
| `isChildFriendly` | Boolean | Hayır | Çocukla uygun mu? |
| `isStudentFriendly` | Boolean | Hayır | Öğrenci dostu mu? |
| `isAccessible` | Boolean | Hayır | Erişilebilir mi? |
| `averageVisitDurationMinutes` | Int | Hayır | Ortalama ziyaret süresi |
| `partnerId` | String | Hayır | İçerikten sorumlu kurum/işletme |
| `contentStatus` | String | Evet | İçerik durumu |
| `createdBy` | String | Hayır | Oluşturan kullanıcı |
| `approvedBy` | String | Hayır | Onaylayan kullanıcı |
| `lastVerifiedAt` | String | Hayır | Son doğrulama tarihi |
| `createdAt` | String | Evet | Oluşturulma tarihi |
| `updatedAt` | String | Evet | Güncellenme tarihi |

---

## 3. Kategori Değerleri

Önerilen kategori değerleri:

```text
historical
museum
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

Uygulamada Türkçe gösterimler:

| Teknik Değer | Kullanıcıya Görünen Ad |
|---|---|
| `historical` | Tarihi Yerler |
| `museum` | Müzeler |
| `nature` | Doğa ve Yeşil Alanlar |
| `food_drink` | Yeme İçme |
| `beach` | Sahil |
| `shopping` | Alışveriş |
| `religious` | İnanç / Dini Yapılar |
| `family` | Aile Dostu |
| `hidden_gem` | Gizli Rotalar |
| `entertainment` | Eğlence |
| `other` | Diğer |

---

## 4. Price Type Değerleri

```text
free
paid
unknown
```

---

## 5. Örnek JSON

```json
{
  "id": "bandirma-vapuru-muzesi",
  "cityId": "samsun",
  "name": "Bandırma Vapuru Müzesi",
  "slug": "bandirma-vapuru-muzesi",
  "category": "museum",
  "subCategory": "history_museum",
  "shortDescription": "Milli Mücadele’nin simgelerinden Bandırma Vapuru’nun sergilendiği müze.",
  "longDescription": "Bandırma Vapuru Müzesi, Samsun’un tarihi kimliğini ve Milli Mücadele sürecini ziyaretçilere anlatan önemli kültürel duraklardan biridir.",
  "district": "Canik",
  "address": "Belediye Evleri Mahallesi, Canik / Samsun",
  "latitude": 41.286,
  "longitude": 36.36,
  "openingHours": "Pazartesi hariç 08:30 - 17:00",
  "priceType": "paid",
  "priceInfo": "Giriş ücreti değişebilir. Güncel bilgi için resmi kaynak kontrol edilmelidir.",
  "ticketUrl": "",
  "sourceUrl": "",
  "imageUrls": [],
  "tags": ["müze", "tarih", "milli mücadele", "samsun"],
  "isIndoor": true,
  "isOutdoor": true,
  "isChildFriendly": true,
  "isStudentFriendly": true,
  "isAccessible": false,
  "averageVisitDurationMinutes": 60,
  "partnerId": "samsun-buyuksehir-belediyesi",
  "contentStatus": "published",
  "createdBy": "system-admin",
  "approvedBy": "system-admin",
  "lastVerifiedAt": "2026-05-15",
  "createdAt": "2026-05-15T00:00:00+03:00",
  "updatedAt": "2026-05-15T00:00:00+03:00"
}
```

---

## 6. Swift Model Taslağı

```swift
struct Place: Identifiable, Codable {
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

---

## 7. MVP İçin Minimum Alanlar

```text
id
cityId
name
category
shortDescription
district
address
latitude
longitude
priceType
imageUrls
isIndoor
isOutdoor
contentStatus
```

---

## 8. Panel Kullanım Notları

- İşletme kullanıcıları sadece kendi `partnerId` değerine bağlı mekanları düzenleyebilmelidir.
- Belediye veya kurum kullanıcıları sadece yetkili olduğu `cityId` içindeki mekanları yönetebilmelidir.
- Yayına alınacak her mekanın `contentStatus` değeri `published` olmalıdır.
- Kaynak bilgisi olmayan içerikler `pending_review` veya `needs_revision` durumunda tutulabilir.

---

## 9. AI Kullanım Notları

AI rota oluştururken yalnızca şu mekanları kullanmalıdır:

- `contentStatus = published`
- `cityId` kullanıcının seçtiği şehirle aynı
- Konum bilgisi dolu
- Kullanıcının ilgi alanına uygun kategori veya etiketlere sahip

---

## 10. Sonuç

`Place` modeli GezioGo’nun ana içerik omurgasıdır. Bu model ne kadar düzenli tasarlanırsa mobil uygulama, panel ve AI rota sistemi o kadar sağlıklı çalışır.

# GezioGo – Event Model / Etkinlik Modeli

> Hafta 3 / Gün 4 çıktısı  
> Dosya amacı: GezioGo’da etkinlik verisinin hangi alanlardan oluşacağını tanımlamak.

---

## 1. Modelin Amacı

`Event` modeli; konser, festival, sergi, tiyatro, atölye, çocuk etkinliği, kültür-sanat programı gibi tarih ve saat bazlı içerikleri temsil eder.

Etkinlik modeli şu alanlarda kullanılır:

- Etkinlik listesi
- Etkinlik detay sayfası
- Ana sayfa öne çıkan etkinlikler
- Bilet linki yönlendirme
- AI rota önerileri
- Yönetim paneli etkinlik girişi
- İçerik onay süreci

---

## 2. Temel Alanlar

| Alan | Tip | Zorunlu | Açıklama |
|---|---|---|---|
| `id` | String | Evet | Etkinlik benzersiz ID değeri |
| `cityId` | String | Evet | Etkinliğin şehir ID’si |
| `title` | String | Evet | Etkinlik adı |
| `slug` | String | Evet | URL/dosya dostu ad |
| `category` | String | Evet | Etkinlik kategorisi |
| `description` | String | Evet | Etkinlik açıklaması |
| `venueName` | String | Evet | Etkinlik mekan adı |
| `placeId` | String | Hayır | Eğer sistemde kayıtlı mekansa bağlı mekan ID’si |
| `district` | String | Hayır | İlçe |
| `address` | String | Hayır | Açık adres |
| `latitude` | Double | Hayır | Enlem |
| `longitude` | Double | Hayır | Boylam |
| `startDate` | String | Evet | Başlangıç tarihi/saat |
| `endDate` | String | Hayır | Bitiş tarihi/saat |
| `priceType` | String | Evet | free / paid / unknown |
| `priceInfo` | String | Hayır | Ücret açıklaması |
| `ticketUrl` | String | Hayır | Bilet/kayıt linki |
| `organizer` | String | Hayır | Düzenleyen kişi/kurum |
| `partnerId` | String | Hayır | Organizasyon/kaynak partner ID’si |
| `sourceUrl` | String | Hayır | Bilgi kaynağı |
| `imageUrl` | String | Hayır | Ana etkinlik görseli |
| `imageUrls` | Array<String> | Hayır | Ek görseller |
| `tags` | Array<String> | Hayır | Arama/filtre etiketleri |
| `isChildFriendly` | Boolean | Hayır | Çocukla uygun mu? |
| `isIndoor` | Boolean | Hayır | Kapalı alan mı? |
| `isOutdoor` | Boolean | Hayır | Açık alan mı? |
| `contentStatus` | String | Evet | İçerik durumu |
| `createdBy` | String | Hayır | Oluşturan kullanıcı |
| `approvedBy` | String | Hayır | Onaylayan kullanıcı |
| `lastVerifiedAt` | String | Hayır | Son doğrulama tarihi |
| `createdAt` | String | Evet | Oluşturulma tarihi |
| `updatedAt` | String | Evet | Güncellenme tarihi |

---

## 3. Etkinlik Kategorileri

```text
concert
festival
theater
exhibition
workshop
sports
kids
culture
cinema
conference
other
```

Kullanıcıya görünen Türkçe adlar:

| Teknik Değer | Türkçe Ad |
|---|---|
| `concert` | Konser |
| `festival` | Festival |
| `theater` | Tiyatro |
| `exhibition` | Sergi |
| `workshop` | Atölye |
| `sports` | Spor |
| `kids` | Çocuk Etkinliği |
| `culture` | Kültür-Sanat |
| `cinema` | Sinema |
| `conference` | Konferans |
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
  "id": "samsun-caz-festivali-2026",
  "cityId": "samsun",
  "title": "Samsun Caz Festivali",
  "slug": "samsun-caz-festivali-2026",
  "category": "festival",
  "description": "Samsun’da caz müziğini şehirle buluşturan kültür-sanat etkinliği.",
  "venueName": "Samsun Kültür Merkezi",
  "placeId": "",
  "district": "İlkadım",
  "address": "İlkadım / Samsun",
  "latitude": 41.29,
  "longitude": 36.33,
  "startDate": "2026-06-20T20:00:00+03:00",
  "endDate": "2026-06-20T23:00:00+03:00",
  "priceType": "paid",
  "priceInfo": "Bilet fiyatı değişebilir. Güncel bilgi için bilet linki kontrol edilmelidir.",
  "ticketUrl": "",
  "organizer": "Samsun Kültür Sanat",
  "partnerId": "samsun-kultur-sanat",
  "sourceUrl": "",
  "imageUrl": "",
  "imageUrls": [],
  "tags": ["caz", "festival", "konser", "kültür sanat"],
  "isChildFriendly": false,
  "isIndoor": true,
  "isOutdoor": false,
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
struct Event: Identifiable, Codable {
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

---

## 7. MVP İçin Minimum Alanlar

```text
id
cityId
title
category
description
venueName
startDate
priceType
ticketUrl
imageUrl
contentStatus
```

---

## 8. Panel Kullanım Notları

- Etkinliklerde `startDate` zorunlu olmalıdır.
- Bilet linki yoksa kullanıcıya “Bilet bilgisi bulunamadı” gösterilebilir.
- Etkinlik tarihi geçmişse otomatik olarak pasif/arsiv durumuna alınabilir.
- Organizatör kullanıcıları yalnızca kendi `partnerId` değerine bağlı etkinlikleri düzenleyebilmelidir.

---

## 9. AI Kullanım Notları

AI rota oluştururken etkinlikleri yalnızca şu durumlarda kullanmalıdır:

- Etkinlik seçilen şehirdeyse
- Tarih, kullanıcının rota tarihiyle uyumluysa
- `contentStatus = published` ise
- Gerekli tarih/saat bilgisi doluysa

---

## 10. Sonuç

`Event` modeli GezioGo’nun şehir içi canlılık ve güncellik tarafını besler. Kullanıcıya “bugün ne yapabilirim?” sorusunun cevabını verir.

# GezioGo – City Model / Şehir Modeli

> Hafta 3 / Gün 2 çıktısı  
> Dosya amacı: GezioGo’da şehir verisinin hangi alanlardan oluşacağını tanımlamak.

---

## 1. Modelin Amacı

`City` modeli, GezioGo’da desteklenen şehirleri temsil eder.

Şehir modeli şu alanlarda kullanılır:

- Şehir seçimi ekranı
- Şehir ana sayfası
- Mekan ve etkinlik filtreleme
- Şehir bazlı panel yetkilendirme
- AI rota oluşturma
- Çoklu şehir desteği

İlk şehir: **Samsun**

---

## 2. Temel Alanlar

| Alan | Tip | Zorunlu | Açıklama |
|---|---|---|---|
| `id` | String | Evet | Şehir benzersiz ID değeri |
| `name` | String | Evet | Şehir adı |
| `slug` | String | Evet | URL/dosya dostu ad |
| `country` | String | Evet | Ülke adı |
| `region` | String | Evet | Bölge adı |
| `shortDescription` | String | Evet | Kısa şehir açıklaması |
| `longDescription` | String | Hayır | Detaylı şehir açıklaması |
| `coverImageUrl` | String | Hayır | Ana şehir görseli |
| `thumbnailUrl` | String | Hayır | Küçük görsel |
| `latitude` | Double | Evet | Şehir merkez enlemi |
| `longitude` | Double | Evet | Şehir merkez boylamı |
| `popularCategoryIds` | Array<String> | Hayır | Öne çıkan kategoriler |
| `weatherRegionCode` | String | Hayır | Hava durumu bölge kodu |
| `isActive` | Boolean | Evet | Şehir uygulamada aktif mi? |
| `createdAt` | String | Evet | Oluşturulma tarihi |
| `updatedAt` | String | Evet | Güncellenme tarihi |

---

## 3. Örnek JSON

```json
{
  "id": "samsun",
  "name": "Samsun",
  "slug": "samsun",
  "country": "Türkiye",
  "region": "Karadeniz",
  "shortDescription": "Karadeniz’in tarih, doğa ve sahil deneyimini bir arada sunan şehirlerinden biri.",
  "longDescription": "Samsun; Bandırma Vapuru, sahil hattı, müzeleri, doğal alanları ve kültürel etkinlikleriyle GezioGo’nun ilk pilot şehridir.",
  "coverImageUrl": "",
  "thumbnailUrl": "",
  "latitude": 41.2867,
  "longitude": 36.33,
  "popularCategoryIds": ["historical", "museum", "nature", "food_drink", "event"],
  "weatherRegionCode": "TR-55",
  "isActive": true,
  "createdAt": "2026-05-15T00:00:00+03:00",
  "updatedAt": "2026-05-15T00:00:00+03:00"
}
```

---

## 4. Swift Model Taslağı

```swift
struct City: Identifiable, Codable {
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

---

## 5. Kullanım Notları

- `id` alanı küçük harf ve Türkçe karakter içermeyen formatta olmalıdır.
- İlk şehir için `id = samsun` kullanılmalıdır.
- Şehir aktif değilse mobil uygulamada gösterilmemelidir.
- Çoklu şehir desteğinde tüm mekan ve etkinlikler `cityId` ile bu modele bağlanacaktır.

---

## 6. MVP İçin Minimum Alanlar

MVP için gerekli minimum şehir alanları:

```text
id
name
slug
country
region
shortDescription
latitude
longitude
isActive
```

---

## 7. Sonuç

`City` modeli GezioGo’nun çoklu şehir yapısının temelidir. İlk aşamada sadece Samsun kullanılacak olsa bile model çoklu şehre hazır tasarlanmalıdır.

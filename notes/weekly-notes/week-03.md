# GezioGo – Hafta 03 Özeti

> Hafta 3 çıktısı  
> Ana konu: Veri modeli, içerik şablonları ve Samsun örnek veri yapısı.

---

## 1. Haftanın Ana Amacı

3. haftanın amacı GezioGo’nun veri omurgasını kurmaktır.

Bu hafta şu soruya cevap verildi:

> GezioGo’daki şehir, mekan, etkinlik, kullanıcı, rota, iş ortağı ve içerik onay bilgileri hangi veri yapısıyla tutulacak?

---

## 2. Bu Hafta Hazırlanan Dosyalar

```text
docs/03-data/data-model-overview.md
docs/03-data/city-model.md
docs/03-data/place-model.md
docs/03-data/event-model.md
docs/03-data/user-model.md
docs/03-data/route-model.md
docs/03-data/partner-model.md
docs/03-data/content-status-model.md
docs/03-data/content-entry-rules.md

data/templates/city-template.json
data/templates/place-template.json
data/templates/event-template.json
data/templates/route-template.json
data/templates/partner-template.json

data/sample/samsun/samsun-city.json
data/sample/samsun/samsun-places-sample.json
data/sample/samsun/samsun-events-sample.json
```

---

## 3. Netleşen Ana Veri Modelleri

- City
- Place
- Event
- User
- Route
- Partner
- ContentStatus

Ana veri ilişkisi:

```text
City → Place → Event → Route → User → Partner → ContentStatus
```

---

## 4. Netleşen İçerik Yayın Mantığı

GezioGo’da içerikler doğrudan yayına çıkmamalıdır.

Önerilen akış:

```text
Taslak → Onaya Gönderildi → İnceleme → Onaylandı → Yayında
```

Alternatif durumlar:

```text
Revizyon Gerekli
Reddedildi
Arşivlendi
```

Mobil uygulamada yalnızca `published` durumundaki içerikler görünmelidir.

---

## 5. AI Rota İçin Veri Kuralı

AI rota oluştururken yalnızca şu içerikler kullanılmalıdır:

- Yayında olan içerikler
- Seçilen şehre ait içerikler
- Konum bilgisi dolu mekanlar
- Kategori/etiket bilgisi anlamlı olan içerikler
- Tarihi uygun etkinlikler

AI, taslak veya onay bekleyen içerikleri rota önerisine almamalıdır.

---

## 6. Samsun Örnek Veri Başlangıcı

Bu hafta Samsun için örnek veri dosyaları oluşturuldu:

- `samsun-city.json`
- `samsun-places-sample.json`
- `samsun-events-sample.json`

Bunlar gerçek veri çalışmasına geçmeden önce modelin nasıl kullanılacağını göstermek için hazırlandı.

---

## 7. 4. Haftaya Hazırlık

4. haftada önerilen konu:

> Figma / wireframe düzenleme + SwiftUI proje hazırlığı + model dosyalarını Swift tarafına taşıma

Olası 4. hafta dosyaları:

```text
docs/design/wireframe-notes.md
docs/ios/swift-models-plan.md
docs/ios/project-folder-structure.md
docs/ios/mock-data-usage.md
```

---

## 8. Kısa Sonuç

3. hafta GezioGo’nun veri iskeleti oluşturuldu.

Ana karar:

> Veri modeli mobil uygulama, AI rota ve yönetim paneli tarafından ortak kullanılacak şekilde tasarlanmalıdır.

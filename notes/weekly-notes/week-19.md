# GezioGo – Hafta 19 Özeti

> Ana konu: Rota veri kalitesi, MockRoutes / MockPlaces / MockEvents kontrolü, rota üst bilgilerinin tutarlılığı ve veri görünümünün UI’a daha iyi yansıması.

---

## 1. Haftanın Ana Amacı

19. haftada GezioGo’nun rota verileri ürün kalitesine daha yakın hale getirildi.

Önceki haftalarda rota detay ekranı, harita, yol tarifi, paylaşım ve component temizliği yapılmıştı. Bu hafta bu ekranların beslendiği mock verilerin tutarlı olup olmadığı kontrol edildi.

Hafta boyunca özellikle şu konulara bakıldı:

```text
MockRoutes verileri doğru mu?
MockPlaces bağlantıları doğru mu?
MockEvents bağlantıları doğru mu?
RouteStop placeId / eventId alanları tutarlı mı?
Koordinatlar harita ve yol tarifi için yeterli mi?
Rota süre, mesafe, ulaşım, tempo ve bütçe değerleri mantıklı mı?
Rota kartlarında veri daha okunur görünüyor mu?
```

Hafta sonunda:

```text
MockRoutes içindeki ana rota kontrol edildi.
Stop id eksikleri tespit edildi.
transportType için walking yerine mixed daha doğru bulundu.
MockPlaces bağlantıları doğrulandı.
MockEvents bağlantıları doğrulandı.
Koordinatların harita ve yol tarifi için yeterli olduğu görüldü.
companions alanı Türkçeleştirildi.
RouteCard metadata görünümü iyileştirildi.
```

---

## 2. Bu Hafta Yapılanlar

## Gün 1 – MockRoutes Veri Kontrolü

Kontrol edilen dosya:

```text
Data/Mock/MockRoutes.json
```

Yapılanlar:

- Rota id alanı kontrol edildi.
- `cityId` değerinin `samsun` olduğu kontrol edildi.
- `durationType`, `budget`, `transportType`, `tempo` alanları kontrol edildi.
- Rota duraklarının `order` sırası kontrol edildi.
- Durak başlıklarının dolu olduğu kontrol edildi.
- `placeId` değerlerinin mantıklı olduğu kontrol edildi.
- `latitude` / `longitude` değerlerinin bulunduğu kontrol edildi.
- Stop seviyesinde `id` alanının eksik olduğu görüldü.
- `transportType: walking` değerinin rota mesafesi için çok uygun olmadığı, `mixed` değerinin daha doğru olacağı belirlendi.

Önerilen güncelleme:

```text
Stop id eklenmeli.
transportType walking yerine mixed olmalı.
```

Günün sonucu:

> MockRoutes verisinde harita, paylaşım ve rota detay akışlarını etkileyebilecek temel alanlar kontrol edildi.

---

## Gün 2 – Eksik Koordinat Kontrolü

Kontrol edilen dosyalar:

```text
Data/Mock/MockRoutes.json
Data/Mock/MockPlaces.json
Data/Mock/MockEvents.json
```

Yapılanlar:

- Bandırma Vapuru Müzesi koordinatları kontrol edildi.
- Atakum Sahili koordinatları kontrol edildi.
- RouteStop koordinatları ile MockPlaces koordinatlarının tutarlı olduğu görüldü.
- MockEvents içindeki etkinlik koordinatları kontrol edildi.
- Haritada görünmesi gereken ana duraklarda koordinat eksikliği olmadığı görüldü.

Kontrol edilen ana koordinatlar:

```text
Bandırma Vapuru Müzesi → 41.286 / 36.36
Atakum Sahili → 41.34 / 36.25
Amazon Köyü → 41.30 / 36.32
Samsun Caz Festivali → 41.29 / 36.33
Sahil Yürüyüşü Etkinliği → 41.34 / 36.25
```

Günün sonucu:

> Mevcut rotada harita ve yol tarifi için zorunlu koordinat eksiği bulunmadı.

---

## Gün 3 – Place / Event Bağlantı Kontrolü

Kontrol edilen dosyalar:

```text
Data/Mock/MockRoutes.json
Data/Mock/MockPlaces.json
Data/Mock/MockEvents.json
```

Yapılanlar:

- RouteStop içindeki `placeId` bağlantıları kontrol edildi.
- Bandırma Vapuru Müzesi stop’unun `bandirma-vapuru-muzesi` placeId’si ile eşleştiği görüldü.
- Atakum Sahili stop’unun `atakum-sahili` placeId’si ile eşleştiği görüldü.
- Mevcut rotada `eventId` kullanılmadığı için event bağlantısında değişiklik gerekmedi.
- MockEvents içinde `samsun-sahil-yuruyusu-2026` etkinliğinin `atakum-sahili` ile bağlantılı olduğu görüldü.

Günün sonucu:

> Mevcut rota duraklarının place bağlantıları doğru ve mekan detay geçişleri için uygun bulundu.

---

## Gün 4 – Rota Süre / Mesafe / Tempo Tutarlılığı

Kontrol edilen dosya:

```text
Data/Mock/MockRoutes.json
```

Yapılanlar:

- `durationType` kontrol edildi.
- `totalDurationMinutes` kontrol edildi.
- `totalDistanceKm` kontrol edildi.
- `transportType` kontrol edildi.
- `tempo` kontrol edildi.
- `budget` ve `estimatedCostLevel` kontrol edildi.
- `companions` alanı kontrol edildi.

Mevcut rota değerleri:

```text
durationType → one_day
totalDurationMinutes → 360
totalDistanceKm → 12.4
transportType → mixed
tempo → balanced
budget → medium
estimatedCostLevel → medium
companions → friends
```

Değerlendirme:

```text
1 günlük rota için one_day doğru.
360 dakika, rota akışı için kabul edilebilir.
12.4 km, Bandırma - Atakum mesafesi için mantıklı.
mixed ulaşım tipi, walking değerinden daha gerçekçi.
balanced tempo uygun.
medium bütçe uygun.
friends değeri kullanıcıya ham görünürse Türkçeleştirilmeli.
```

Günün sonucu:

> Rota süre, mesafe, ulaşım, tempo ve bütçe değerleri genel olarak mantıklı bulundu.

---

## Gün 5 – companions Türkçeleştirme ve Paylaşım Metni İyileştirme

Güncellenen dosyalar:

```text
Features/Routes/RouteDetailViewModel.swift
Services/Routes/RouteShareTextBuilder.swift
```

Yapılanlar:

- `companions` alanının kullanıcıya ham veri olarak görünmemesi için Türkçeleştirme planlandı.
- `friends` değerinin `Arkadaşlarla` olarak gösterilmesi sağlandı.
- `RouteDetailViewModel` içinde `companionDisplayName(_:)` helper’ı eklendi.
- `companionText` property’si bu helper’ı kullanacak şekilde güncellendi.
- `RouteShareTextBuilder` içine companions bilgisinin paylaşım metnine eklenmesi planlandı.
- Paylaşım metninde `Kimler için: Arkadaşlarla` satırı desteklendi.

Eşleme mantığı:

```text
solo → Tek başına
friends → Arkadaşlarla
family → Aileyle
couple → Çift olarak
everyone → Herkes için uygun
```

Günün sonucu:

> Rota detay ekranında ve paylaşım metninde `friends` gibi ham değerler yerine kullanıcı dostu Türkçe metin gösterilecek hale getirildi.

---

## Gün 6 – RouteCard Metadata Görünümü

Güncellenen dosya:

```text
Features/Routes/Components/RouteCard.swift
```

Yapılanlar:

- RouteCard içinde rota verilerinin daha anlaşılır gösterilmesi planlandı.
- Tag satırında süre, ulaşım, tempo ve bütçe bilgilerinin daha net görünmesi hedeflendi.
- `tempo` bilgisi kart etiketlerine eklendi.
- `transportIconName` helper’ı kontrol edildi.
- `tempoIconName` helper’ı eklendi.
- `durationTypeText` kontrol edildi.
- Kaydedilmiş rota için `Kaydedildi` etiketi korunacak şekilde yapı netleştirildi.

Beklenen RouteCard etiketleri:

```text
Kaydedildi
1 Gün
Karma
Dengeli
Orta
```

Günün sonucu:

> RouteCard rota verilerini daha anlaşılır metadata etiketleriyle gösterecek hale getirildi.

---

## Gün 7 – Haftalık Kontrol

Yapılanlar:

- MockRoutes kontrol edildi.
- MockPlaces kontrol edildi.
- MockEvents kontrol edildi.
- Koordinatların yeterli olduğu doğrulandı.
- Place bağlantılarının doğru olduğu doğrulandı.
- Event bağlantılarında mevcut rota için sorun olmadığı görüldü.
- Rota süre / mesafe / tempo bilgilerinin mantıklı olduğu kontrol edildi.
- companions alanının Türkçeleştirilmesi ele alındı.
- RouteCard metadata görünümü iyileştirildi.
- `week-19.md` dosyası hazırlandı.

Günün sonucu:

> 19. hafta sonunda rota verileri ve bu verilerin ekrandaki görünümü daha tutarlı hale getirildi.

---

## 3. Oluşan Ana Akışlar

### MockRoutes Veri Akışı

```text
MockRoutes.json
↓
RoutesView
↓
RouteCard
↓
RouteDetailView
↓
RouteMapView / RouteStopCard / ShareLink
```

### Place Bağlantısı Akışı

```text
RouteStop.placeId
↓
MockPlaces.id
↓
RouteDetailViewModel.place(for:)
↓
Mekan detayını aç
```

### Event Bağlantısı Akışı

```text
RouteStop.eventId
↓
MockEvents.id
↓
RouteDetailViewModel.event(for:)
↓
Etkinlik detayını aç
```

### Companion Görünüm Akışı

```text
route.companions = friends
↓
companionDisplayName
↓
Arkadaşlarla
↓
RouteDetailView / Paylaşım metni
```

### RouteCard Metadata Akışı

```text
TripRoute
↓
durationType / transportType / tempo / budget
↓
RouteCard tagRow
↓
Kullanıcı dostu rota etiketi
```

---

## 4. Bu Hafta Oluşan Dosyalar

Bu hafta yeni dosya oluşturulmadı.

Mevcut dosyalar ve mock veri yapıları kontrol edildi / iyileştirildi:

```text
Data/Mock/MockRoutes.json
Data/Mock/MockPlaces.json
Data/Mock/MockEvents.json
Features/Routes/RouteDetailViewModel.swift
Services/Routes/RouteShareTextBuilder.swift
Features/Routes/Components/RouteCard.swift
```

---

## 5. Bu Hafta Güncellenen / Kontrol Edilen Dosyalar

```text
Data/Mock/
├── MockRoutes.json
├── MockPlaces.json
└── MockEvents.json

Features/Routes/
└── RouteDetailViewModel.swift

Features/Routes/Components/
└── RouteCard.swift

Services/Routes/
└── RouteShareTextBuilder.swift
```

---

## 6. Teknik Kararlar

Bu hafta alınan teknik kararlar:

- Mevcut rota için `transportType` değeri `mixed` olmalı.
- RouteStop nesnelerinde `id` alanı bulunmalı.
- Harita ve yol tarifi için RouteStop seviyesinde koordinat tutulmalı.
- RouteStop koordinatları MockPlaces / MockEvents koordinatlarıyla tutarlı olmalı.
- Ham veri değerleri kullanıcıya doğrudan gösterilmemeli.
- `companions` gibi alanlar UI’da Türkçeleştirilmeli.
- RouteCard metadata etiketleri rota kalitesini hızlı anlatacak şekilde düzenlenmeli.

---

## 7. Şu An Çalışan Özellikler

- MockRoutes ana rota verisi kontrol edildi.
- MockPlaces bağlantıları doğru.
- MockEvents bağlantıları doğru.
- Bandırma ve Atakum koordinatları harita için uygun.
- Rota detay ekranı harita ve durak verisiyle çalışıyor.
- Mekan detay geçişleri placeId üzerinden çalışmalı.
- Yol tarifi butonları koordinatlı duraklarda çalışmalı.
- Paylaşım metni rota duraklarını sırayla gösteriyor.
- companions bilgisi Türkçe görünecek şekilde iyileştirildi.
- RouteCard metadata görünümü daha anlaşılır hale getirildi.

---

## 8. Bilinen Eksikler

Şu konular henüz yapılmadı:

- Daha fazla mock rota ekleme
- Daha fazla Samsun durağı koordinatı ekleme
- Mock veriler için otomatik doğrulama script’i
- RouteShareTextBuilder için test yazma
- Place / Event category enum değerlerini topluca doğrulama
- companions alanını enum modele dönüştürme
- Çoklu companion desteği
- Gerçek backend verisiyle doğrulama

---

## 9. 20. Haftaya Hazırlık

20. haftanın önerilen ana konusu:

```text
Yeni mock rota ekleme ve rota çeşitliliği
```

Önerilen işler:

```text
1. Samsun için ikinci hazır rota ekleme
2. Doğa / aile odaklı rota oluşturma
3. Amazon Köyü gibi mevcut MockPlaces verilerini rotaya bağlama
4. MockRoutes içinde çoklu rota testleri
5. RoutesView filtrelerinin birden fazla rota ile test edilmesi
6. Favoriler ve paylaşım akışlarının çoklu rota ile kontrolü
```

Alternatif konu:

```text
Mock veri doğrulama checklist/script hazırlığı
```

Ama önerilen öncelik:

> Daha fazla mock rota ekleyerek RoutesView ve filtreleri gerçekçi test etmek.

---

## 10. Kısa Sonuç

19. hafta sonunda GezioGo’da rota verileri ve rota verilerinin ekrana yansıması daha tutarlı hale getirildi.

Bu haftanın ana sonucu:

> Rota verileri harita, yol tarifi, paylaşım ve rota kartı görünümü açısından kontrol edildi; kullanıcıya ham veri göstermek yerine daha anlaşılır Türkçe metadata sunma yönünde iyileştirmeler yapıldı.

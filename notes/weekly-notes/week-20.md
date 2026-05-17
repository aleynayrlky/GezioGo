# GezioGo – Hafta 20 Özeti

> Ana konu: Yeni mock rota ekleme, rota çeşitliliği, çoklu rota filtre/arama ve RouteDetailView testleri.

---

## 1. Haftanın Ana Amacı

20. haftada GezioGo’daki hazır rota deneyimi tek rotalı demo görünümünden çıkarılıp daha gerçekçi bir çoklu rota yapısına taşındı.

Önceki haftalarda rota listeleme, filtreleme, detay ekranı, harita, yol tarifi, paylaşım ve veri kalitesi tarafı geliştirilmişti. Bu hafta bu sistemleri daha iyi test edebilmek için `MockRoutes.json` içine yeni rotalar eklendi.

Hafta sonunda elimizde 3 mock rota olacak şekilde yapı genişletildi:

```text
1. Samsun’da 1 Günlük Tarih ve Sahil Rotası
2. Samsun Aile ve Doğa Rotası
3. Samsun Kültür ve Etkinlik Akşamı
```

Bu sayede şu alanlar daha gerçekçi test edilebilir hale geldi:

```text
RoutesView filtreleri
RoutesView arama sistemi
RouteCard metadata etiketleri
RouteDetailView çoklu rota davranışı
Mekan detay geçişleri
Etkinlik detay geçişleri
Harita pinleri
Yol tarifi
Paylaşım metni
Kaydedilen rotalar
```

---

## 2. Bu Hafta Yapılanlar

## Gün 1 – Mevcut Mock Veri Envanteri

Kontrol edilen dosyalar:

```text
Data/Mock/MockRoutes.json
Data/Mock/MockPlaces.json
Data/Mock/MockEvents.json
```

Yapılanlar:

- Mevcut mock rota sayısı kontrol edildi.
- Kullanılan mekanlar listelendi.
- Kullanılmayan mekanlar tespit edildi.
- Kullanılmayan etkinlikler tespit edildi.
- Yeni rota adayları belirlendi.

Mevcut rota:

```text
Samsun’da 1 Günlük Tarih ve Sahil Rotası
- Bandırma Vapuru Müzesi
- Atakum Sahili
```

Mevcut mekanlar:

```text
Bandırma Vapuru Müzesi - kullanılıyor
Atakum Sahili - kullanılıyor
Amazon Köyü - kullanılmıyor
```

Mevcut etkinlikler:

```text
Samsun Caz Festivali - kullanılmıyor
Sahil Yürüyüşü Etkinliği - kullanılmıyor
```

Yeni rota adayları:

```text
Samsun Aile ve Doğa Rotası
Samsun Kültür ve Etkinlik Akşamı
```

Günün sonucu:

> Yeni rota eklemeden önce mevcut mock veri envanteri çıkarıldı.

---

## Gün 2 – İkinci Rota: Samsun Aile ve Doğa Rotası

Güncellenen dosya:

```text
Data/Mock/MockRoutes.json
```

Eklenen rota:

```text
Samsun Aile ve Doğa Rotası
```

Duraklar:

```text
1. Amazon Köyü
2. Atakum Sahili
```

Rota özellikleri:

```text
durationType: half_day
budget: low
interests: nature, family, culture
transportType: mixed
companions: family
tempo: slow
totalDurationMinutes: 210
totalDistanceKm: 8.6
estimatedCostLevel: low
```

Bu rota ile test edilecek alanlar:

```text
Yarım Gün filtresi
Doğa filtresi
Aile filtresi
Kültür filtresi
Rahat tempo filtresi
Düşük bütçe etiketi
Amazon Köyü mekan detay geçişi
```

Günün sonucu:

> MockRoutes içine ikinci rota eklendi ve rota çeşitliliği artırıldı.

---

## Gün 3 – Üçüncü Rota: Samsun Kültür ve Etkinlik Akşamı

Güncellenen dosya:

```text
Data/Mock/MockRoutes.json
```

Eklenen rota:

```text
Samsun Kültür ve Etkinlik Akşamı
```

Duraklar:

```text
1. Atakum Sahili
2. Samsun Caz Festivali
```

Rota özellikleri:

```text
durationType: half_day
budget: medium
interests: culture, food_drink
transportType: mixed
companions: friends
tempo: balanced
totalDurationMinutes: 300
totalDistanceKm: 9.2
estimatedCostLevel: medium
```

Öne çıkan değişiklik:

```text
İlk kez type: event kullanılan rota durağı eklendi.
```

Event durağı:

```text
eventId: samsun-caz-festivali-2026
title: Samsun Caz Festivali
```

Bu rota ile test edilecek alanlar:

```text
Etkinlik detayını aç
Kültür filtresi
Yeme İçme filtresi
Yarım Gün filtresi
Dengeli tempo filtresi
Paylaşım metninde event durağı
```

Günün sonucu:

> MockRoutes içine üçüncü rota eklendi ve etkinlik detay geçişi gerçek veriyle test edilebilir hale geldi.

---

## Gün 4 – RoutesView Filtre Testleri

Kontrol edilen ekran:

```text
Features/Routes/RoutesView.swift
```

Test edilen filtreler:

```text
İlgi alanı filtresi
Süre filtresi
Ulaşım filtresi
Tempo filtresi
Sadece Kaydedilenler filtresi
Arama
```

Beklenen filtre sonuçları:

```text
Tarih → Samsun’da 1 Günlük Tarih ve Sahil Rotası
Doğa → Tarih/Sahil + Aile/Doğa
Aile → Samsun Aile ve Doğa Rotası
Kültür → Aile/Doğa + Kültür/Etkinlik
Yeme İçme → Tarih/Sahil + Kültür/Etkinlik
1 Gün → Tarih/Sahil
Yarım Gün → Aile/Doğa + Kültür/Etkinlik
Karma → 3 rota
Dengeli → Tarih/Sahil + Kültür/Etkinlik
Rahat → Aile/Doğa
```

Günün sonucu:

> 3 mock rota ile RoutesView filtrelerinin doğru sonuç üretmesi hedeflendi ve test planı çıkarıldı.

---

## Gün 5 – RouteCard Metadata ve Arama Testi

Kontrol edilen ekran / dosya:

```text
Features/Routes/Components/RouteCard.swift
Features/Routes/RoutesView.swift
```

Test edilen RouteCard metadata değerleri:

```text
Süre
Ulaşım
Tempo
Bütçe
Kaydedildi etiketi
```

Beklenen kart etiketleri:

```text
1. rota → 1 Gün / Karma / Dengeli / Orta
2. rota → Yarım Gün / Karma / Rahat / Düşük
3. rota → Yarım Gün / Karma / Dengeli / Orta
```

Test edilen arama kelimeleri:

```text
sahil
aile
caz
amazon
tarih
etkinlik
kültür
xyz
```

Beklenen arama davranışı:

```text
sahil → 3 rota çıkabilir
aile → Aile ve Doğa Rotası
caz → Kültür ve Etkinlik Akşamı
amazon → Aile ve Doğa Rotası
tarih → Tarih ve Sahil Rotası
etkinlik → Kültür ve Etkinlik Akşamı
kültür → Aile/Doğa + Kültür/Etkinlik
xyz → empty state
```

Günün sonucu:

> 3 mock rota ile RouteCard metadata ve RoutesView arama sistemi gerçekçi şekilde test edildi.

---

## Gün 6 – RouteDetailView Çoklu Rota Testi

Kontrol edilen ekran:

```text
Features/Routes/RouteDetailView.swift
```

Test edilen rotalar:

```text
Samsun’da 1 Günlük Tarih ve Sahil Rotası
Samsun Aile ve Doğa Rotası
Samsun Kültür ve Etkinlik Akşamı
```

Her rota için kontrol edilenler:

```text
RouteDetailView açılıyor mu?
Rota başlığı doğru mu?
Özet kartı doğru mu?
Harita pinleri doğru mu?
Durak listesi doğru sırada mı?
Mekan detay butonları doğru mu?
Etkinlik detay butonları doğru mu?
Yol tarifi al görünüyor mu?
Paylaşım metni doğru mu?
Rotayı Başlat doğru ilk durağı açıyor mu?
```

Özel test:

```text
Samsun Kültür ve Etkinlik Akşamı rotasında
Samsun Caz Festivali için “Etkinlik detayını aç” görünmeli.
```

Günün sonucu:

> 3 mock rota da RouteDetailView içinde harita, detay geçişleri, yol tarifi ve paylaşım akışlarıyla test edildi.

---

## Gün 7 – Haftalık Kontrol

Yapılanlar:

- MockRoutes içinde 3 rota olduğu kontrol edildi.
- İkinci rota olarak aile/doğa rotası eklendi.
- Üçüncü rota olarak kültür/etkinlik rotası eklendi.
- Event durağı ile etkinlik detay geçişi test edilebilir hale getirildi.
- RoutesView filtreleri için beklenen sonuçlar çıkarıldı.
- RouteCard metadata görünümü test edildi.
- RoutesView arama senaryoları test edildi.
- RouteDetailView çoklu rota senaryoları test edildi.
- Harita, yol tarifi, paylaşım ve detay geçişlerinin bozulmadığı kontrol edildi.
- `week-20.md` dosyası hazırlandı.

Günün sonucu:

> 20. hafta sonunda GezioGo rota sistemi tek rotalı demo yapısından çıkıp 3 rotalı, daha gerçekçi test edilebilir bir yapıya kavuştu.

---

## 3. Oluşan Ana Akışlar

### Çoklu Rota Listeleme Akışı

```text
MockRoutes.json
↓
MockDataService
↓
RoutesViewModel
↓
RoutesView
↓
RouteCard listesi
```

### Filtre Akışı

```text
RoutesView filtre chipleri
↓
RoutesViewModel selected filters
↓
filteredRoutes
↓
RouteCard sonuçları
```

### Arama Akışı

```text
SearchBarView
↓
searchText
↓
routeMatchesSearch
↓
Arama sonuçları
```

### Etkinlik Durak Akışı

```text
RouteStop type: event
↓
eventId
↓
RouteDetailViewModel.event(for:)
↓
Etkinlik detayını aç
↓
EventDetailView
```

### Çoklu Rota Detay Akışı

```text
RouteCard
↓
RouteDetailView
↓
Harita / Duraklar / Paylaş / Yol Tarifi
```

---

## 4. Bu Hafta Oluşan Dosyalar

Bu hafta yeni dosya oluşturulmadı.

Mevcut mock veri dosyası genişletildi:

```text
Data/Mock/MockRoutes.json
```

---

## 5. Bu Hafta Güncellenen / Kontrol Edilen Dosyalar

```text
Data/Mock/
└── MockRoutes.json

Features/Routes/
├── RoutesView.swift
├── RoutesViewModel.swift
└── RouteDetailView.swift

Features/Routes/Components/
└── RouteCard.swift
```

---

## 6. Teknik Kararlar

Bu hafta alınan teknik kararlar:

- RoutesView filtrelerini gerçekçi test etmek için en az 3 mock rota tutulacak.
- İkinci rota aile/doğa odaklı olacak.
- Üçüncü rota kültür/etkinlik odaklı olacak.
- Event detay geçişini test etmek için `type: event` içeren RouteStop kullanılacak.
- Yeni rota eklerken `id`, `order`, `type`, `placeId`, `eventId`, `latitude`, `longitude` alanları eksiksiz tutulacak.
- Rotaların `interests`, `durationType`, `tempo`, `transportType`, `budget` değerleri filtre testlerine uygun seçilecek.
- JSON dosyasında son elemandan sonra virgül bırakılmayacak.

---

## 7. Şu An Çalışan Özellikler

- RoutesView içinde 3 rota gösterilebilir.
- İlgi alanı filtreleri çoklu rota ile test edilebilir.
- Süre filtreleri çoklu rota ile test edilebilir.
- Ulaşım filtresi 3 rota üzerinde test edilebilir.
- Tempo filtresi farklı sonuçlar verebilir.
- Arama sistemi farklı kelimelerle test edilebilir.
- RouteCard farklı metadata değerleri gösterebilir.
- RouteDetailView her rota için açılabilir.
- Mekan detay geçişleri test edilebilir.
- Etkinlik detay geçişi test edilebilir.
- Harita pinleri farklı rotalarda test edilebilir.
- Paylaşım metni farklı rotalarda test edilebilir.

---

## 8. Bilinen Eksikler

Şu konular henüz yapılmadı:

- Daha fazla şehir için mock rota
- Daha fazla Samsun rotası
- Rota verileri için otomatik doğrulama script’i
- MockRoutes JSON testleri
- Event odaklı daha fazla rota
- Çok duraklı 3+ stop içeren rota
- Gerçek backend rota verisi
- Rota öneri algoritması
- AI rota üretimi

---

## 9. 21. Haftaya Hazırlık

21. haftanın önerilen ana konusu:

```text
Çoklu rota sonrası favoriler ve kaydedilen rotalar testi
```

Önerilen işler:

```text
1. 3 rota içinde kaydet/kayıttan çıkar davranışını test etme
2. FavoritesView içinde çoklu saved route gösterimini kontrol etme
3. Kaydedilen rotalarda paylaşım testleri
4. Kaydedilen rotalarda silme / çıkarma davranışı
5. RoutesView saved state güncelleniyor mu kontrol etme
6. SavedRoutesService çoklu rota davranışı
```

Alternatif konu:

```text
MockRoutes içine dördüncü rota ekleme
```

Ama önerilen öncelik:

> Çoklu rota eklendikten sonra kaydetme ve Favoriler akışını gerçekçi test etmek.

---

## 10. Kısa Sonuç

20. hafta sonunda GezioGo’da rota sayısı artırıldı ve mevcut rota sistemi daha gerçekçi veriyle test edilebilir hale geldi.

Bu haftanın ana sonucu:

> GezioGo artık tek rotalı demo görünümünden çıkıp tarih, doğa/aile ve kültür/etkinlik odaklı 3 farklı hazır rota sunan daha güçlü bir mock veri yapısına geçti.

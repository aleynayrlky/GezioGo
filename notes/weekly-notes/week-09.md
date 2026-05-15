# GezioGo – Hafta 09 Özeti

> Ana konu: Etkinlikler ekranı, etkinlik kartları, etkinlik detay ekranı ve Home bağlantıları.

---

## 1. Haftanın Ana Amacı

9. haftada GezioGo’nun etkinlik tarafı kurulmaya başlandı.

Önceki haftalarda mekan keşfi, favoriler, harita ve yol tarifi özellikleri geliştirilmişti. Bu hafta şehirdeki etkinliklerin de uygulama içinde listelenmesi ve detaylarının görüntülenmesi hedeflendi.

Hafta sonunda kullanıcı:

```text
Ana Sayfa’dan yaklaşan etkinlikleri görebilir.
Tüm etkinlikler ekranına geçebilir.
Etkinlik kartlarını inceleyebilir.
Etkinlik detay ekranına girebilir.
Etkinlik tarihi, saati, mekanı, ücreti, organizatörü ve konumunu görebilir.
Etkinlik konumu için Apple Maps yol tarifi alabilir.
```

---

## 2. Bu Hafta Yapılanlar

## Gün 1 – EventsView, EventsViewModel ve EventCard Başlangıcı

Oluşturulan dosyalar:

```text
Features/Events/
├── EventsView.swift
├── EventsViewModel.swift
└── Components/
    └── EventCard.swift
```

Yapılanlar:

- `Features/Events` klasörü oluşturuldu.
- `EventsViewModel` oluşturuldu.
- `MockDataService` üzerinden etkinlik verileri çekildi.
- `EventsView` oluşturuldu.
- Loading, error ve empty state yapıları eklendi.
- `EventCard` temel tasarımı oluşturuldu.
- Mock etkinlikler listelenebilir hale getirildi.

Günün sonucu:

> EventsView, mock etkinlikleri listeleyebilecek temel yapıya kavuştu.

---

## Gün 2 – EventCard Tasarımını Güçlendirme

Oluşturulan dosya:

```text
Utilities/Extensions/Date+Formatting.swift
```

Güncellenen dosya:

```text
Features/Events/Components/EventCard.swift
```

Yapılanlar:

- Tarih/saat formatlama için String extension eklendi.
- ISO tarih formatı kullanıcı dostu hale getirildi.
- `EventCard` tasarımı güçlendirildi.
- Tarih kutusu eklendi.
- Etkinlik saati, ücret tipi, mekan ve organizatör bilgileri daha okunabilir hale getirildi.

Günün sonucu:

> EventCard artık etkinlik tarihini ve saatini kullanıcıya okunabilir şekilde gösteriyor.

---

## Gün 3 – EventDetailView Başlangıcı

Oluşturulan dosyalar:

```text
Features/Events/
├── EventDetailView.swift
└── EventDetailViewModel.swift
```

Yapılanlar:

- EventDetailViewModel oluşturuldu.
- Etkinlik detay ekranı oluşturuldu.
- Etkinlik başlığı, kategori, açıklama, mekan, adres, tarih, saat, ücret ve organizatör bilgileri gösterildi.
- Etkinlik özellikleri ve etiketleri gösterildi.
- Konum bölümü hazırlandı.
- `PlaceInfoRow` component’i etkinlik detay ekranında tekrar kullanıldı.

Günün sonucu:

> Kullanıcı bir etkinliğin detaylarını görebileceği temel detay ekranına sahip oldu.

---

## Gün 4 – Events Navigation Bağlantıları

Güncellenen dosyalar:

```text
App/AppRoute.swift
App/MainTabBarView.swift
Features/Events/EventsView.swift
Features/Home/HomeView.swift
```

Yapılanlar:

- `AppRoute` içine `events(cityId:)` route’u eklendi.
- `AppRoute` içine `eventDetail(event:)` route’u eklendi.
- `MainTabBarView` içindeki destination helper etkinlik ekranlarını tanıyacak şekilde güncellendi.
- `EventsView` içindeki `EventCard` tıklanabilir hale getirildi.
- HomeView içinden EventsView’a geçiş eklendi.
- HomeView içindeki etkinlik satırlarından EventDetailView’a direkt geçiş eklendi.

Günün sonucu:

> Home → EventsView → EventDetailView akışı çalışır hale geldi.

---

## Gün 5 – EventDetailView İçine Harita / Yol Tarifi Bağlantısı

Güncellenen dosyalar:

```text
Services/Map/MapService.swift
Features/Events/EventDetailView.swift
Features/Events/EventDetailViewModel.swift
```

Yapılanlar:

- `MapService` hem mekan hem etkinlik koordinatlarıyla çalışacak şekilde genişletildi.
- `EventDetailViewModel` içine konum kontrolü eklendi.
- EventDetailView konum bölümü güncellendi.
- Koordinat varsa mini harita görseli ve “Yol Tarifi Al” butonu gösterildi.
- “Yol Tarifi Al” butonu Apple Maps’e bağlandı.

Günün sonucu:

> Kullanıcı etkinlik detayından Apple Maps ile yol tarifi alabilir hale geldi.

---

## Gün 6 – HomeView Etkinlik Alanını Güçlendirme

Oluşturulan dosya:

```text
Features/Home/Components/FeaturedEventCard.swift
```

Güncellenen dosya:

```text
Features/Home/HomeView.swift
```

Yapılanlar:

- Ana sayfadaki etkinlik alanı sadeleştirildi.
- `FeaturedEventCard` component’i oluşturuldu.
- HomeView etkinlik satırları bu component’i kullanacak şekilde güncellendi.
- “Tümünü Gör” butonu EventsView’a yönlendirmeye devam etti.
- Home’daki etkinlik kartları EventDetailView’a yönlendirmeye devam etti.

Günün sonucu:

> HomeView’daki etkinlik alanı daha temiz, tekrar kullanılabilir ve okunabilir hale geldi.

---

## Gün 7 – Haftalık Kontrol

Yapılanlar:

- EventsView test edildi.
- EventCard tasarımı kontrol edildi.
- EventDetailView test edildi.
- Home → EventsView geçişi kontrol edildi.
- Home → EventDetailView direkt geçişi kontrol edildi.
- EventDetailView Apple Maps yol tarifi bağlantısı test edildi.
- GitHub dosya yapısı kontrol edildi.
- `week-09.md` dosyası hazırlandı.

Günün sonucu:

> 9. hafta sonunda etkinlik listeleme ve etkinlik detay akışı tamamlandı.

---

## 3. Oluşan Ana Akışlar

### Events Akışı

```text
HomeView
↓
Tümünü Gör
↓
EventsView
↓
EventCard
↓
EventDetailView
```

### Direkt Home Etkinlik Akışı

```text
HomeView
↓
FeaturedEventCard
↓
EventDetailView
```

### Event Yol Tarifi Akışı

```text
EventDetailView
↓
Yol Tarifi Al
↓
MapService
↓
Apple Maps
```

---

## 4. Bu Hafta Oluşan Dosyalar

```text
Features/Events/
├── EventsView.swift
├── EventsViewModel.swift
├── EventDetailView.swift
├── EventDetailViewModel.swift
└── Components/
    └── EventCard.swift

Features/Home/Components/
└── FeaturedEventCard.swift

Utilities/Extensions/
└── Date+Formatting.swift
```

---

## 5. Bu Hafta Güncellenen Dosyalar

```text
App/AppRoute.swift
App/MainTabBarView.swift
Features/Home/HomeView.swift
Services/Map/MapService.swift
```

---

## 6. Teknik Kararlar

Bu hafta alınan teknik kararlar:

- Etkinlikler ayrı bir `Features/Events` modülü altında tutulacak.
- Etkinlikler şimdilik tab bar’a ayrı sekme olarak eklenmeyecek.
- Etkinlik akışı HomeView üzerinden açılacak.
- Etkinlik detay ekranı mekan detay ekranına benzer bilgi yapısı kullanacak.
- Tarihler için `String` extension ile formatlama yapılacak.
- Etkinlik detayında `PlaceInfoRow` tekrar kullanılacak.
- Etkinlik yol tarifi için mevcut `MapService` genişletilecek.
- Gerçek bilet entegrasyonu sonraya bırakılacak.

---

## 7. Şu An Çalışan Özellikler

- Ana sayfada yaklaşan etkinlikler
- Ana sayfadan tüm etkinliklere geçiş
- Ana sayfadan etkinlik detayına direkt geçiş
- EventsView etkinlik listeleme
- EventCard tarih ve saat gösterimi
- EventDetailView
- Etkinlik bilgileri
- Etkinlik konum bilgisi
- Etkinlik için Apple Maps yol tarifi
- Loading / empty / error state kullanımı

---

## 8. Bilinen Eksikler

Şu konular henüz yapılmadı:

- Etkinlik favorileme
- Etkinlikleri takvime ekleme
- Bilet linkini açma
- Event image görselleri
- Etkinlik arama / filtreleme
- Kategoriye göre etkinlik filtreleme
- Tarihe göre sıralama
- Etkinlikleri haritada gösterme
- Gerçek etkinlik API bağlantısı
- Firebase etkinlik verisi
- Push notification / etkinlik hatırlatıcı

---

## 9. 10. Haftaya Hazırlık

10. haftanın önerilen ana konusu:

```text
Arama ve filtreleme sistemi
```

Önerilen işler:

```text
1. ExploreView içinde arama alanı
2. PlaceListView içinde kategori ve metin filtreleme
3. EventsView içinde etkinlik arama
4. Etkinlik kategori filtreleri
5. Empty state iyileştirmeleri
6. SearchBar component’i
```

Alternatif konu:

```text
Etkinlik favorileme + takvime ekleme
```

Ama önerilen öncelik:

> Arama ve filtreleme sistemi

---

## 10. Kısa Sonuç

9. hafta sonunda GezioGo, mekan keşfi dışında şehir etkinliklerini de gösterebilir hale geldi.

Bu haftanın ana sonucu:

> Kullanıcı artık şehirdeki etkinlikleri listeleyebilir, etkinlik detaylarını inceleyebilir ve etkinlik konumu için Apple Maps üzerinden yol tarifi alabilir.

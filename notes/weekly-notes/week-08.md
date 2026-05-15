# GezioGo – Hafta 08 Özeti

> Ana konu: Favori sistemi entegrasyonu, MapKit başlangıcı, harita pinleri ve Apple Maps yol tarifi bağlantısı.

---

## 1. Haftanın Ana Amacı

8. haftada GezioGo’da iki temel özellik gerçek işlev kazandı:

```text
Favoriler
Harita
```

7. haftada Favoriler ve Harita sekmeleri oluşturulmuştu. 8. haftada bu sekmelerin altyapısı güçlendirildi ve kullanıcı etkileşimi eklendi.

Hafta sonunda kullanıcı:

```text
Mekan detayından favoriye ekleme/çıkarma yapabilir.
Favoriler tabında kaydettiği mekanları görebilir.
Harita tabında mekanları Apple Map üzerinde pin olarak görebilir.
Pin seçerek mekan kartını görüntüleyebilir.
Mekan detayından Apple Maps ile yol tarifi alabilir.
```

---

## 2. Bu Hafta Yapılanlar

## Gün 1 – PlaceDetailView İçine Favori Butonu

Güncellenen dosyalar:

```text
Features/PlaceDetail/PlaceDetailView.swift
Features/PlaceDetail/PlaceDetailViewModel.swift
```

Yapılanlar:

- `PlaceDetailViewModel` içine `FavoritesService` eklendi.
- `isFavorite` state’i oluşturuldu.
- `toggleFavorite()` fonksiyonu yazıldı.
- Favori duruma göre kalp ikonu dolu/boş gösterildi.
- `PlaceDetailView` sağ üstüne favori butonu eklendi.
- Favori olan mekanlarda “Favorilerde” etiketi gösterildi.

Günün sonucu:

> Kullanıcı mekan detay ekranından favoriye ekleme ve favoriden çıkarma yapabilir hale geldi.

---

## Gün 2 – FavoritesView Gerçek Favorileri Güncel Gösteriyor

Güncellenen dosyalar:

```text
Services/Favorites/FavoritesService.swift
Features/Favorites/FavoritesViewModel.swift
Features/Favorites/FavoritesView.swift
```

Yapılanlar:

- `FavoritesService` içinde `favoritesDidChange` notification yapısı eklendi.
- Favori değişikliklerinde `NotificationCenter` ile uygulamaya haber verildi.
- `FavoritesViewModel` içine `refreshFavorites()` eklendi.
- `FavoritesView` her görünür olduğunda favorileri yenileyecek hale getirildi.
- Favoriler ekranında gerçek favori mekanlar gösterildi.
- Favoriden çıkarma işlemi eklendi.
- Tüm favorileri temizleme butonu eklendi.

Günün sonucu:

> Favoriler tabı gerçek favori verisini okuyup güncel olarak gösterebilir hale geldi.

---

## Gün 3 – Kartlarda Favori Durumunu Gösterme

Oluşturulan dosya:

```text
DesignSystem/Components/FavoriteBadge.swift
```

Güncellenen dosyalar:

```text
Features/Explore/Components/PlaceCard.swift
Features/Home/Components/FeaturedPlaceCard.swift
Features/Favorites/FavoritesView.swift
```

Yapılanlar:

- `FavoriteBadge` component’i oluşturuldu.
- `PlaceCard` içine `isFavorite` parametresi eklendi.
- `FeaturedPlaceCard` içine `isFavorite` parametresi eklendi.
- Favori kartlarda dolu kalp gösterimi hazırlandı.
- Favoriler tabındaki kartlar `isFavorite: true` ile gösterildi.
- Favori mekan kartlarında “Favorilerde” etiketi gösterildi.

Günün sonucu:

> Mekan kartları favori durumunu görsel olarak gösterebilecek altyapıya kavuştu.

---

## Gün 4 – MapKit Temel Harita Gösterimi

Güncellenen dosyalar:

```text
Features/Map/MapExploreView.swift
Features/Map/MapExploreViewModel.swift
```

Yapılanlar:

- `MapKit` projeye dahil edildi.
- `MapExploreViewModel` içine `MKCoordinateRegion` eklendi.
- Harita başlangıç konumu Samsun merkezli ayarlandı.
- Dekoratif harita önizleme alanı gerçek SwiftUI `Map` component’i ile değiştirildi.
- `MapCameraPosition` yerine daha uyumlu `MKCoordinateRegion` yapısı kullanıldı.
- Harita altında mekan listesi korunmaya devam etti.

Günün sonucu:

> Harita tabı gerçek Apple Map göstermeye başladı.

---

## Gün 5 – Haritada Mekan Pinleri

Güncellenen dosyalar:

```text
Features/Map/MapExploreView.swift
Features/Map/MapExploreViewModel.swift
```

Yapılanlar:

- `selectedPlace` state’i eklendi.
- `selectPlace(_:)` fonksiyonu oluşturuldu.
- Mock mekanların latitude/longitude değerleri pin olarak haritaya eklendi.
- Pinlere tıklama desteği eklendi.
- Seçilen pin görsel olarak farklılaştırıldı.
- Haritanın altında seçili mekan kartı gösterildi.
- Seçili mekan kartından `PlaceDetailView` açıldı.

Günün sonucu:

> Haritada mekan pinleri görünüyor ve pin seçimiyle mekan detayına geçiş yapılabiliyor.

---

## Gün 6 – Apple Maps Yol Tarifi Bağlantısı

Oluşturulan dosya:

```text
Services/Map/MapService.swift
```

Güncellenen dosya:

```text
Features/PlaceDetail/PlaceDetailView.swift
```

Yapılanlar:

- `MapService` oluşturuldu.
- `openDirections(to:)` fonksiyonu yazıldı.
- `MKMapItem` ve `MKPlacemark` ile Apple Maps bağlantısı kuruldu.
- `PlaceDetailView` içindeki “Yol Tarifi Al” butonu gerçek aksiyona bağlandı.
- Butona basınca Apple Maps açılacak hale getirildi.

Günün sonucu:

> Kullanıcı mekan detay ekranından Apple Maps üzerinden yol tarifi alabilir hale geldi.

---

## Gün 7 – Haftalık Kontrol

Yapılanlar:

- Favoriye ekleme/çıkarma test edildi.
- Favoriler tabı güncel listeleme açısından kontrol edildi.
- Favori kartlarının görsel durumu test edildi.
- MapKit haritası test edildi.
- Harita pinleri ve seçili mekan kartı kontrol edildi.
- Apple Maps yol tarifi bağlantısı test edildi.
- GitHub dosya yapısı kontrol edildi.
- `week-08.md` dosyası hazırlandı.

Günün sonucu:

> 8. hafta sonunda favoriler ve harita özellikleri temel seviyede çalışır hale geldi.

---

## 3. Oluşan Ana Akışlar

### Favori Akışı

```text
PlaceDetailView
↓
Favori butonu
↓
FavoritesService
↓
UserDefaults
↓
FavoritesView
```

### Harita Akışı

```text
MapExploreView
↓
Apple Map
↓
Mekan pinleri
↓
Seçili mekan kartı
↓
PlaceDetailView
```

### Yol Tarifi Akışı

```text
PlaceDetailView
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
DesignSystem/Components/
└── FavoriteBadge.swift

Services/Map/
└── MapService.swift
```

---

## 5. Bu Hafta Güncellenen Dosyalar

```text
Services/Favorites/FavoritesService.swift

Features/PlaceDetail/
├── PlaceDetailView.swift
└── PlaceDetailViewModel.swift

Features/Favorites/
├── FavoritesView.swift
└── FavoritesViewModel.swift

Features/Explore/Components/
└── PlaceCard.swift

Features/Home/Components/
└── FeaturedPlaceCard.swift

Features/Map/
├── MapExploreView.swift
└── MapExploreViewModel.swift
```

---

## 6. Teknik Kararlar

Bu hafta alınan teknik kararlar:

- Favoriler ilk aşamada `UserDefaults` ile saklanacak.
- Favori değişiklikleri `NotificationCenter` ile bildirilecek.
- `FavoritesView` her görünür olduğunda favorileri yenileyecek.
- Kartlarda favori durumu `FavoriteBadge` ile gösterilecek.
- Harita için `MapKit` kullanılacak.
- Daha uyumlu yapı için `MapCameraPosition` yerine `MKCoordinateRegion` kullanılacak.
- Mekan pinleri mock JSON’daki `latitude` ve `longitude` değerlerinden üretilecek.
- Yol tarifi için Apple Maps, `MKMapItem.openInMaps` ile açılacak.
- Konum izni bu aşamada gerekmiyor çünkü kullanıcının mevcut konumu alınmıyor.

---

## 7. Şu An Çalışan Özellikler

- Mekan detayından favoriye ekleme
- Mekan detayından favoriden çıkarma
- Favori durumunun kalıcı saklanması
- Favoriler tabında gerçek favori mekanları gösterme
- Favorilerden çıkarma
- Favori kartlarında dolu kalp gösterimi
- Gerçek Apple Map gösterimi
- Harita üzerinde mekan pinleri
- Pin seçimi
- Seçili mekan kartı
- Haritadan mekan detayına geçiş
- Mekan detayından Apple Maps yol tarifi açma

---

## 8. Bilinen Eksikler

Şu konular henüz yapılmadı:

- Home ve Explore kartlarında favori durumunu otomatik güncel gösterme
- Kart üzerinden direkt favoriye ekleme/çıkarma
- Harita pin tasarımının son hali
- Harita alt sheet tasarımı
- Kullanıcının mevcut konumunu alma
- Yürüyüş/toplu taşıma rota seçimi
- Etkinlik detay ekranı
- Etkinlikleri favoriye ekleme
- Firebase ile kullanıcı bazlı favoriler
- Çoklu şehirde harita merkezi değiştirme
- Gelişmiş filtreleme
- Arama sistemi

---

## 9. 9. Haftaya Hazırlık

9. haftanın önerilen ana konusu:

```text
Etkinlikler ekranı + Etkinlik detay ekranı
```

Çünkü şu ana kadar mekan keşfi güçlendi. Artık etkinlik tarafının da gerçek ekranlara kavuşması gerekiyor.

Önerilen işler:

```text
Features/Events/
├── EventsView.swift
├── EventsViewModel.swift
├── EventDetailView.swift
└── Components/
    └── EventCard.swift
```

Alternatif olarak 9. hafta şu konuya ayrılabilir:

```text
Arama ve filtreleme sistemi
```

Ama önerilen öncelik:

> Etkinlikler

---

## 10. Kısa Sonuç

8. hafta sonunda GezioGo’da Favoriler ve Harita özellikleri temel seviyede çalışır hale geldi.

Bu haftanın ana sonucu:

> Kullanıcı artık mekanları favorilerine kaydedebilir, favorilerini görebilir, mekanları haritada pin olarak inceleyebilir ve mekan detayından Apple Maps ile yol tarifi alabilir.

# GezioGo – Hafta 15 Özeti

> Ana konu: Rota detayında Apple Maps yol tarifi aksiyonları, rota başlatma, seçili durak ve durak listesi üzerinden yönlendirme.

---

## 1. Haftanın Ana Amacı

15. haftada GezioGo’nun rota detay ekranı yalnızca rota gösteren bir yapıdan, kullanıcının gerçekten yola çıkmasını sağlayan bir yapıya dönüştürüldü.

Önceki haftalarda rota listeleme, rota detay ekranı, harita görünümü, rota kaydetme ve filtreleme sistemleri tamamlanmıştı. Bu hafta kullanıcının rota duraklarına Apple Maps üzerinden yol tarifi alabilmesi hedeflendi.

Hafta sonunda kullanıcı:

```text
RouteDetailView içinde Rotayı Başlat kartını görebilir.
İlk koordinatlı durağa Apple Maps ile yol tarifi alabilir.
Harita altında seçili durak kartından yol tarifi alabilir.
Rota durakları listesinden herhangi bir durağa yol tarifi alabilir.
Koordinatı olmayan duraklarda yol tarifi butonu görmez.
Mekan/Etkinlik detayına geçişleri kullanmaya devam edebilir.
```

---

## 2. Bu Hafta Yapılanlar

## Gün 1 – MapService RouteStop Desteği

Güncellenen dosya:

```text
Services/Map/MapService.swift
```

Yapılanlar:

- Mevcut `MapService` yapısı korundu.
- `RouteStop` için yol tarifi desteği eklendi.
- `canOpenDirections(for stop:)` fonksiyonu eklendi.
- `openDirections(to stop:)` fonksiyonu eklendi.
- RouteStop koordinatları yoksa güvenli şekilde return yapılması sağlandı.
- RouteStop yönlendirmelerinde Apple Maps yürüyüş modu kullanılacak şekilde düzenlendi.
- Place yönlendirmelerinde mevcut driving modu korundu.

Günün sonucu:

> MapService, RouteStop koordinatı varsa Apple Maps yol tarifi açabilecek hale geldi.

---

## Gün 2 – RouteDetailViewModel Yol Tarifi Helper’ları

Güncellenen dosya:

```text
Features/Routes/RouteDetailViewModel.swift
```

Yapılanlar:

- `RouteDetailViewModel` içine `MapService` dependency’si eklendi.
- `firstNavigableStop` computed property’si eklendi.
- `selectedStopCanOpenDirections` computed property’si eklendi.
- `canOpenDirections(for:)` helper fonksiyonu eklendi.
- `openDirections(for:)` helper fonksiyonu eklendi.
- `startRoute()` fonksiyonu eklendi.
- İlk koordinatlı durak bulunarak rota başlatma altyapısı hazırlandı.

Günün sonucu:

> RouteDetailViewModel, koordinatı olan RouteStop için Apple Maps yol tarifi başlatabilecek altyapıya sahip oldu.

---

## Gün 3 – RouteDetailView İçine Rotayı Başlat Butonu

Güncellenen dosya:

```text
Features/Routes/RouteDetailView.swift
```

Yapılanlar:

- `RouteDetailView` içine `routeActionSection` eklendi.
- Hero alanı ile özet alanı arasına “Rotayı başlat” kartı yerleştirildi.
- Kartta ilk gidilebilir durak adı gösterildi.
- `viewModel.firstNavigableStop` kullanıldı.
- `viewModel.startRoute()` butona bağlandı.
- Koordinat yoksa Rotayı Başlat kartının görünmemesi sağlandı.
- Apple Maps ile ilk uygun durağa yol tarifi açma davranışı eklendi.

Günün sonucu:

> Kullanıcı RouteDetailView içinden rotayı Apple Maps ile başlatabilir hale geldi.

---

## Gün 4 – SelectedRouteStopCard İçine Yol Tarifi Al Butonu

Güncellenen dosyalar:

```text
Features/Routes/Components/SelectedRouteStopCard.swift
Features/Routes/RouteDetailView.swift
```

Yapılanlar:

- `SelectedRouteStopCard` içine `canOpenDirections` parametresi eklendi.
- `SelectedRouteStopCard` içine `openDirections` closure’ı eklendi.
- Seçili durak kartında “Yol tarifi al” butonu gösterildi.
- Koordinat yoksa yol tarifi butonunun gizlenmesi sağlandı.
- `RouteDetailView` içindeki `SelectedRouteStopCard` çağrısı güncellendi.
- Seçili duraktan Apple Maps açma davranışı eklendi.

Günün sonucu:

> Harita altında seçili durak kartından Apple Maps yol tarifi alınabilir hale geldi.

---

## Gün 5 – Durak Listesi Kartlarına Yol Tarifi Al Butonu

Güncellenen dosya:

```text
Features/Routes/RouteDetailView.swift
```

Yapılanlar:

- `stopCard(_:)` fonksiyonu güncellendi.
- `canOpenDirections` kontrolü durak kartlarına eklendi.
- Koordinatı olan duraklarda “Yol tarifi al” butonu gösterildi.
- Koordinatı olmayan duraklarda yol tarifi butonu gizlendi.
- Mekan/Etkinlik detay butonları korunarak aynı kartta gösterildi.
- “Detay var” etiketi “Aksiyon var” olarak güncellendi.
- Durak listesi üzerinden Apple Maps yönlendirmesi desteklendi.

Günün sonucu:

> RouteDetailView içindeki durak listesi kartlarından Apple Maps yol tarifi alınabilir hale geldi.

---

## Gün 6 – Yol Tarifi Aksiyonları UI Temizliği ve Güvenli Durumlar

Güncellenen dosyalar:

```text
Features/Routes/RouteDetailView.swift
Features/Routes/Components/SelectedRouteStopCard.swift
Services/Map/MapService.swift
```

Yapılanlar:

- Rotayı Başlat kartının açıklama metni netleştirildi.
- “Rotayı Apple Maps’te başlat” buton metni düzenlendi.
- Durak kartlarındaki aksiyonlar `Divider()` ile daha okunabilir hale getirildi.
- SelectedRouteStopCard içindeki aksiyonlar `Divider()` ile ayrıldı.
- Koordinatsız duraklarda yol tarifi butonunun gizlenmesi kontrol edildi.
- Place yönlendirmesinde driving, RouteStop yönlendirmesinde walking modunun korunması sağlandı.
- Detay bağlantılarının bozulmadığı kontrol edildi.

Günün sonucu:

> RouteDetailView içindeki yol tarifi aksiyonları daha temiz, güvenli ve anlaşılır hale getirildi.

---

## Gün 7 – Haftalık Kontrol

Yapılanlar:

- MapService RouteStop desteği kontrol edildi.
- RouteDetailViewModel direction helper’ları kontrol edildi.
- Rotayı Başlat kartı test edildi.
- İlk koordinatlı durağa Apple Maps açılması test edildi.
- SelectedRouteStopCard içinden yol tarifi alma test edildi.
- Durak listesi kartlarından yol tarifi alma test edildi.
- Koordinatı olmayan duraklarda butonun gizlenmesi kontrol edildi.
- Mekan/Etkinlik detay geçişleri kontrol edildi.
- GitHub dosya yapısı kontrol edildi.
- `week-15.md` dosyası hazırlandı.

Günün sonucu:

> 15. hafta sonunda rota detay ekranı Apple Maps yol tarifi aksiyonlarıyla tamamlandı.

---

## 3. Oluşan Ana Akışlar

### Rotayı Başlat Akışı

```text
RouteDetailView
↓
Rotayı Başlat kartı
↓
firstNavigableStop
↓
MapService.openDirections(to: RouteStop)
↓
Apple Maps
```

### Seçili Duraktan Yol Tarifi Akışı

```text
RouteDetailView
↓
RouteMapView pin seçimi
↓
SelectedRouteStopCard
↓
Yol tarifi al
↓
Apple Maps
```

### Durak Listesinden Yol Tarifi Akışı

```text
RouteDetailView
↓
Rota durakları
↓
StopCard
↓
Yol tarifi al
↓
Apple Maps
```

### Detay Bağlantısı Akışı

```text
StopCard / SelectedRouteStopCard
↓
Mekan detayını aç veya Etkinlik detayını aç
↓
PlaceDetailView veya EventDetailView
```

---

## 4. Bu Hafta Oluşan Dosyalar

Bu hafta yeni dosya oluşturulmadı.

Mevcut dosyalar geliştirildi:

```text
Services/Map/MapService.swift
Features/Routes/RouteDetailView.swift
Features/Routes/RouteDetailViewModel.swift
Features/Routes/Components/SelectedRouteStopCard.swift
```

---

## 5. Bu Hafta Güncellenen Dosyalar

```text
Services/Map/
└── MapService.swift

Features/Routes/
├── RouteDetailView.swift
└── RouteDetailViewModel.swift

Features/Routes/Components/
└── SelectedRouteStopCard.swift
```

---

## 6. Teknik Kararlar

Bu hafta alınan teknik kararlar:

- Rota durakları için Apple Maps yönlendirmesi `MapService` üzerinden yönetilecek.
- RouteStop yönlendirmelerinde yürüyüş modu kullanılacak.
- Place yönlendirmelerinde mevcut driving modu korunacak.
- Koordinatı olmayan duraklarda yol tarifi butonu gösterilmeyecek.
- Rotayı Başlat davranışı ilk koordinatlı durağı hedef alacak.
- Seçili durak kartı ve durak listesi aynı yönlendirme helper’larını kullanacak.
- Yol tarifi aksiyonları RouteDetailViewModel üzerinden tetiklenecek.
- UI tarafında çalışmayacak buton gösterilmemesine dikkat edilecek.

---

## 7. Şu An Çalışan Özellikler

- RouteStop için Apple Maps yol tarifi
- Rotayı Başlat kartı
- İlk koordinatlı durağa yol tarifi
- Seçili duraktan yol tarifi
- Durak listesinden yol tarifi
- Koordinatsız durakta buton gizleme
- Mekan detayına geçiş
- Etkinlik detayına geçiş
- Place yönlendirme davranışının korunması
- RouteStop yönlendirmede yürüyüş modu

---

## 8. Bilinen Eksikler

Şu konular henüz yapılmadı:

- Duraklar arası polyline çizimi
- Apple Maps’te tüm durakları çoklu rota olarak açma
- Gerçek rota optimizasyonu
- Kullanıcı konumundan ilk durağa mesafe gösterme
- Canlı konum takibi
- Adım adım uygulama içi navigasyon
- Harita üzerinde rota çizgisi
- Alternatif ulaşım modu seçimi
- Toplu taşıma yönlendirmesi
- Rota aksiyonlarını ayrı component’e taşıma

---

## 9. 16. Haftaya Hazırlık

16. haftanın önerilen ana konusu:

```text
Rota paylaşma ve rota özet aksiyonları
```

Önerilen işler:

```text
1. RouteDetailView içine Paylaş butonu ekleme
2. Rota başlığı, durak listesi ve süre bilgisinden paylaşım metni oluşturma
3. ShareLink veya UIActivityViewController kullanımı
4. Rota durak listesini metin olarak paylaşma
5. Kaydedilen rotalarda paylaşım desteği
6. Rota aksiyon butonlarını toparlama
7. Rota detay UI aksiyonlarını sadeleştirme
```

Alternatif konu:

```text
Rota polyline / harita çizgisi
```

Ama önerilen öncelik:

> Rota paylaşma ve rota özet aksiyonları

---

## 10. Kısa Sonuç

15. hafta sonunda GezioGo’da rota detay ekranı gerçek kullanım aksiyonları kazandı.

Bu haftanın ana sonucu:

> Kullanıcı artık rotayı yalnızca incelemekle kalmaz; rotayı başlatabilir, seçili durağa veya listedeki herhangi bir durağa Apple Maps üzerinden yol tarifi alabilir.

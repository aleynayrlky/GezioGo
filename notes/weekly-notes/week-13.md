# GezioGo – Hafta 13 Özeti

> Ana konu: Rota kaydetme sistemi, kaydedilen rotaların RoutesView ve FavoritesView içinde gösterilmesi, kayıt durumlarının senkronize edilmesi.

---

## 1. Haftanın Ana Amacı

13. haftada GezioGo’nun rota sistemi kullanıcı etkileşimi kazanacak şekilde geliştirildi.

Önceki haftalarda hazır rota ekranı, rota detay ekranı, rota harita görünümü ve rota durakları oluşturulmuştu. Bu hafta kullanıcıların beğendikleri rotaları kaydedebilmesi ve daha sonra Favoriler ekranından tekrar ulaşabilmesi hedeflendi.

Hafta sonunda kullanıcı:

```text
RouteDetailView içinden rotayı kaydedebilir.
Kaydedilmiş rotayı tekrar kayıttan çıkarabilir.
RoutesView kartlarında kayıt durumunu görebilir.
Favoriler ekranında kaydedilen rotalarını görebilir.
Kaydedilen rotadan RouteDetailView’a geçebilir.
Favoriler ekranından kaydedilen rotayı kaldırabilir.
```

---

## 2. Bu Hafta Yapılanlar

## Gün 1 – SavedRoutesService Oluşturma

Oluşturulan dosya:

```text
Services/Routes/
└── SavedRoutesService.swift
```

Yapılanlar:

- `SavedRoutesService` oluşturuldu.
- Kaydedilen rota id’leri `UserDefaults` içinde saklanacak hale getirildi.
- `savedRouteIds` okuma desteği eklendi.
- `isSaved(routeId:)` fonksiyonu eklendi.
- `save(routeId:)` fonksiyonu eklendi.
- `remove(routeId:)` fonksiyonu eklendi.
- `toggle(routeId:)` fonksiyonu eklendi.
- `clearAll()` fonksiyonu eklendi.
- `savedRoutesDidChange` notification altyapısı oluşturuldu.

Günün sonucu:

> Rota id’lerini local olarak kaydedebilecek servis altyapısı hazırlandı.

---

## Gün 2 – RouteDetailView İçine Kaydet Butonu

Güncellenen dosyalar:

```text
Features/Routes/RouteDetailView.swift
Features/Routes/RouteDetailViewModel.swift
```

Yapılanlar:

- `RouteDetailViewModel` içine `isSaved` state’i eklendi.
- `SavedRoutesService` ViewModel’e bağlandı.
- `toggleSaved()` fonksiyonu eklendi.
- `refreshSavedState()` fonksiyonu eklendi.
- `RouteDetailView` toolbar alanına bookmark butonu eklendi.
- Kaydedilmiş rota için `bookmark.fill` ikonu gösterildi.
- Kaydedilmiş rota için hero bölümünde “Kaydedildi” etiketi gösterildi.

Günün sonucu:

> Kullanıcı RouteDetailView içinden rotayı kaydedip kayıttan çıkarabilir hale geldi.

---

## Gün 3 – RouteCard Kayıt Durumunu Göstersin

Güncellenen dosyalar:

```text
Features/Routes/Components/RouteCard.swift
Features/Routes/RoutesView.swift
Features/Routes/RoutesViewModel.swift
```

Yapılanlar:

- `RoutesViewModel` içine `savedRouteIds` eklendi.
- `SavedRoutesService` RoutesViewModel’e bağlandı.
- `refreshSavedRoutes()` fonksiyonu oluşturuldu.
- `isSaved(_:)` helper fonksiyonu eklendi.
- `RouteCard` içine `isSaved` parametresi eklendi.
- Kaydedilmiş rotalarda bookmark ikonu gösterildi.
- Kaydedilmiş rotalarda “Kaydedildi” etiketi gösterildi.
- `RoutesView` kartlara kayıt durumunu gönderecek şekilde güncellendi.
- RoutesView görünür olduğunda kayıt durumunun yenilenmesi sağlandı.

Günün sonucu:

> RoutesView içindeki rota kartları, rotanın kaydedilip kaydedilmediğini gösterebilir hale geldi.

---

## Gün 4 – FavoritesView İçine Kaydedilen Rotalar Bölümü

Güncellenen dosyalar:

```text
Features/Favorites/FavoritesView.swift
Features/Favorites/FavoritesViewModel.swift
```

Yapılanlar:

- `FavoritesViewModel` içine `savedRoutes` state’i eklendi.
- `SavedRoutesService` FavoritesViewModel’e bağlandı.
- `refreshSavedRoutes()` fonksiyonu oluşturuldu.
- `refreshAllFavorites()` fonksiyonu eklendi.
- `FavoritesView` içine “Kaydedilen rotalar” bölümü eklendi.
- Kaydedilen rotalar `RouteCard` ile listelendi.
- Kaydedilen rota yoksa empty state gösterildi.
- Kaydedilen rota kartından RouteDetailView’a geçiş eklendi.
- `savedRoutesDidChange` notification dinlenerek liste güncel tutuldu.

Günün sonucu:

> Favoriler ekranında kaydedilen rotalar listelenebilir ve detay ekranına gidilebilir hale geldi.

---

## Gün 5 – FavoritesView → RouteDetailView Bağlantısını Güçlendirme

Güncellenen dosyalar:

```text
Features/Favorites/FavoritesView.swift
Features/Favorites/FavoritesViewModel.swift
```

Yapılanlar:

- `FavoritesViewModel` içine `removeSavedRoute(_:)` fonksiyonu eklendi.
- Kaydedilen rota kartlarında context menu desteği eklendi.
- Kaydedilen rotayı Favoriler ekranından kaldırma desteği eklendi.
- Başlangıçta swipeActions denenerek hızlı kaldırma davranışı planlandı.
- Uygulama yapısına daha uyumlu olduğu için uzun basma/context menu yöntemi tercih edildi.

Günün sonucu:

> Favoriler ekranındaki kaydedilen rota kartından RouteDetailView’a gidilebilir ve rota kaydedilenlerden kaldırılabilir hale geldi.

---

## Gün 6 – Kayıt Durumu Senkronizasyonu ve UI Temizliği

Güncellenen dosyalar:

```text
Features/Routes/RouteDetailView.swift
Features/Routes/RoutesView.swift
Features/Favorites/FavoritesView.swift
Features/Routes/Components/RouteCard.swift
```

Yapılanlar:

- `RouteDetailView` kayıt değişikliklerini dinleyecek şekilde kontrol edildi.
- `RoutesView` kayıt durumunu görünür olduğunda yenileyecek şekilde kontrol edildi.
- `FavoritesView` `savedRoutesDidChange` bildirimiyle kaydedilen rotaları yenileyecek şekilde düzenlendi.
- RouteCard’da kayıt durumu görünümü sadeleştirildi.
- Favoriler ekranındaki silme butonu metni daha doğru hale getirildi.
- Kaydedilen rota kaldırma işlemi için context menu kullanımı netleştirildi.

Günün sonucu:

> Rota kaydetme/kaldırma durumu RoutesView, RouteDetailView ve FavoritesView arasında daha tutarlı hale getirildi.

---

## Gün 7 – Haftalık Kontrol

Yapılanlar:

- SavedRoutesService test edildi.
- RouteDetailView kaydet/kaldır butonu test edildi.
- RoutesView kartlarında kayıt durumu kontrol edildi.
- Favoriler ekranında kaydedilen rotalar kontrol edildi.
- Kaydedilen rota kartından RouteDetailView açılması test edildi.
- Favoriler ekranında uzun basma ile “Kaydedilenlerden çıkar” davranışı test edildi.
- Kaydı kaldırınca listelerin güncellenmesi kontrol edildi.
- GitHub dosya yapısı kontrol edildi.
- `week-13.md` dosyası hazırlandı.

Günün sonucu:

> 13. hafta sonunda rota kaydetme sistemi temel seviyede tamamlandı.

---

## 3. Oluşan Ana Akışlar

### Rota Kaydetme Akışı

```text
RouteDetailView
↓
Bookmark butonu
↓
SavedRoutesService.toggle(routeId:)
↓
UserDefaults
↓
savedRoutesDidChange
```

### RoutesView Kayıt Durumu Akışı

```text
RoutesView
↓
RoutesViewModel.savedRouteIds
↓
RouteCard(isSaved:)
↓
Kaydedildi etiketi / bookmark ikonu
```

### Favorilerde Kaydedilen Rotalar Akışı

```text
FavoritesView
↓
Kaydedilen rotalar
↓
RouteCard
↓
RouteDetailView
```

### Favorilerden Kayıt Kaldırma Akışı

```text
FavoritesView
↓
Kaydedilen rota kartına uzun bas
↓
Kaydedilenlerden çıkar
↓
SavedRoutesService.remove(routeId:)
↓
Liste güncellenir
```

---

## 4. Bu Hafta Oluşan Dosyalar

```text
Services/Routes/
└── SavedRoutesService.swift
```

---

## 5. Bu Hafta Güncellenen Dosyalar

```text
Features/Routes/
├── RouteDetailView.swift
├── RouteDetailViewModel.swift
├── RoutesView.swift
└── RoutesViewModel.swift

Features/Routes/Components/
└── RouteCard.swift

Features/Favorites/
├── FavoritesView.swift
└── FavoritesViewModel.swift
```

---

## 6. Teknik Kararlar

Bu hafta alınan teknik kararlar:

- Rota kayıtları local olarak `UserDefaults` içinde tutulacak.
- UserDefaults içinde tüm rota objesi değil, sadece rota id’leri saklanacak.
- Kaydedilen rota detayları ihtiyaç olduğunda `MockRoutes.json` üzerinden bulunacak.
- Kayıt değişiklikleri için `NotificationCenter` kullanılacak.
- Bildirim adı `savedRoutesDidChange` olacak.
- `SavedRoutesService` singleton olarak kullanılacak.
- Favori mekan sistemi mevcut yapısıyla korunacak.
- Favoriler ekranında mekan favorileri ve kaydedilen rotalar ayrı bölümler olarak gösterilecek.
- Kaydedilen rota kaldırma için swipe yerine context menu kullanılacak.

---

## 7. Şu An Çalışan Özellikler

- Rota kaydetme
- Rota kayıttan çıkarma
- RouteDetailView bookmark butonu
- RouteDetailView “Kaydedildi” etiketi
- RoutesView rota kartlarında kayıt durumu
- Favoriler ekranında kaydedilen rotalar
- Kaydedilen rotadan RouteDetailView’a geçiş
- Favoriler ekranından kaydedilen rotayı kaldırma
- Kayıt değişince ekranların güncellenmesi için notification altyapısı

---

## 8. Bilinen Eksikler

Şu konular henüz yapılmadı:

- Firebase kullanıcı rota kayıtları
- Kullanıcı hesabına bağlı rota kayıtları
- iCloud sync
- Kaydedilen rotalarda arama
- Kaydedilen rotalarda filtreleme
- Kaydedilen rotaları sıralama
- Rota paylaşma
- Rota kopyalama
- Rota üzerinde kullanıcı notu tutma
- Rota favorileri için özel boş durum görselleri
- Rota kayıtlarını tüm cihazlarda senkronize etme

---

## 9. 14. Haftaya Hazırlık

14. haftanın önerilen ana konusu:

```text
Rota arama ve filtreleme sistemi
```

Önerilen işler:

```text
1. RoutesView içine SearchBarView ekleme
2. Rotaları ilgi alanlarına göre arama
3. Süre tipine göre filtreleme
4. Ulaşım tipine göre filtreleme
5. Tempo filtresi
6. Kaydedilen rotalar içinde arama
7. Empty state iyileştirmeleri
```

Alternatif konu:

```text
Rota paylaşma ve rota dışa aktarma
```

Ama önerilen öncelik:

> Rota arama ve filtreleme sistemi

---

## 10. Kısa Sonuç

13. hafta sonunda GezioGo’da rota kaydetme sistemi temel seviyede tamamlandı.

Bu haftanın ana sonucu:

> Kullanıcı artık beğendiği rotaları kaydedebilir, kaydedilen rotaları Favoriler ekranında görebilir ve istediğinde kayıttan çıkarabilir.

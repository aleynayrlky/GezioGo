# GezioGo – Hafta 07 Özeti

> Ana konu: Tab bar yapısı, ana uygulama navigasyonu, Harita/Favoriler/Profil sekmelerinin başlangıcı.

---

## 1. Haftanın Ana Amacı

7. haftada GezioGo’nun ana uygulama iskeleti tab bar yapısına dönüştürüldü.

Bu hafta hedeflenen ana yapı:

```text
MainTabBarView
├── Ana Sayfa
├── Keşfet
├── Harita
├── Favoriler
└── Profil
```

Hafta sonunda uygulama, tek akışlı demo görünümünden çıkıp gerçek bir mobil uygulama ana navigasyon yapısına kavuştu.

---

## 2. Bu Hafta Yapılanlar

## Gün 1 – MainTabBarView Temeli

Oluşturulan dosyalar:

```text
App/MainTab.swift
App/MainTabBarView.swift
```

Yapılanlar:

- Ana tab bar yapısı oluşturuldu.
- Tab enum’u hazırlandı.
- Tab başlıkları ve ikonları tanımlandı.
- `RootView` içinde main akış `MainTabBarView` ile değiştirildi.
- İlk tablar oluşturuldu:
  - Ana Sayfa
  - Keşfet
  - Harita
  - Favoriler
  - Profil

Günün sonucu:

> GezioGo ilk kez gerçek bir alt menü yapısına kavuştu.

---

## Gün 2 – Tab Bar İçindeki Navigation Düzeni

Güncellenen dosyalar:

```text
App/RootView.swift
App/MainTabBarView.swift
```

Yapılanlar:

- `RootView` sadeleştirildi.
- Navigation yönetimi `MainTabBarView` içine taşındı.
- Home tab için ayrı `NavigationStack` oluşturuldu.
- Explore tab için ayrı `NavigationStack` oluşturuldu.
- `homePath` ve `explorePath` state’leri eklendi.
- Ortak `destination(for:)` helper fonksiyonu eklendi.

Günün sonucu:

> Home ve Explore sekmeleri kendi navigation stack’leriyle daha düzenli çalışır hale geldi.

---

## Gün 3 – Harita Sekmesi Başlangıcı

Oluşturulan dosyalar:

```text
Features/Map/
├── MapExploreView.swift
└── MapExploreViewModel.swift
```

Güncellenen dosya:

```text
App/MainTabBarView.swift
```

Yapılanlar:

- Harita placeholder ekranı gerçek feature ekranına dönüştürüldü.
- `MapExploreView` oluşturuldu.
- `MapExploreViewModel` ile mock mekan verileri çekildi.
- Harita önizleme alanı tasarlandı.
- Harita tabında mekan kartları gösterildi.
- Harita tabından mekan detayına geçiş bağlandı.
- `mapPath` state’i eklendi.

Günün sonucu:

> Harita sekmesi mock verileri gösteren çalışan bir ekrana dönüştü.

---

## Gün 4 – Favoriler Sekmesi ve FavoritesService

Oluşturulan dosyalar:

```text
Features/Favorites/
├── FavoritesView.swift
└── FavoritesViewModel.swift

Services/Favorites/
└── FavoritesService.swift
```

Güncellenen dosya:

```text
App/MainTabBarView.swift
```

Yapılanlar:

- Favoriler placeholder ekranı gerçek feature ekranına dönüştürüldü.
- `FavoritesService` oluşturuldu.
- Favori mekan id’lerini `UserDefaults` içinde saklayacak temel servis hazırlandı.
- `FavoritesViewModel` oluşturuldu.
- `FavoritesView` boş state ile hazırlandı.
- Favoriler ekranından Keşfet ekranına geçiş eklendi.
- `favoritesPath` state’i eklendi.

Günün sonucu:

> Favoriler sekmesi hazırlandı ve favori sistemi için ilk servis temeli kuruldu.

---

## Gün 5 – Profil Sekmesi Başlangıcı

Oluşturulan dosyalar:

```text
Features/Profile/
├── ProfileView.swift
└── SettingsView.swift
```

Güncellenen dosya:

```text
App/MainTabBarView.swift
```

Yapılanlar:

- Profil placeholder ekranı gerçek ekrana dönüştürüldü.
- Seçili şehir bilgisi gösterildi.
- Uygulama adı, sürüm ve veri kaynağı bilgileri gösterildi.
- Yakında eklenecek kullanıcı hesabı özellikleri listelendi.
- Ayarlar ekranı oluşturuldu.
- Profil ekranından Ayarlar ekranına geçiş eklendi.
- `profilePath` state’i eklendi.

Günün sonucu:

> Profil sekmesi uygulama bilgisi ve ayarlar ekranıyla kullanılabilir hale geldi.

---

## Gün 6 – UI Temizliği ve Tab Bar Görsel Uyumu

Oluşturulan dosya:

```text
DesignSystem/Components/ComingSoonView.swift
```

Güncellenen dosya:

```text
App/MainTabBarView.swift
```

Yapılanlar:

- Tab bar yapısı genel olarak kontrol edildi.
- Placeholder kullanımını azaltmak için `ComingSoonView` oluşturuldu.
- `temporaryTabView` fonksiyonu artık kullanılmıyorsa temizlendi.
- Tab bar’daki tüm sekmelerin gerçek ekranlara bağlandığı kontrol edildi.
- Home, Explore, Map, Favorites ve Profile sekmeleri test edildi.

Günün sonucu:

> Tab bar yapısı daha temiz ve sürdürülebilir hale getirildi.

---

## Gün 7 – Haftalık Kontrol

Yapılanlar:

- Tüm tab bar akışı test edildi.
- Home tab navigation kontrol edildi.
- Explore tab navigation kontrol edildi.
- Map tab ve PlaceDetail geçişi kontrol edildi.
- Favorites tab boş state ve Keşfet yönlendirmesi kontrol edildi.
- Profile tab ve SettingsView geçişi kontrol edildi.
- GitHub dosya yapısı kontrol edildi.
- `week-07.md` dosyası hazırlandı.

Günün sonucu:

> 7. hafta sonunda ana uygulama navigasyonu tab bar yapısıyla tamamlandı.

---

## 3. Oluşan Ana Akış

```text
Splash
↓
Onboarding
↓
CitySelectionView
↓
MainTabBarView
    ├── HomeView
    ├── ExploreView
    ├── MapExploreView
    ├── FavoritesView
    └── ProfileView
```

---

## 4. Bu Hafta Oluşan Dosyalar

```text
App/
├── MainTab.swift
└── MainTabBarView.swift

Features/Map/
├── MapExploreView.swift
└── MapExploreViewModel.swift

Features/Favorites/
├── FavoritesView.swift
└── FavoritesViewModel.swift

Services/Favorites/
└── FavoritesService.swift

Features/Profile/
├── ProfileView.swift
└── SettingsView.swift

DesignSystem/Components/
└── ComingSoonView.swift
```

---

## 5. Güncellenen Ana Dosyalar

```text
App/RootView.swift
App/MainTabBarView.swift
Features/Home/HomeView.swift
Features/Explore/ExploreView.swift
Features/Explore/PlaceListView.swift
```

---

## 6. Teknik Kararlar

Bu hafta alınan teknik kararlar:

- Uygulamanın ana yapısı `MainTabBarView` ile yönetilecek.
- Tab bar’da beş ana bölüm olacak:
  - Ana Sayfa
  - Keşfet
  - Harita
  - Favoriler
  - Profil
- Her ana tab kendi `NavigationStack` yapısına sahip olacak.
- Home, Explore, Map ve Favorites tabları kendi path state’leriyle yönetilecek.
- Profil sekmesi kendi ayarlar ekranına sahip olacak.
- Favoriler ilk aşamada `UserDefaults` ile tutulacak.
- Harita sekmesi önce mock veri ve preview alanı ile başlayacak.
- Gerçek MapKit entegrasyonu sonraki haftaya bırakılacak.

---

## 7. Şu An Çalışan Özellikler

- Tab bar ana navigasyon yapısı
- Ana Sayfa sekmesi
- Keşfet sekmesi
- Harita sekmesi
- Favoriler sekmesi
- Profil sekmesi
- Harita ekranında mock mekan gösterimi
- Favoriler ekranında boş state
- Favorilerden Keşfet’e yönlendirme
- Profil ekranı
- Ayarlar ekranı
- Tab içinde navigation stack yapısı
- Mekan detayına farklı tablardan geçiş

---

## 8. Bilinen Eksikler

Şu konular henüz yapılmadı:

- Gerçek MapKit pinleri
- Apple Maps ile yol tarifi açma
- Favoriye ekleme butonu
- Favoriden çıkarma UI akışı
- Favori durumunu kartlarda gösterme
- Profilde gerçek kullanıcı hesabı
- Onboarding durumunu kalıcı saklama
- Seçili şehir bilgisini kalıcı saklama
- Etkinlik detay ekranı
- Arama sistemi
- Gelişmiş filtreleme
- Firebase bağlantısı
- AI rota entegrasyonu

---

## 9. 8. Haftaya Hazırlık

8. haftanın önerilen ana konusu:

```text
Favori sistemi entegrasyonu + MapKit başlangıcı
```

Önerilen 8. hafta işleri:

```text
1. PlaceDetailView içine favori butonu ekleme
2. PlaceCard üzerinde favori durumunu gösterme
3. FavoritesService ile UI bağlantısı
4. Favoriler ekranında gerçek favori listeleme
5. MapKit temel harita gösterimi
6. Mekan pinleri
7. Apple Maps yol tarifi hazırlığı
```

Alternatif olarak 8. hafta şu konuya ayrılabilir:

```text
Onboarding ve şehir seçimini kalıcı saklama
```

Ama önerilen öncelik:

> Favoriler + MapKit başlangıcı

---

## 10. Kısa Sonuç

7. hafta sonunda GezioGo artık gerçek bir mobil uygulama ana yapısına kavuştu.

Bu haftanın ana sonucu:

> Splash → Onboarding → CitySelection → MainTabBar akışı tamamlandı ve Home, Explore, Map, Favorites, Profile sekmeleri çalışır hale getirildi.

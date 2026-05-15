# GezioGo – Hafta 05 Özeti

> Ana konu: SwiftUI proje başlangıcı, tasarım sistemi, Swift veri modelleri, mock data, splash/onboarding, şehir seçimi ve ana sayfa başlangıcı.

---

## 1. Haftanın Ana Amacı

5. haftada GezioGo projesi dokümantasyon ve planlama aşamasından gerçek SwiftUI geliştirme aşamasına geçti.

Bu haftanın ana hedefi, uygulamanın ilk çalışan SwiftUI iskeletini oluşturmaktı.

Kurulması hedeflenen temel akış:

```text
Splash
↓
Onboarding
↓
Şehir Seçimi
↓
Ana Sayfa
```

Hafta sonunda bu akış mock veriyle çalışır hale getirildi.

---

## 2. Bu Hafta Yapılanlar

## Gün 1 – Xcode Proje Kurulumu

Bu gün GezioGo’nun gerçek SwiftUI projesi başlatıldı.

Yapılanlar:

- Xcode’da yeni SwiftUI projesi oluşturuldu.
- Proje adı `GezioGo` olarak belirlendi.
- Ana proje klasörü içinde `ios/` klasörü oluşturuldu.
- Xcode projesi şu yapıya yerleştirildi:

```text
GezioGo/
└── ios/
    └── GezioGo/
        ├── GezioGo.xcodeproj
        └── GezioGo/
```

- SwiftUI proje klasörleri oluşturuldu:

```text
App/
Core/
DesignSystem/
Models/
Features/
Services/
Resources/
MockData/
Utilities/
```

- `GezioGoApp.swift`, `RootView.swift` ve `AppState.swift` dosyaları `App/` klasörüne yerleştirildi.
- `RootView` içinde geçici GezioGo başlangıç ekranı oluşturuldu.
- Git ana `GezioGo/` klasöründe başlatıldı.
- Tüm proje dosyaları GitHub’a gönderildi.
- `ios/GezioGo` klasörünün submodule gibi görünmesi sorunu düzeltildi.
- Xcode’da `.gitkeep` dosyalarının build’e dahil olmasından kaynaklanan hata çözüldü.

Günün sonucu:

> GezioGo SwiftUI projesinin temel klasör yapısı kuruldu ve GitHub bağlantısı tamamlandı.

---

## Gün 2 – Design System Başlangıcı

Bu gün GezioGo’nun marka dili SwiftUI tarafına taşındı.

Oluşturulan dosyalar:

```text
DesignSystem/
├── Colors/
│   └── AppColors.swift
├── Typography/
│   └── AppTypography.swift
├── Spacing/
│   └── AppSpacing.swift
├── Radius/
│   └── AppRadius.swift
└── Components/
    ├── AppButton.swift
    ├── AppCard.swift
    └── AppTag.swift
```

Tanımlanan temel görsel dil:

```text
Petrol yeşili
Turkuaz
Altın sarısı
Krem arka plan
Yuvarlak kartlar
Premium şehir/turizm hissi
```

Hazırlanan ortak bileşenler:

- `AppButton`
- `AppCard`
- `AppTag`

Günün sonucu:

> GezioGo’nun ekranlarında kullanılacak ortak renk, tipografi, boşluk, radius, buton, kart ve etiket yapısı oluşturuldu.

---

## Gün 3 – Swift Veri Modelleri

Bu gün 3. haftada planlanan veri modelleri Swift dosyalarına dönüştürüldü.

Oluşturulan dosyalar:

```text
Models/
├── Category.swift
├── City.swift
├── ContentStatus.swift
├── Event.swift
├── Place.swift
├── PriceType.swift
├── RouteStop.swift
└── TripRoute.swift
```

Hazırlanan modeller:

- `City`
- `Place`
- `Event`
- `TripRoute`
- `RouteStop`
- `ContentStatus`
- `PriceType`
- `PlaceCategory`
- `EventCategory`

Önemli kararlar:

- `Place`, `Event`, `City`, `TripRoute` modelleri `Codable` olarak hazırlandı.
- JSON dosyalarının Swift modellerine dönüştürülebilmesi için yapı kuruldu.
- `category`, `priceType` ve `contentStatus` gibi alanlarda enum kullanıldı.
- RootView içinde geçici model testi yapıldı.

Günün sonucu:

> Swift veri modelleri oluşturuldu ve uygulama içinde kullanılabilir hale getirildi.

---

## Gün 4 – Mock Data ve JSON Okuma Sistemi

Bu gün uygulama Firebase’e bağlanmadan local JSON dosyalarından veri okuyacak hale getirildi.

Oluşturulan JSON dosyaları:

```text
Resources/JSON/
├── MockCities.json
├── MockPlaces.json
├── MockEvents.json
└── MockRoutes.json
```

Oluşturulan servis ve yardımcı dosyalar:

```text
Utilities/Helpers/
└── JSONLoader.swift

Services/Data/
├── DataServiceProtocol.swift
└── MockDataService.swift
```

Kurulan veri akışı:

```text
Local JSON
↓
JSONLoader
↓
MockDataService
↓
ViewModel
↓
SwiftUI View
```

Test edilen veri:

- Samsun şehir bilgisi
- 3 mekan
- 2 etkinlik
- 1 mock rota

RootView içinde mock veri test edildi ve ekranda şu bilgiler gösterildi:

```text
Samsun
3 mekan
2 etkinlik
```

Günün sonucu:

> Uygulama local JSON dosyalarını okuyabilir hale geldi ve mock data sistemi çalıştı.

---

## Gün 5 – Splash ve Onboarding Akışı

Bu gün uygulamanın açılış ve tanıtım ekranları oluşturuldu.

Oluşturulan dosyalar:

```text
Features/Splash/
└── SplashView.swift

Features/Onboarding/
├── OnboardingView.swift
└── OnboardingPageView.swift
```

Kurulan akış:

```text
SplashView
↓
OnboardingView
↓
Temporary Main View
```

Onboarding sayfaları:

1. Şehri kolayca keşfet
2. AI ile rota oluştur
3. Haritada yakın yerleri bul

Kullanılan tasarım dili:

- Petrol/turkuaz gradient splash ekranı
- Altın sarısı pin vurgusu
- Krem arka plan
- Yuvarlak onboarding görsel alanları
- GezioGo tasarım sistemi bileşenleri

Günün sonucu:

> Splash ve onboarding ekranları çalışır hale getirildi.

---

## Gün 6 – Şehir Seçimi ve Ana Sayfa Başlangıcı

Bu gün onboarding sonrası şehir seçimi ve ana sayfa başlangıcı kuruldu.

Oluşturulan dosyalar:

```text
Features/CitySelection/
├── CitySelectionView.swift
└── CitySelectionViewModel.swift

Features/Home/
├── HomeView.swift
├── HomeViewModel.swift
└── Components/
    ├── HomeHeroCard.swift
    ├── CategoryShortcutView.swift
    └── FeaturedPlaceCard.swift
```

Güncellenen dosyalar:

```text
App/AppState.swift
App/RootView.swift
```

Kurulan yeni uygulama akışı:

```text
Splash
↓
Onboarding
↓
CitySelectionView
↓
HomeView
```

Şehir seçimi:

- İlk pilot şehir olarak Samsun gösterildi.
- Kullanıcı `Samsun ile Başla` butonuna basınca ana sayfaya yönlendirildi.

Ana sayfada gösterilenler:

- GezioGo başlığı
- Samsun şehir bilgisi
- Kategori kısayolları
- Öne çıkan mekanlar
- Yaklaşan etkinlikler

Kullanılan veri:

- `MockCities.json`
- `MockPlaces.json`
- `MockEvents.json`
- `MockDataService`

Günün sonucu:

> Şehir seçimi ekranı ve mock veriyle çalışan ilk ana sayfa oluşturuldu.

---

## Gün 7 – Haftalık Toparlama ve Kontrol

Bu gün 5. haftanın genel kontrolü yapıldı.

Kontrol edilen ana akış:

```text
Splash
↓
Onboarding
↓
Şehir Seçimi
↓
Samsun ile Başla
↓
HomeView
```

Kontrol listesi:

```text
[ ] Splash ekranı açılıyor
[ ] Onboarding ekranına geçiyor
[ ] Onboarding sayfaları çalışıyor
[ ] Keşfetmeye Başla butonu çalışıyor
[ ] Şehir seçimi ekranı açılıyor
[ ] Samsun kartı görünüyor
[ ] Samsun ile Başla butonu çalışıyor
[ ] HomeView açılıyor
[ ] HomeView’da Samsun bilgisi geliyor
[ ] Mekan verileri geliyor
[ ] Etkinlik verileri geliyor
[ ] Kategoriler görünüyor
[ ] GitHub güncel
```

Günün sonucu:

> 5. hafta sonunda çalışan ilk GezioGo SwiftUI uygulama iskeleti tamamlandı.

---

## 3. Oluşan Ana SwiftUI Yapısı

```text
ios/GezioGo/GezioGo/
├── App/
│   ├── AppState.swift
│   ├── GezioGoApp.swift
│   └── RootView.swift
├── DesignSystem/
│   ├── Colors/
│   ├── Typography/
│   ├── Spacing/
│   ├── Radius/
│   └── Components/
├── Models/
├── Services/
│   └── Data/
├── Resources/
│   └── JSON/
├── Utilities/
│   └── Helpers/
└── Features/
    ├── Splash/
    ├── Onboarding/
    ├── CitySelection/
    └── Home/
```

---

## 4. Oluşan Ana Uygulama Akışı

```text
RootView
↓
SplashView
↓
OnboardingView
↓
CitySelectionView
↓
HomeView
```

RootView, uygulamanın başlangıç akışını yönetir.

Şu anki launch state yapısı:

```text
splash
onboarding
citySelection
main
```

---

## 5. Kullanılan Veri Kaynağı

Bu hafta gerçek backend veya Firebase kullanılmadı.

Kullanılan yapı:

```text
Local JSON dosyaları
↓
JSONLoader
↓
MockDataService
↓
ViewModel
↓
SwiftUI ekranları
```

Bu karar sayesinde ekranlar backend beklemeden geliştirilebilir hale geldi.

---

## 6. Teknik Kararlar

Bu hafta alınan teknik kararlar:

- SwiftUI kullanılacak.
- İlk aşamada Firebase yerine local JSON kullanılacak.
- Ekranlar doğrudan JSON okumayacak.
- Veri okuma işlemleri servis katmanı üzerinden yapılacak.
- `DataServiceProtocol` ileride Firebase geçişini kolaylaştıracak.
- Tasarım sistemi merkezi olacak.
- Renk, tipografi, spacing, radius, buton, kart ve etiket bileşenleri ortak kullanılacak.
- Feature bazlı klasör yapısı kullanılacak.
- GitHub’da tüm proje klasörü takip edilecek.

---

## 7. Şu An Çalışan Özellikler

- Splash ekranı
- Onboarding ekranları
- Onboarding sonrası şehir seçimi
- Samsun şehir seçimi
- Mock JSON veri okuma
- HomeView’da şehir, mekan ve etkinlik verisi gösterimi
- Design System bileşenleri
- Swift data modelleri
- GitHub proje takibi

---

## 8. Bilinen Eksikler

Şu konular henüz yapılmadı:

- Onboarding durumunu kalıcı saklama
- Seçili şehri kalıcı saklama
- Gerçek logo asset entegrasyonu
- Ana sayfa son tasarımı
- Keşfet ekranı
- Mekan listesi
- Mekan detay ekranı
- Etkinlik detay ekranı
- Harita ekranı
- Favorilere ekleme sistemi
- Firebase bağlantısı
- Kullanıcı hesabı
- AI rota entegrasyonu
- Panel tarafı kodlama

---

## 9. 6. Haftaya Hazırlık

6. haftanın önerilen ana konusu:

```text
Keşfet ekranı + Mekan listesi + Mekan detay başlangıcı
```

Oluşturulacak muhtemel dosyalar:

```text
Features/Explore/
├── ExploreView.swift
├── ExploreViewModel.swift
├── PlaceListView.swift
├── PlaceListViewModel.swift
└── Components/
    └── PlaceCard.swift

Features/PlaceDetail/
├── PlaceDetailView.swift
├── PlaceDetailViewModel.swift
└── Components/
    ├── PlaceInfoRow.swift
    └── PlaceMapPreview.swift
```

6. haftada hedeflenecek akış:

```text
HomeView
↓
ExploreView
↓
PlaceListView
↓
PlaceDetailView
```

---

## 10. Kısa Sonuç

5. hafta sonunda GezioGo artık çalışan bir SwiftUI uygulama iskeletine sahip.

Bu haftanın ana sonucu:

> GezioGo’nun temel uygulama akışı kuruldu, mock veri sistemi çalıştı ve kullanıcı Splash → Onboarding → Şehir Seçimi → Ana Sayfa akışını deneyimleyebilir hale geldi.

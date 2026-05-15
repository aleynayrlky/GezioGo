# GezioGo – iOS Proje Klasör Yapısı

> Hafta 4 / Gün 1 çıktısı  
> Dosya amacı: GezioGo SwiftUI projesinde dosya ve klasörlerin nasıl düzenleneceğini belirlemek.

---

## 1. Amaç

GezioGo büyüyen bir proje olacağı için Xcode projesi en baştan düzenli kurulmalıdır.

Bu dosyanın amacı:

- SwiftUI proje klasörlerini belirlemek
- Ekranları feature bazlı ayırmak
- Model, servis, tasarım sistemi ve mock data dosyalarını karıştırmamak
- İleride Firebase, AI, panel entegrasyonu ve çoklu şehir yapısı eklendiğinde projeyi yönetilebilir tutmak

Ana ilke:

> Dosyalar özellik bazlı ve okunabilir şekilde düzenlenmelidir.

---

## 2. Önerilen Xcode Ana Klasör Yapısı

```text
GezioGoApp/
├── App/
├── Core/
├── DesignSystem/
├── Models/
├── Features/
├── Services/
├── Resources/
├── MockData/
├── Utilities/
└── Preview Content/
```

---

## 3. Klasörlerin Amacı

| Klasör | Amaç |
|---|---|
| `App/` | Uygulama giriş noktası, app state, root navigation |
| `Core/` | Ortak yapı, sabitler, environment, app config |
| `DesignSystem/` | Renkler, tipografi, butonlar, kartlar, ortak UI bileşenleri |
| `Models/` | City, Place, Event, Route gibi veri modelleri |
| `Features/` | Her ana ekran/özellik için ayrı klasörler |
| `Services/` | Veri, konum, favori, harita, AI ve auth servisleri |
| `Resources/` | Görseller, fontlar, JSON dosyaları, asset catalog |
| `MockData/` | Geliştirme sürecinde kullanılacak örnek veri |
| `Utilities/` | Yardımcı extension ve helper dosyaları |
| `Preview Content/` | SwiftUI preview varlıkları |

---

## 4. Detaylı Klasör Yapısı

```text
GezioGoApp/
├── App/
│   ├── GezioGoApp.swift
│   ├── RootView.swift
│   ├── AppState.swift
│   └── AppRouter.swift
│
├── Core/
│   ├── Constants/
│   │   ├── AppConstants.swift
│   │   ├── APIConstants.swift
│   │   └── FeatureFlags.swift
│   ├── Environment/
│   │   └── AppEnvironment.swift
│   └── Config/
│       └── AppConfig.swift
│
├── DesignSystem/
│   ├── Colors/
│   │   └── AppColors.swift
│   ├── Typography/
│   │   └── AppTypography.swift
│   ├── Spacing/
│   │   └── AppSpacing.swift
│   ├── Components/
│   │   ├── AppButton.swift
│   │   ├── AppCard.swift
│   │   ├── AppTag.swift
│   │   ├── AppSearchBar.swift
│   │   ├── AppSectionHeader.swift
│   │   ├── EmptyStateView.swift
│   │   ├── LoadingView.swift
│   │   └── ErrorStateView.swift
│   └── TabBar/
│       └── MainTabBarView.swift
│
├── Models/
│   ├── City.swift
│   ├── Place.swift
│   ├── Event.swift
│   ├── AppUser.swift
│   ├── TripRoute.swift
│   ├── RouteStop.swift
│   ├── Partner.swift
│   ├── ContentStatus.swift
│   └── Category.swift
│
├── Features/
│   ├── Splash/
│   │   └── SplashView.swift
│   ├── Onboarding/
│   │   ├── OnboardingView.swift
│   │   └── OnboardingPageView.swift
│   ├── CitySelection/
│   │   └── CitySelectionView.swift
│   ├── Home/
│   │   ├── HomeView.swift
│   │   ├── HomeViewModel.swift
│   │   └── Components/
│   │       ├── HomeHeroCard.swift
│   │       ├── CategoryShortcutView.swift
│   │       └── FeaturedPlaceCard.swift
│   ├── Explore/
│   │   ├── ExploreView.swift
│   │   ├── PlaceListView.swift
│   │   ├── PlaceListViewModel.swift
│   │   └── Components/
│   │       ├── PlaceCard.swift
│   │       └── FilterChipView.swift
│   ├── PlaceDetail/
│   │   ├── PlaceDetailView.swift
│   │   ├── PlaceDetailViewModel.swift
│   │   └── Components/
│   │       ├── PlaceInfoRow.swift
│   │       └── PlaceMapPreview.swift
│   ├── Events/
│   │   ├── EventListView.swift
│   │   ├── EventDetailView.swift
│   │   ├── EventListViewModel.swift
│   │   └── Components/
│   │       └── EventCard.swift
│   ├── Map/
│   │   ├── MapExploreView.swift
│   │   ├── MapExploreViewModel.swift
│   │   └── Components/
│   │       └── MapBottomSheet.swift
│   ├── TripPlanner/
│   │   ├── TripPlannerFormView.swift
│   │   ├── TripPlannerResultView.swift
│   │   ├── TripPlannerViewModel.swift
│   │   └── Components/
│   │       ├── RouteStopCard.swift
│   │       └── RouteSummaryCard.swift
│   ├── Favorites/
│   │   ├── FavoritesView.swift
│   │   └── FavoritesViewModel.swift
│   └── Profile/
│       ├── ProfileView.swift
│       └── SettingsView.swift
│
├── Services/
│   ├── Data/
│   │   ├── DataServiceProtocol.swift
│   │   ├── MockDataService.swift
│   │   └── FirebaseDataService.swift
│   ├── Location/
│   │   └── LocationService.swift
│   ├── Favorites/
│   │   └── FavoritesService.swift
│   ├── Map/
│   │   └── MapService.swift
│   ├── TripPlanner/
│   │   └── TripPlannerService.swift
│   ├── Auth/
│   │   └── AuthService.swift
│   └── Notifications/
│       └── NotificationService.swift
│
├── Resources/
│   ├── Assets.xcassets
│   ├── Localizable.strings
│   └── JSON/
│       ├── MockCities.json
│       ├── MockPlaces.json
│       ├── MockEvents.json
│       └── MockRoutes.json
│
├── MockData/
│   ├── MockCityData.swift
│   ├── MockPlaceData.swift
│   ├── MockEventData.swift
│   └── MockRouteData.swift
│
└── Utilities/
    ├── Extensions/
    │   ├── Color+Extensions.swift
    │   ├── Date+Extensions.swift
    │   └── String+Extensions.swift
    └── Helpers/
        └── JSONLoader.swift
```

---

## 5. Feature Bazlı Yapı Neden Önemli?

GezioGo’da çok sayıda ekran olacak:

- Ana Sayfa
- Keşfet
- Mekan Detay
- Etkinlikler
- Harita
- AI Rota
- Favoriler
- Profil

Bu yüzden her şeyi tek klasörde toplamak projeyi karıştırır.

Doğru yaklaşım:

```text
Her büyük özellik kendi klasöründe olmalı.
```

Örneğin `TripPlanner/` klasörü sadece AI rota ile ilgili dosyaları içermelidir.

---

## 6. MVP İçin İlk Oluşturulacak Klasörler

İlk geliştirme aşamasında tüm klasörleri boş bile olsa oluşturmak şart değil.

Başlangıçta oluşturulması önerilenler:

```text
App/
DesignSystem/
Models/
Features/Home/
Features/Explore/
Features/PlaceDetail/
Features/Events/
Features/Map/
Features/Favorites/
Services/Data/
Services/Location/
Services/Favorites/
Resources/JSON/
Utilities/
```

AI rota klasörü 1.1 aşamasında aktif geliştirilebilir:

```text
Features/TripPlanner/
Services/TripPlanner/
```

---

## 7. Dosya İsimlendirme Kuralları

- View dosyaları `View` ile bitmeli.
- ViewModel dosyaları `ViewModel` ile bitmeli.
- Servis dosyaları `Service` ile bitmeli.
- Model dosyaları model adıyla aynı olmalı.
- Component dosyaları yaptığı işi açık anlatmalı.

Örnek:

```text
PlaceDetailView.swift
PlaceDetailViewModel.swift
PlaceCard.swift
FavoritesService.swift
MockDataService.swift
```

---

## 8. Sonuç

GezioGo SwiftUI projesi baştan düzenli kurulursa ileride Firebase, AI, panel ve çoklu şehir özellikleri eklenirken proje dağılmaz.

Ana ilke:

> Her dosya ait olduğu özelliğin veya katmanın içinde durmalı.

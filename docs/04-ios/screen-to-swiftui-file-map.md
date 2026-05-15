# GezioGo – Ekran ve SwiftUI Dosya Eşleşmesi

> Hafta 4 / Gün 5 çıktısı  
> Dosya amacı: GezioGo’daki mobil uygulama ekranlarının hangi SwiftUI dosyalarıyla geliştirileceğini planlamak.

---

## 1. Amaç

2. haftada mobil ekranlar ve kullanıcı akışları belirlendi. Bu dosya, o ekranları SwiftUI dosyalarına dönüştürür.

Ana ilke:

> Her ekranın bir ana View dosyası, gerekiyorsa ViewModel dosyası ve component dosyaları olmalıdır.

---

## 2. Ana Ekran Dosya Haritası

| Ekran | SwiftUI Dosyası | ViewModel | MVP |
|---|---|---|---|
| Splash | `SplashView.swift` | Gerekmez | Evet |
| Onboarding | `OnboardingView.swift` | Opsiyonel | Evet |
| Şehir Seçimi | `CitySelectionView.swift` | `CitySelectionViewModel.swift` | Evet |
| Ana Sayfa | `HomeView.swift` | `HomeViewModel.swift` | Evet |
| Keşfet | `ExploreView.swift` | `ExploreViewModel.swift` | Evet |
| Mekan Listesi | `PlaceListView.swift` | `PlaceListViewModel.swift` | Evet |
| Mekan Detay | `PlaceDetailView.swift` | `PlaceDetailViewModel.swift` | Evet |
| Etkinlik Listesi | `EventListView.swift` | `EventListViewModel.swift` | Evet |
| Etkinlik Detay | `EventDetailView.swift` | `EventDetailViewModel.swift` | Evet |
| Harita | `MapExploreView.swift` | `MapExploreViewModel.swift` | Evet |
| Favoriler | `FavoritesView.swift` | `FavoritesViewModel.swift` | Evet |
| AI Rota Formu | `TripPlannerFormView.swift` | `TripPlannerViewModel.swift` | 1.1 |
| AI Rota Sonucu | `TripPlannerResultView.swift` | `TripPlannerViewModel.swift` | 1.1 |
| Profil | `ProfileView.swift` | `ProfileViewModel.swift` | 1.2 |
| Ayarlar | `SettingsView.swift` | `SettingsViewModel.swift` | 1.2 |

---

## 3. Splash

```text
Features/Splash/
└── SplashView.swift
```

### Görevi

- Logo gösterimi
- Kısa açılış animasyonu
- Kullanıcı daha önce onboarding gördüyse ana sayfaya yönlendirme

### Kullanacağı veri

- AppState

---

## 4. Onboarding

```text
Features/Onboarding/
├── OnboardingView.swift
└── OnboardingPageView.swift
```

### Görevi

- GezioGo’nun temel faydasını anlatmak
- Keşfet, Planla, Haritada Gör, Favorilere Ekle gibi değerleri göstermek

### Navigasyon

```text
Onboarding → Şehir Seçimi
```

---

## 5. City Selection

```text
Features/CitySelection/
├── CitySelectionView.swift
└── CitySelectionViewModel.swift
```

### Kullanacağı model

- City

### Kullanacağı servis

- DataServiceProtocol

### Navigasyon

```text
Şehir Seçimi → Ana Sayfa
```

---

## 6. Home

```text
Features/Home/
├── HomeView.swift
├── HomeViewModel.swift
└── Components/
    ├── HomeHeroCard.swift
    ├── CategoryShortcutView.swift
    └── FeaturedPlaceCard.swift
```

### Kullanacağı modeller

- City
- Place
- Event

### Kullanacağı servisler

- DataServiceProtocol
- LocationService
- FavoritesService

### Navigasyon

```text
Ana Sayfa → Keşfet
Ana Sayfa → Mekan Detay
Ana Sayfa → Etkinlik Detay
Ana Sayfa → Planla
Ana Sayfa → Harita
```

---

## 7. Explore / Place List

```text
Features/Explore/
├── ExploreView.swift
├── ExploreViewModel.swift
├── PlaceListView.swift
├── PlaceListViewModel.swift
└── Components/
    ├── PlaceCard.swift
    └── FilterChipView.swift
```

### Kullanacağı modeller

- Place
- Category

### Görevi

- Kategori gösterimi
- Mekan listeleme
- Filtreleme
- Arama

---

## 8. Place Detail

```text
Features/PlaceDetail/
├── PlaceDetailView.swift
├── PlaceDetailViewModel.swift
└── Components/
    ├── PlaceInfoRow.swift
    └── PlaceMapPreview.swift
```

### Kullanacağı model

- Place

### Kullanacağı servisler

- FavoritesService
- MapService

### Navigasyon

```text
Mekan Detay → Harita
Mekan Detay → Apple Maps Yol Tarifi
Mekan Detay → Favorilere Ekle
```

---

## 9. Events

```text
Features/Events/
├── EventListView.swift
├── EventDetailView.swift
├── EventListViewModel.swift
├── EventDetailViewModel.swift
└── Components/
    └── EventCard.swift
```

### Kullanacağı model

- Event

### Navigasyon

```text
Etkinlik Listesi → Etkinlik Detay
Etkinlik Detay → Bilet Linki
Etkinlik Detay → Harita
```

---

## 10. Map

```text
Features/Map/
├── MapExploreView.swift
├── MapExploreViewModel.swift
└── Components/
    └── MapBottomSheet.swift
```

### Kullanacağı modeller

- Place
- Event

### Kullanacağı servisler

- LocationService
- MapService
- DataServiceProtocol

---

## 11. Trip Planner

```text
Features/TripPlanner/
├── TripPlannerFormView.swift
├── TripPlannerResultView.swift
├── TripPlannerViewModel.swift
└── Components/
    ├── RouteStopCard.swift
    ├── RouteSummaryCard.swift
    └── PreferenceChip.swift
```

### Kullanacağı modeller

- TripRoute
- RouteStop
- Place
- Event

### Kullanacağı servis

- TripPlannerService

### Sürüm

1.1

---

## 12. Favorites

```text
Features/Favorites/
├── FavoritesView.swift
└── FavoritesViewModel.swift
```

### Kullanacağı modeller

- Place
- Event
- TripRoute

### Kullanacağı servis

- FavoritesService

---

## 13. Profile

```text
Features/Profile/
├── ProfileView.swift
├── SettingsView.swift
├── ProfileViewModel.swift
└── SettingsViewModel.swift
```

### Kullanacağı model

- AppUser

### Sürüm

1.2

---

## 14. Geliştirme Sırası

Önerilen ilk geliştirme sırası:

```text
1. SplashView
2. OnboardingView
3. CitySelectionView
4. HomeView
5. ExploreView
6. PlaceListView
7. PlaceDetailView
8. EventListView
9. EventDetailView
10. MapExploreView
11. FavoritesView
12. TripPlannerFormView
13. TripPlannerResultView
```

---

## 15. Sonuç

Bu dosya, ekranların SwiftUI tarafında hangi dosyaya dönüşeceğini gösterir.

Ana ilke:

> Her ekran kendi dosyasında, her büyük özellik kendi feature klasöründe olmalıdır.

# GezioGo – Hafta 04 Özeti

> Hafta 4 çıktısı  
> Ana konu: SwiftUI teknik hazırlık, iOS proje klasör yapısı, model planı, mock data, design system ve servis katmanı.

---

## 1. Haftanın Ana Amacı

4. haftanın amacı, GezioGo SwiftUI projesini açmadan önce teknik düzeni netleştirmektir.

Bu hafta şu sorulara cevap verildi:

- Xcode projesinde klasörler nasıl olmalı?
- Veri modellerinin Swift karşılıkları nasıl planlanmalı?
- İlk aşamada Firebase yerine mock data nasıl kullanılmalı?
- GezioGo tasarım sistemi SwiftUI’a nasıl aktarılmalı?
- Her ekran hangi SwiftUI dosyasına karşılık gelmeli?
- Servis katmanı nasıl kurulmalı?

---

## 2. Bu Hafta Hazırlanan Dosyalar

```text
docs/04-ios/ios-project-folder-structure.md
docs/04-ios/swift-models-plan.md
docs/04-ios/mock-data-usage.md
docs/04-ios/swiftui-design-system-plan.md
docs/04-ios/screen-to-swiftui-file-map.md
docs/04-ios/service-layer-plan.md
notes/weekly-notes/week-04.md
```

Mock veri dosyaları:

```text
data/mock/MockCities.json
data/mock/MockPlaces.json
data/mock/MockEvents.json
data/mock/MockRoutes.json
```

---

## 3. Netleşen Xcode Klasör Yapısı

Önerilen yapı:

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
└── Utilities/
```

Ana karar:

> GezioGo feature bazlı klasör yapısıyla geliştirilecek.

---

## 4. Netleşen Swift Model Dosyaları

```text
City.swift
Place.swift
Event.swift
AppUser.swift
TripRoute.swift
RouteStop.swift
Partner.swift
ContentStatus.swift
Category.swift
PriceType.swift
UserRole.swift
```

MVP için öncelikli modeller:

```text
City.swift
Place.swift
Event.swift
TripRoute.swift
RouteStop.swift
ContentStatus.swift
```

---

## 5. Mock Data Kararı

İlk geliştirme aşamasında Firebase’e doğrudan bağlanılmayacak.

Önce:

```text
Local JSON + MockDataService
```

Sonra:

```text
Firestore + FirebaseDataService
```

Bu sayede ekranlar daha hızlı geliştirilecek.

---

## 6. Design System Kararı

GezioGo tasarım dili SwiftUI’da ortak bileşenlerle yönetilecek.

Öncelikli bileşenler:

```text
AppButton
AppCard
PlaceCard
EventCard
AppTag
AppSearchBar
LoadingView
EmptyStateView
ErrorStateView
MainTabBarView
```

Ana renkler:

```text
Petrol yeşili
Turkuaz
Altın sarısı
Açık krem
```

---

## 7. Ekran Geliştirme Sırası

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

## 8. Servis Katmanı Kararı

MVP başlangıcında şu servisler yeterlidir:

```text
DataServiceProtocol
MockDataService
LocationService
FavoritesService
MapService
```

Sonra eklenecekler:

```text
TripPlannerService
FirebaseDataService
AuthService
NotificationService
```

Ana karar:

> View dosyaları doğrudan JSON, Firebase veya AI API ile konuşmayacak. ViewModel servis katmanı üzerinden veri alacak.

---

## 9. 5. Haftaya Hazırlık

5. haftada önerilen konu:

> Xcode projesini açma + ilk SwiftUI dosyalarını oluşturma + Design System başlangıcı + Splash/Onboarding/Home ekranlarını kodlama.

Olası 5. hafta dosyaları:

```text
docs/05-development/xcode-project-setup.md
docs/05-development/design-system-implementation.md
docs/05-development/splash-onboarding-implementation.md
docs/05-development/home-screen-implementation.md
```

---

## 10. Kısa Sonuç

4. hafta, GezioGo’nun SwiftUI tarafına geçmeden önceki teknik hazırlık haftasıdır.

Ana sonuç:

> Artık Xcode projesini hangi klasör yapısıyla açacağımızı, hangi Swift modellerini yazacağımızı, mock veriyi nasıl kullanacağımızı ve ekranları hangi sırayla geliştireceğimizi biliyoruz.

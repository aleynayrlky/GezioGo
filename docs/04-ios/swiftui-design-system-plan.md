# GezioGo – SwiftUI Design System Planı

> Hafta 4 / Gün 4 çıktısı  
> Dosya amacı: GezioGo’nun marka görsel dilini SwiftUI tarafında kullanılacak renk, tipografi, buton, kart ve ortak bileşen sistemine çevirmek.

---

## 1. Amaç

GezioGo için oluşturulan marka dili şu karaktere sahiptir:

- Petrol yeşili
- Turkuaz
- Altın sarısı vurgu
- Açık krem arka plan
- Yuvarlak kartlar
- Premium şehir/turizm hissi
- Harita, rota ve keşif odaklı ikonlar

Bu görsel dil SwiftUI’da tek tek ekranlarda rastgele yazılmamalı; ortak bir design system klasörüyle yönetilmelidir.

Ana ilke:

> Tasarım kararları tek yerde tanımlanmalı, tüm ekranlar aynı bileşenleri kullanmalıdır.

---

## 2. DesignSystem Klasör Yapısı

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
├── Shadows/
│   └── AppShadow.swift
├── Components/
│   ├── AppButton.swift
│   ├── AppCard.swift
│   ├── AppTag.swift
│   ├── AppSearchBar.swift
│   ├── AppSectionHeader.swift
│   ├── EmptyStateView.swift
│   ├── LoadingView.swift
│   └── ErrorStateView.swift
└── TabBar/
    └── MainTabBarView.swift
```

---

## 3. Renk Sistemi

Önerilen renk adları:

```swift
enum AppColors {
    static let petrol = Color("Petrol")
    static let teal = Color("Teal")
    static let turquoise = Color("Turquoise")
    static let gold = Color("Gold")
    static let cream = Color("Cream")
    static let background = Color("Background")
    static let cardBackground = Color("CardBackground")
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let success = Color("Success")
    static let warning = Color("Warning")
    static let error = Color("Error")
}
```

### Renk kullanım mantığı

| Renk | Kullanım |
|---|---|
| Petrol yeşili | Ana başlıklar, tab bar aktif, ana buton |
| Turkuaz | İkincil vurgu, ikonlar, kart detayları |
| Altın sarısı | CTA, önemli vurgu, rota/pin detayları |
| Krem | Genel arka plan |
| Beyaz/kırık beyaz | Kart yüzeyleri |
| Kırmızı | Hata durumları |
| Yeşil | Başarı/onay durumları |

---

## 4. Tipografi Sistemi

```swift
enum AppTypography {
    static let largeTitle = Font.system(size: 34, weight: .bold)
    static let title = Font.system(size: 28, weight: .bold)
    static let subtitle = Font.system(size: 20, weight: .semibold)
    static let body = Font.system(size: 16, weight: .regular)
    static let bodyMedium = Font.system(size: 16, weight: .medium)
    static let caption = Font.system(size: 13, weight: .regular)
    static let small = Font.system(size: 11, weight: .regular)
}
```

### Kullanım

- Ana sayfa başlığı: `largeTitle`
- Kart başlıkları: `subtitle`
- Açıklama metinleri: `body`
- Etiketler ve küçük bilgiler: `caption`

---

## 5. Spacing Sistemi

```swift
enum AppSpacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}
```

---

## 6. Radius Sistemi

```swift
enum AppRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 14
    static let large: CGFloat = 20
    static let xlarge: CGFloat = 28
}
```

GezioGo’da kartlar ve butonlar yuvarlak hatlı olmalıdır.

---

## 7. AppButton

Buton tipleri:

- Primary
- Secondary
- Outline
- Ghost

Örnek kullanım:

```swift
AppButton(
    title: "Rota Oluştur",
    style: .primary,
    action: {}
)
```

### Primary Button

Kullanım:

- Rota Oluştur
- Keşfetmeye Başla
- Kaydet
- Devam Et

Renk:

```text
Petrol → Turkuaz gradient veya petrol zemin + gold vurgu
```

---

## 8. AppCard

Kart tipleri:

- PlaceCard
- EventCard
- RouteCard
- InfoCard
- StatCard

Tüm kartlarda ortak özellikler:

- Yuvarlak köşe
- Hafif gölge
- Krem/beyaz zemin
- Görsel varsa üstte veya solda
- Kısa açıklama
- Etiketler
- Favori veya aksiyon ikonu

---

## 9. AppTag

Etiket örnekleri:

```text
Ücretsiz
Çocukla Uygun
Kapalı Alan
Öğrenci Dostu
Tarihi
Müze
Doğa
```

Tag renkleri kategoriye göre değişebilir ama çok renk karmaşası olmamalıdır.

---

## 10. Empty / Loading / Error State

Ortak durum bileşenleri:

```text
EmptyStateView
LoadingView
ErrorStateView
```

Örnek mesajlar:

- Henüz favorin yok.
- Senin için en iyi rotayı hazırlıyoruz.
- Bağlantını kontrol et.
- Rota oluşturulamadı.
- Bugün etkinlik bulunamadı.

Bu bileşenler tüm ekranlarda ortak kullanılmalıdır.

---

## 11. Tab Bar

Alt tab bar önerisi:

```text
Ana Sayfa | Keşfet | Planla | Favoriler | Profil
```

Aktif sekme:

- Petrol veya turkuaz ikon
- Altın vurgu noktası kullanılabilir

Pasif sekme:

- Gri ikon
- Kısa metin

---

## 12. Component Öncelikleri

İlk geliştirme için zorunlu bileşenler:

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

AI rota için sonra:

```text
RouteStopCard
RouteSummaryCard
PreferenceChip
```

---

## 13. Sonuç

GezioGo tasarım sistemi, uygulamanın profesyonel ve tutarlı görünmesini sağlar.

Ana ilke:

> Her ekran aynı renk, tipografi, boşluk, kart ve buton dilini kullanmalıdır.

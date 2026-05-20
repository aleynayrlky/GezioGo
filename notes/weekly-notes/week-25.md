# GezioGo – Hafta 25 Özeti

> Ana konu: Ana tab bar yapısının güncellenmesi, ortadaki Planla/AI butonunun eklenmesi, aktif şehir mantığının netleştirilmesi ve Profil üzerinden şehir değiştirme akışı.

---

## 1. Haftanın Ana Amacı

25. haftada GezioGo’nun ana uygulama omurgası yeniden düzenlendi.

24 haftalık geliştirme sonunda uygulamada güçlü bir mock-data şehir rehberi altyapısı oluşmuştu. Bu hafta ise hedef görseller ve yeni ürün kararları doğrultusunda tab bar yapısı değiştirildi.

Yeni ana tab yapısı şu şekilde belirlendi:

```text
Ana Sayfa
Keşfet
Planla
Favoriler
Profil
```

Bu hafta alınan en önemli ürün kararı:

```text
Ortadaki büyük GezioGo logolu tab, AI ile rota planlama ekranına gidecek.
```

Ayrıca şehir kapsamı da netleştirildi:

```text
Ana Sayfa → aktif şehir
Keşfet → aktif şehir
Hazır rotalar → aktif şehir
Etkinlik bölümleri → aktif şehir
Haritada keşfet → aktif şehir
Planla → aktif şehirden bağımsız, kendi şehir seçimini yapacak
Favoriler → şimdilik mevcut yapıda, ileride tüm şehirlerden kayıtları gösterebilir
Profil → aktif şehir ve ayarlar
```

---

## 2. Bu Hafta Yapılanlar

## Gün 1 – Mevcut Tab Yapısı Envanteri

Kontrol edilen dosyalar:

```text
MainTabBarView.swift
MainTab.swift
AppRoute.swift
RootView.swift
```

Mevcut tab yapısı incelendi:

```text
home → HomeView
explore → ExploreView
map → MapExploreView
favorites → FavoritesView
profile → ProfileView
```

Yeni ürün kararına göre çıkan sonuç:

```text
home kalacak
explore kalacak
map tab’dan çıkacak
favorites kalacak
profile kalacak
planner eklenecek
```

Önemli karar:

```text
MapExploreView silinmeyecek.
Sadece ana tab’dan çıkarılacak.
İleride Keşfet içindeki “Haritada Gör” akışıyla açılacak.
```

Günün sonucu:

> Mevcut tab yapısı analiz edildi ve `.map` yerine `.planner` eklenmesine karar verildi.

---

## Gün 2 – MainTab İçinde Planner Tabına Geçiş

Güncellenen dosyalar:

```text
MainTab.swift
MainTabBarView.swift
```

Yapılanlar:

- `MainTab` içinden `.map` kaldırıldı.
- Yerine `.planner` eklendi.
- Tab başlığı `Planla` olarak belirlendi.
- Planner iconu için geçici olarak `wand.and.stars` kullanıldı.
- `MainTabBarView` içinde `mapPath` yerine `plannerPath` eklendi.
- `MapExploreView(cityId:)` tab bloğu çıkarıldı.
- Yerine geçici `AIPlannerPlaceholderView(cityId:)` eklendi.

Yeni MainTab yapısı:

```swift
enum MainTab: Hashable {
    case home
    case explore
    case planner
    case favorites
    case profile
}
```

Günün sonucu:

> Harita tabı kaldırıldı ve yerine Planla tabı eklendi.

---

## Gün 3 – Ortadaki Büyük Planla Tab Butonu

Güncellenen dosya:

```text
MainTabBarView.swift
```

Yapılanlar:

- Native `TabView` tab bar görünümü gizlendi.
- Kendi özel custom tab bar yapısı oluşturuldu.
- Ortadaki `Planla` tabı büyük ve dışarı taşan buton olarak tasarlandı.
- GezioGo logosu Assets içine eklendi.
- Ortadaki Planla butonunda GezioGo logosu kullanılmaya başlandı.
- Native tab bar kalıntısı gizlendi.
- Tab bar yüksekliği küçültüldü.
- Beyaz tab bar alanının fazla büyümesi engellendi.
- Planla butonunun dışarı taşması sağlandı.

Eklenen asset:

```text
Assets.xcassets
└── gezioGoLogo
```

Logo kullanım örneği:

```swift
Image("gezioGoLogo")
    .resizable()
    .scaledToFit()
    .frame(width: 42, height: 42)
    .clipShape(Circle())
```

Görsel karar:

```text
Beyaz tab bar normal yükseklikte kalacak.
Ortadaki logo butonu yukarı taşacak.
Planla, uygulamanın ana AI aksiyonu olarak vurgulanacak.
```

Günün sonucu:

> Ortasında GezioGo logolu büyük Planla butonu bulunan custom tab bar çalışır hale getirildi.

---

## Gün 4 – Aktif Şehir Yapısı ve Kalıcı Şehir Seçimi

Kontrol edilen / güncellenen dosyalar:

```text
AppState.swift
RootView.swift
CitySelectionView.swift
CitySelectionViewModel.swift
```

Yapılanlar:

- Mevcut şehir seçimi yapısı incelendi.
- `RootView` içinde şehir seçiminin `MainTabBarView(cityId:)` içine taşındığı doğrulandı.
- `AppState` içinde `selectedCityId` ve `hasSeenOnboarding` değerlerinin yalnızca RAM’de tutulduğu görüldü.
- Bu değerler `UserDefaults` ile kalıcı hale getirildi.
- Onboarding tamamlandıktan sonra tekrar görünmemesi sağlandı.
- Şehir seçildikten sonra uygulama tekrar açıldığında doğrudan ana uygulamaya geçmesi sağlandı.

Güncellenen AppState mantığı:

```swift
final class AppState: ObservableObject {
    @Published var hasSeenOnboarding: Bool
    @Published var selectedCityId: String?

    private enum Keys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
        static let selectedCityId = "selectedCityId"
    }

    init() {
        self.hasSeenOnboarding = UserDefaults.standard.bool(forKey: Keys.hasSeenOnboarding)
        self.selectedCityId = UserDefaults.standard.string(forKey: Keys.selectedCityId)
    }

    func completeOnboarding() {
        hasSeenOnboarding = true
        UserDefaults.standard.set(true, forKey: Keys.hasSeenOnboarding)
    }

    func selectCity(_ city: City) {
        selectedCityId = city.id
        UserDefaults.standard.set(city.id, forKey: Keys.selectedCityId)
    }

    func resetCitySelection() {
        selectedCityId = nil
        UserDefaults.standard.removeObject(forKey: Keys.selectedCityId)
    }
}
```

RootView yönlendirme kararı:

```text
Onboarding görülmediyse → Onboarding
Onboarding görülmüş ama şehir seçilmemişse → CitySelection
Onboarding görülmüş ve şehir seçilmişse → Main
```

Günün sonucu:

> Onboarding ve seçili şehir kalıcı hale getirildi.

---

## Gün 5 – Planla Ekranının Bağımsız Şehir Mantığı ve Şehir Değiştirme Akışı

Güncellenen / kontrol edilen dosyalar:

```text
MainTabBarView.swift
RootView.swift
ProfileView.swift
AppState.swift
```

Yapılan ürün kararı:

```text
Planla ekranı aktif şehre kilitli olmayacak.
Planla ekranı kendi şehir seçimini yapacak.
Aktif şehir sadece varsayılan başlangıç değeri olabilir.
```

Örnek davranış:

```text
Aktif şehir: Samsun
Ana Sayfa: Samsun içerikleri
Keşfet: Samsun içerikleri
Planla: Kullanıcı İstanbul seçip İstanbul rotası oluşturabilir
```

Kullanıcı şehir değiştirmek isterse ne olacak sorusu çözüldü:

```text
Profil ekranına “Şehri değiştir” aksiyonu eklendi.
```

Eklenen akış:

```text
Profil
↓
Şehri değiştir
↓
RootView
↓
appState.resetCitySelection()
↓
CitySelectionView
↓
Yeni şehir seçimi
↓
MainTabBarView
```

MainTabBarView’e eklenen closure mantığı:

```swift
MainTabBarView(
    cityId: selectedCityId,
    onChangeCity: {
        appState.resetCitySelection()
        withAnimation {
            launchState = .citySelection
        }
    }
)
```

ProfileView içinde karar:

```text
Seçili şehir kartına “Şehri değiştir” butonu eklendi.
```

Günün sonucu:

> Planla ekranının şehirden bağımsız çalışacağı netleşti ve kullanıcı için Profil’den şehir değiştirme akışı eklendi.

---

## Gün 6 – Tab Akış Genel Testi

Test edilen alanlar:

```text
Splash
Onboarding
CitySelection
MainTabBarView
Ana Sayfa
Keşfet
Planla
Favoriler
Profil
Profil’den şehir değiştirme
```

Kontrol edilenler:

- İlk açılışta onboarding ve şehir seçimi geliyor mu?
- Şehir seçilince ana uygulama açılıyor mu?
- Uygulama yeniden açılınca onboarding tekrar çıkmıyor mu?
- Şehir seçimi tekrar zorunlu olmuyor mu?
- Tab bar’da doğru 5 tab görünüyor mu?
- Ortadaki GezioGo logolu Planla butonu düzgün mü?
- Altta ikinci native tab bar kalıntısı yok mu?
- Tab bar sayfa içeriğini fazla kapatıyor mu?
- Ana Sayfa çalışıyor mu?
- Keşfet çalışıyor mu?
- Planla placeholder çalışıyor mu?
- Favoriler çalışıyor mu?
- Profil çalışıyor mu?
- Profil’den Şehri değiştir akışı çalışıyor mu?

Günün sonucu:

> Yeni tab bar, kalıcı şehir seçimi ve Profil’den şehir değiştirme akışı genel olarak test edildi.

---

## Gün 7 – Haftalık Kontrol

Yapılanlar:

- 25. haftanın tüm kararları gözden geçirildi.
- Tab bar yapısı kontrol edildi.
- `.map` yerine `.planner` kararının uygulandığı doğrulandı.
- Ortadaki Planla butonunun GezioGo logosu ile çalıştığı doğrulandı.
- Native tab bar kalıntısının kaldırıldığı kontrol edildi.
- Tab bar yüksekliğinin daha kompakt hale getirildiği kontrol edildi.
- AppState içinde şehir ve onboarding bilgisinin kalıcı hale getirildiği kontrol edildi.
- RootView yönlendirme mantığı kontrol edildi.
- Profil’den şehir değiştirme akışı kontrol edildi.
- Planla ekranının aktif şehirden bağımsız olacağı ürün kararı kaydedildi.
- `week-25.md` dosyası hazırlandı.

Günün sonucu:

> 25. hafta sonunda GezioGo’nun ana navigasyon omurgası yeni ürün kararlarına göre güncellendi.

---

## 3. Yeni Ana Navigasyon Yapısı

Yeni tab bar:

```text
Ana Sayfa | Keşfet | Planla | Favoriler | Profil
```

Tab davranışları:

```text
Ana Sayfa → aktif şehir
Keşfet → aktif şehir
Planla → bağımsız şehir seçimi
Favoriler → kayıtlı içerikler
Profil → kullanıcı ve şehir ayarları
```

Harita kararı:

```text
Harita artık ana tab değil.
Keşfet içindeki Haritada Gör akışına taşınacak.
```

Etkinlik kararı:

```text
Etkinlikler ana tab değil.
Ana Sayfa ve Keşfet içinde bölüm/kategori olarak yer alacak.
```

---

## 4. Oluşan / Güncellenen Ana Akışlar

### İlk Açılış Akışı

```text
Splash
↓
Onboarding
↓
CitySelection
↓
MainTabBarView
```

### Sonraki Açılış Akışı

```text
Splash
↓
MainTabBarView
```

Çünkü:

```text
hasSeenOnboarding = true
selectedCityId != nil
```

### Şehir Değiştirme Akışı

```text
Profil
↓
Şehri değiştir
↓
resetCitySelection()
↓
CitySelectionView
↓
Yeni şehir seçimi
↓
MainTabBarView
```

### Planla Akışı

```text
Ortadaki GezioGo butonu
↓
Planla tabı
↓
AIPlannerPlaceholderView
```

İleride:

```text
AIPlannerView(defaultCityId: cityId)
↓
Kullanıcı istediği şehri seçer
↓
AI rota oluşturur
```

---

## 5. Güncellenen Dosyalar

```text
MainTab.swift
MainTabBarView.swift
AppState.swift
RootView.swift
ProfileView.swift
Assets.xcassets/gezioGoLogo
```

Kontrol edilen dosyalar:

```text
CitySelectionView.swift
CitySelectionViewModel.swift
AppRoute.swift
```

---

## 6. Teknik Kararlar

Bu hafta alınan teknik kararlar:

- Native TabView tab bar yerine custom tab bar kullanılacak.
- Ortadaki Planla butonu özel ve büyük olacak.
- Planla butonunda GezioGo logosu kullanılacak.
- `.map` ana tab’dan çıkarılacak.
- `.planner` ana tab olarak eklenecek.
- MapExploreView korunacak ama Keşfet içinden açılacak.
- Onboarding ve şehir seçimi UserDefaults ile kalıcı tutulacak.
- Planla ekranı aktif şehre kilitli olmayacak.
- Profil üzerinden şehir değiştirme akışı olacak.

---

## 7. Şu An Çalışan Özellikler

- Yeni 5 tab yapısı
- Custom compact tab bar
- Ortada GezioGo logolu Planla butonu
- Native tab bar kalıntısının gizlenmesi
- Kalıcı onboarding durumu
- Kalıcı seçili şehir
- Profil’den şehir değiştirme akışı
- Planla placeholder ekranı
- Ana Sayfa / Keşfet / Favoriler / Profil tab geçişleri

---

## 8. Bilinen Eksikler

Şu işler henüz yapılmadı:

- Gerçek AIPlannerView
- Gerçek AI rota formu
- Planla ekranında bağımsız şehir seçimi UI
- AI rota sonucu ekranı
- AI rota kaydetme
- Keşfet içinden MapExploreView açma
- Ana Sayfa üst şehir seçici
- Favorilerde şehir filtreleme
- Profil ekranında daha gelişmiş kullanıcı tercihleri

---

## 9. 26. Haftaya Hazırlık

26. haftanın önerilen ana konusu:

```text
Ana Sayfa ve Keşfet’i aktif şehre bağlama
```

Önerilen işler:

```text
HomeView içinde aktif şehir başlığı
Ana sayfada öne çıkan etkinlikler bölümü
Home içeriklerinin cityId ile net filtrelenmesi
Explore içeriklerinin cityId ile net filtrelenmesi
MapExploreView’in tab’dan çıkarıldığı için Keşfet içinden açılması
```

Alternatif olarak doğrudan AI Planla formuna geçilebilir, ancak önerilen sıra:

```text
Önce aktif şehir yapısını Home / Explore tarafında netleştir.
Sonra AI Planla formuna geç.
```

---

## 10. Kısa Sonuç

25. hafta sonunda GezioGo’nun ana navigasyon yapısı yeni ürün vizyonuna göre güncellendi.

Bu haftanın ana sonucu:

> GezioGo artık ortasında AI ile rota planlama aksiyonunu vurgulayan GezioGo logolu özel tab bar’a sahip. Seçili şehir kalıcı hale geldi ve kullanıcı Profil üzerinden şehir değiştirebilir.

# GezioGo – Proje Yol Haritası

> Proje tanımı: **GezioGo**, Swift ile geliştirilecek, yapay zekâ destekli bir akıllı şehir ve turizm rehberi mobil uygulamasıdır. İlk hedef, tek şehir üzerinden çalışan güçlü bir MVP çıkarmak; uzun vadede belediye paneli, kurum iş birlikleri, çoklu şehir, gelişmiş AI özellikleri ve gelir modeli olan bir dijital turizm platformuna dönüşmektir.

---

## 1. Projeyi Anlama ve Ana Strateji

Bu proje basit bir “gezilecek yerler listesi” uygulaması değildir. Asıl değer önerisi şudur:

> Kullanıcının bulunduğu veya gitmek istediği şehri; zamanına, bütçesine, ilgi alanlarına, ulaşım durumuna, hava koşullarına ve kişisel ihtiyaçlarına göre planlayan yapay zekâ destekli şehir asistanı.

Bu yüzden projeyi geliştirirken üç katmanlı düşünmek gerekir:

1. **İçerik katmanı**
   - Şehirler
   - Mekânlar
   - Müzeler
   - Doğa alanları
   - Restoran/kafe önerileri
   - Etkinlikler
   - Bilet bağlantıları
   - Açılış saatleri
   - Fiyatlar
   - Ulaşım bilgileri
   - Görseller

2. **Uygulama katmanı**
   - SwiftUI arayüzleri
   - Harita
   - Konum
   - Favoriler
   - Arama
   - Filtreleme
   - Kullanıcı profili
   - Rota ekranları
   - Etkinlik detayları
   - Bildirimler

3. **Akıllı asistan katmanı**
   - Gezi planı oluşturma
   - “Bugün ne yapabilirim?” önerileri
   - Bütçeye göre rota
   - Yağmurlu hava alternatifi
   - Çocuklu/aile/öğrenci/engelli dostu filtreler
   - Çok dilli şehir rehberi
   - Sesli rehber
   - Görselden yer tanıma

İlk aşamada bu üç katmanın hepsinin küçük ama çalışan bir versiyonu yapılmalıdır. Yani proje başlangıçta çok büyük değil, kontrollü ve düzenli bir MVP olarak kurulmalıdır.

---

## 2. MVP Kapsamı

İlk sürüm için önerilen şehir: **Samsun**

İlk sürümde Türkiye geneli hedeflenmemelidir. Tek şehir ile başlanmalı, veri modeli ve uygulama mimarisi ileride başka şehirler eklenebilecek şekilde tasarlanmalıdır.

### 2.1 MVP’de Olacak Özellikler

- Şehir ana sayfası
- Kategori listeleri
  - Gezilecek Yerler
  - Müzeler
  - Doğa ve Yeşil Alanlar
  - Yeme İçme
  - Etkinlikler
- Mekân detay sayfası
- Etkinlik detay sayfası
- Haritada gösterme
- Favorilere ekleme
- Basit arama
- Basit filtreleme
- AI gezi planı oluşturma
- Bilet bağlantısına yönlendirme
- Yerel JSON veya Firestore üzerinden veri okuma

### 2.2 MVP’de Olmayacak Özellikler

Bunlar sonraki sürümlere bırakılmalıdır:

- Uygulama içi bilet satışı
- Belediye paneli
- İşletme paneli
- Kullanıcı yorumları
- Gelişmiş öneri algoritması
- Görselden yer tanıma
- AR rehber
- Çoklu şehir yönetimi
- Tam otomatik etkinlik veri çekme
- Gelişmiş analitik panel

### 2.3 MVP’nin Başarı Kriteri

MVP şu soruya cevap vermelidir:

> “Bir kullanıcı Samsun’u keşfetmek için uygulamayı açtığında, yerleri görebiliyor, detaylara ulaşabiliyor, favorilere ekleyebiliyor, haritada inceleyebiliyor ve yapay zekâdan kişisel gezi planı alabiliyor mu?”

Bu cevap evet ise MVP başarılıdır.

---

## 3. Aylık Yol Haritası

Bu plan 6 aylık bir temel geliştirme süreci olarak düşünülmüştür. Daha hızlı veya daha yavaş ilerlenebilir, ancak proje karmaşık olduğu için düzenli ve sabırlı ilerlemek daha sağlıklıdır.

---

# Ay 1 – Fikir Netleştirme, Araştırma ve Temel Planlama

## Hedef

Projeyi belirsizlikten çıkarıp net, belgelenmiş ve geliştirilebilir hale getirmek.

## Yapılacaklar

- Proje amacını tek sayfalık ürün tanımı haline getir.
- MVP kapsamını kesinleştir.
- İlk şehir olarak Samsun’u seç.
- Uygulama kategorilerini kesinleştir.
- Kullanıcı tiplerini belirle:
  - Yerli turist
  - Yabancı turist
  - Şehirde yaşayan kişi
  - Öğrenci
  - Aile
  - Engelli birey
  - Yaşlı kullanıcı
- Kullanıcı senaryoları yaz.
- Rakip uygulama araştırması yap.
- Veri kaynaklarını listele.
- Teknik mimariye karar ver.
- SwiftUI + MVVM + Firebase başlangıç mimarisini belirle.
- Proje klasör yapısını oluştur.
- GitHub reposu aç.
- README dosyasını yaz.

## Ay Sonu Çıktısı

- Net MVP dokümanı
- Kullanıcı akışları
- İlk veri şablonları
- GitHub reposu
- Klasör yapısı
- Temel proje belgeleri

---

# Ay 2 – Veri Toplama ve Tasarım

## Hedef

Uygulamada gösterilecek gerçek şehir verilerini toplamak ve ekran tasarımlarını hazırlamak.

## Yapılacaklar

- Samsun için ilk içerik listesini çıkar.
- En az şu veri adetleri hedeflenebilir:
  - 20 gezilecek yer
  - 10 müze/kültürel alan
  - 15 doğa/park/sahil alanı
  - 15 yeme-içme önerisi
  - 10 etkinlik örneği
- Her mekân için standart veri alanlarını doldur:
  - Ad
  - Kategori
  - Kısa açıklama
  - Uzun açıklama
  - Konum
  - İlçe
  - Adres
  - Açılış saatleri
  - Ücret bilgisi
  - Görsel
  - Kaynak bağlantısı
  - Erişilebilirlik bilgisi
  - Etiketler
- JSON veri formatı oluştur.
- Firestore veri modelini tasarla.
- Figma’da temel ekranları çiz:
  - Splash
  - Onboarding
  - Şehir seçimi
  - Ana sayfa
  - Kategori listesi
  - Mekân detay
  - Etkinlik detay
  - Harita
  - Favoriler
  - AI rota oluşturma formu
  - AI rota sonucu
- Uygulama renk paleti ve tipografi kararlarını ver.

## Ay Sonu Çıktısı

- İlk Samsun veri seti
- Figma tasarımları
- Veri modeli
- Firestore koleksiyon planı
- Görsel kimlik taslağı

---

# Ay 3 – SwiftUI Temel Uygulama Geliştirme

## Hedef

Uygulamanın temel ekranlarını SwiftUI ile çalışır hale getirmek.

## Yapılacaklar

- Xcode projesini oluştur.
- SwiftUI temel mimariyi kur.
- MVVM yapısını başlat.
- Ana navigation yapısını oluştur.
- Tab bar veya ana menü yapısına karar ver.
- Şehir ana sayfasını geliştir.
- Kategori kartlarını oluştur.
- Kategori liste ekranlarını geliştir.
- Mekân detay ekranını geliştir.
- Etkinlik detay ekranını geliştir.
- Mock JSON veri ile uygulamayı çalıştır.
- Görseller için geçici asset yapısını kur.
- Favorilere ekleme özelliğini local olarak başlat.
- Arama ve basit filtreleme ekle.

## Ay Sonu Çıktısı

- SwiftUI ile çalışan temel uygulama
- Mock veriyle listeleme
- Detay ekranları
- Favori mantığının ilk hali
- Temel navigasyon

---

# Ay 4 – Harita, Konum ve Firebase

## Hedef

Uygulamayı statik prototipten gerçek veri ve harita destekli MVP’ye yaklaştırmak.

## Yapılacaklar

- MapKit entegrasyonunu ekle.
- Mekânları haritada pin olarak göster.
- Mekân detayından haritaya geçiş yap.
- Kullanıcının konum iznini yönet.
- Yakınımdaki yerler mantığını basit düzeyde kur.
- Firebase projesi oluştur.
- Firestore koleksiyonlarını kur.
- Firebase Storage görsel yapısını kur.
- Verileri Firestore’dan okumaya başla.
- Favorileri Firebase veya local storage ile kaydet.
- Hata durumlarını yönet:
  - İnternet yok
  - Konum izni yok
  - Veri yüklenemedi
  - Görsel yüklenemedi
- Loading, empty state ve error state ekranlarını ekle.

## Ay Sonu Çıktısı

- Harita çalışan uygulama
- Firestore’dan veri okuyan uygulama
- Konum izni akışı
- Favori kaydetme
- Daha gerçekçi MVP yapısı

---

# Ay 5 – AI Gezi Planı Oluşturma

## Hedef

Projeyi farklılaştıran ilk yapay zekâ özelliğini eklemek.

## Yapılacaklar

- AI rota oluşturma formunu geliştir.
- Kullanıcıdan şu bilgileri al:
  - Şehir
  - Kaç gün?
  - Bütçe
  - İlgi alanları
  - Ulaşım tercihi
  - Kimlerle geziyor?
  - Başlangıç noktası
  - Kapalı/açık alan tercihi
  - Yürüyüş toleransı
  - Çocuk/engelli/yaşlı uygunluğu
- AI prompt şablonları hazırla.
- AI çıktısı için standart format belirle:
  - Sabah
  - Öğle
  - Öğleden sonra
  - Akşam
  - Alternatif plan
  - Yağmurlu hava alternatifi
  - Tahmini maliyet
  - Tahmini süre
  - Ulaşım önerisi
- AI çıktısını ekranda kartlar halinde göster.
- AI’nın sadece uygulama verisindeki yerleri önermesi için prompt güvenlik kuralları yaz.
- Kritik bilgiler için “kontrol et” uyarısı ekle.
- Rota sonucunu kaydetme özelliği ekle.
- AI rota sonucundaki mekânlara tıklanabilir bağlantı ekle.

## Ay Sonu Çıktısı

- Çalışan AI gezi planı ekranı
- Kişisel rota çıktısı
- Kaydedilebilir rota
- Uygulama verisiyle sınırlı öneri mantığı
- MVP’nin en güçlü demo özelliği

---

# Ay 6 – Test, İyileştirme, Demo ve Sunum

## Hedef

Projeyi sunulabilir, test edilebilir ve portföye koyulabilir hale getirmek.

## Yapılacaklar

- Tüm ekranları test et.
- Hataları düzelt.
- UI iyileştirmeleri yap.
- Performans kontrolleri yap.
- Boş veri durumlarını düzelt.
- Veri doğruluğunu tekrar kontrol et.
- AI çıktılarını test et.
- 10 farklı kullanıcı senaryosu dene.
- Demo videosu hazırla.
- GitHub README dosyasını güçlendir.
- Proje tanıtım metni yaz.
- Sunum dosyası için içerik hazırla.
- Belediye/yatırımcı için değer önerisini yaz.
- App Store için ileride kullanılabilecek açıklama taslağı hazırla.

## Ay Sonu Çıktısı

- Çalışan MVP
- Demo videosu
- Sunum metni
- GitHub portföy sayfası
- Proje dokümantasyonu
- Bir sonraki sürüm planı

---

## 4. Haftalık Plan

Aşağıdaki plan 24 haftalık ayrıntılı geliştirme planıdır.

---

# Hafta 1 – Proje Kimliği ve Ürün Tanımı

## Görevler

- Projenin tek cümlelik tanımını yaz.
- Hedef kitleyi netleştir.
- MVP ile uzun vadeli vizyonu ayır.
- “Bu uygulama neyi çözüyor?” sorusuna cevap yaz.
- Proje kapsam dokümanı oluştur.

## Çıktı

- `docs/product/project-overview.md`
- `docs/product/target-audience.md`
- `docs/product/mvp-scope.md`

---

# Hafta 2 – Kullanıcı Senaryoları ve Özellik Listesi

## Görevler

- Kullanıcı personlarını yaz.
- Ana kullanıcı akışlarını çıkar.
- MVP özelliklerini listele.
- Sonraya bırakılacak özellikleri listele.
- Önceliklendirme yap: Must / Should / Could / Later.

## Çıktı

- `docs/product/user-personas.md`
- `docs/product/user-flows.md`
- `docs/product/feature-prioritization.md`

---

# Hafta 3 – Teknik Mimari Kararı

## Görevler

- SwiftUI + MVVM yapısına karar ver.
- Firebase kullanılıp kullanılmayacağını netleştir.
- Veri modeli taslağı oluştur.
- Modül yapısını planla.
- GitHub repo kurallarını yaz.

## Çıktı

- `docs/technical/architecture.md`
- `docs/technical/firebase-plan.md`
- `docs/technical/coding-standards.md`

---

# Hafta 4 – Klasör Yapısı ve Proje Kurulumu

## Görevler

- Xcode projesini oluştur.
- Ana klasör yapısını kur.
- GitHub reposunu aç.
- `.gitignore` ekle.
- README başlangıç dosyasını yaz.
- Commit standardını belirle.

## Çıktı

- Çalışan boş SwiftUI projesi
- İlk commit
- Temel klasör yapısı

---

# Hafta 5 – Samsun Veri Araştırması 1

## Görevler

- Gezilecek yerler listesini çıkar.
- Müzeleri listele.
- Doğa alanlarını listele.
- Her veri için kaynak bağlantısı tut.
- Veri toplama şablonunu hazırla.

## Çıktı

- `data/raw/samsun/places_raw.md`
- `data/raw/samsun/museums_raw.md`
- `data/raw/samsun/nature_raw.md`

---

# Hafta 6 – Samsun Veri Araştırması 2

## Görevler

- Yeme-içme önerilerini araştır.
- Etkinlik kaynaklarını belirle.
- İlçe ve kategori etiketlerini standardize et.
- Görsel kaynaklarını belirle.
- Veri doğrulama notları ekle.

## Çıktı

- `data/raw/samsun/food_raw.md`
- `data/raw/samsun/events_sources.md`
- `data/processed/samsun_seed_data.json`

---

# Hafta 7 – Figma Wireframe

## Görevler

- Uygulamanın ana ekran akışını çiz.
- Şehir ana sayfasını tasarla.
- Kategori liste ekranlarını tasarla.
- Detay ekranını tasarla.
- AI form ekranını tasarla.

## Çıktı

- Figma wireframe
- `docs/design/wireframes.md`

---

# Hafta 8 – UI Tasarım Sistemi

## Görevler

- Renk paleti seç.
- Font ve yazı hiyerarşisini belirle.
- Kart tasarımlarını oluştur.
- Buton tiplerini oluştur.
- İkon kullanımını belirle.
- Empty/loading/error state tasarla.

## Çıktı

- `docs/design/design-system.md`
- Figma UI kit başlangıcı

---

# Hafta 9 – SwiftUI Navigation ve Ana Yapı

## Görevler

- App entry point düzenle.
- Navigation yapısını kur.
- Tab yapısı varsa oluştur.
- Ana ekranı başlat.
- Ortak component klasörünü oluştur.

## Çıktı

- Çalışan navigation
- Ana sayfa taslağı

---

# Hafta 10 – Model ve Mock Veri

## Görevler

- `City`, `Place`, `Event`, `Category`, `RoutePlan` modellerini yaz.
- Mock JSON dosyalarını ekle.
- JSON decode servislerini yaz.
- Liste ekranlarını mock veriyle besle.

## Çıktı

- Veri modelleri
- Mock veri sistemi
- Liste ekranları

---

# Hafta 11 – Kategori ve Liste Ekranları

## Görevler

- Gezilecek yerler listesi
- Müzeler listesi
- Doğa alanları listesi
- Yeme-içme listesi
- Etkinlik listesi
- Liste kart componentleri

## Çıktı

- Tüm kategori liste ekranları

---

# Hafta 12 – Detay Ekranları

## Görevler

- Mekân detay ekranı
- Etkinlik detay ekranı
- Görsel alanı
- Açıklama alanı
- Bilgi kartları
- Kaynak bağlantısı alanı
- Haritada göster butonu
- Favori butonu

## Çıktı

- Detay ekranlarının ilk çalışan hali

---

# Hafta 13 – Favoriler ve Local State

## Görevler

- Favori ekleme/çıkarma
- Favoriler ekranı
- Local persistence
- Favori ikon durumları
- Boş favoriler ekranı

## Çıktı

- Çalışan favori sistemi

---

# Hafta 14 – Arama ve Filtreleme

## Görevler

- Arama çubuğu
- Kategori filtresi
- Ücretsiz/ücretli filtresi
- Çocukla uygun filtresi
- Kapalı/açık alan filtresi
- Öğrenci dostu filtresi

## Çıktı

- Arama ve filtreleme sistemi

---

# Hafta 15 – MapKit Entegrasyonu

## Görevler

- Harita ekranını oluştur.
- Mekân pinlerini göster.
- Pin tıklanınca kısa bilgi kartı aç.
- Detay sayfasına geçiş ekle.
- Haritada kategori filtresi ekle.

## Çıktı

- Çalışan harita ekranı

---

# Hafta 16 – Konum Servisleri

## Görevler

- Konum izni iste.
- Kullanıcı konumunu göster.
- Yakındaki yerler mantığını başlat.
- Konum izni reddedilirse alternatif mesaj göster.
- Harita merkezleme özelliği ekle.

## Çıktı

- Konum destekli harita

---

# Hafta 17 – Firebase Kurulumu

## Görevler

- Firebase projesi aç.
- iOS uygulamasını Firebase’e bağla.
- Firestore koleksiyonlarını oluştur.
- Storage yapısını oluştur.
- İlk şehir verilerini yükle.

## Çıktı

- Firebase bağlantısı
- Firestore veri okuma hazırlığı

---

# Hafta 18 – Firestore Veri Okuma

## Görevler

- Repository katmanını yaz.
- Firestore’dan şehir verisi çek.
- Loading/error state ekle.
- Mock veri ile canlı veri arasında geçiş yapabilecek yapı kur.
- Görselleri Storage veya URL üzerinden göster.

## Çıktı

- Firestore’dan veri okuyan uygulama

---

# Hafta 19 – AI Form Ekranı

## Görevler

- AI rota oluşturma ekranını geliştir.
- Kullanıcı tercihlerini al.
- Form validasyonu yap.
- Seçim componentleri oluştur.
- Prompt input modelini hazırla.

## Çıktı

- AI rota form ekranı

---

# Hafta 20 – AI Servis Entegrasyonu

## Görevler

- AI servis katmanını oluştur.
- Prompt template yaz.
- Uygulama verisini AI bağlamına ekle.
- API key güvenliği için doğrudan client içinde saklamama prensibini planla.
- İlk AI rota çıktısını al.

## Çıktı

- AI’dan rota cevabı alan sistem

---

# Hafta 21 – AI Rota Sonuç Ekranı

## Görevler

- AI çıktısını kartlara böl.
- Sabah/öğle/akşam bölümlerini göster.
- Tahmini süre ve maliyet alanı ekle.
- Alternatif plan göster.
- Yağmurlu hava planı göster.
- Rotadaki yerlere tıklanabilir bağlantı ekle.

## Çıktı

- Kullanıcıya okunabilir AI rota sonucu

---

# Hafta 22 – Rota Kaydetme ve Paylaşma

## Görevler

- AI rota sonucunu kaydet.
- Kaydedilen rotalar ekranı oluştur.
- Basit paylaşma özelliği ekle.
- Rota geçmişi için model oluştur.
- Kullanıcı hesabı yoksa local kaydetme kullan.

## Çıktı

- Kaydedilebilir rota sistemi

---

# Hafta 23 – Test ve Düzeltme

## Görevler

- 10 kullanıcı senaryosu test et.
- Harita akışlarını test et.
- AI çıktılarını test et.
- Firebase hata durumlarını test et.
- UI taşmalarını düzelt.
- Veri eksiklerini tamamla.

## Çıktı

- Daha stabil MVP

---

# Hafta 24 – Demo, Sunum ve Dokümantasyon

## Görevler

- README güncelle.
- Demo videosu çek.
- Proje ekran görüntüleri hazırla.
- Sunum metni yaz.
- Gelecek sürüm planı yaz.
- GitHub reposunu düzenle.
- Portföy açıklaması hazırla.

## Çıktı

- Sunulabilir MVP
- Portföy projesi
- Demo materyalleri

---

## 5. Öğrenilmesi Gereken Konular

Bu proje için her şeyi baştan mükemmel bilmek gerekmez. Ancak aşağıdaki konular zamanla öğrenilmelidir.

---

## 5.1 Swift ve SwiftUI

Öğrenilecekler:

- Swift temel syntax
- Struct, class, enum
- Protocol
- Optional
- Error handling
- Async/await
- SwiftUI view yapısı
- State yönetimi
- `@State`
- `@Binding`
- `@StateObject`
- `@ObservedObject`
- `@EnvironmentObject`
- NavigationStack
- List, ScrollView, LazyVGrid
- Form yapısı
- Component oluşturma
- Preview kullanımı

---

## 5.2 Mimari

Öğrenilecekler:

- MVVM
- Repository pattern
- Service layer
- Dependency injection mantığı
- Model ayrımı
- ViewModel sorumlulukları
- Network katmanı
- Error state yönetimi
- Test edilebilir kod yazma

---

## 5.3 Firebase

Öğrenilecekler:

- Firebase proje oluşturma
- Firebase iOS SDK kurulumu
- Firestore
- Firebase Storage
- Firebase Authentication
- Firestore güvenlik kuralları
- Veri modelleme
- Query yapısı
- Offline cache mantığı
- Cloud Functions temel mantığı

---

## 5.4 Harita ve Konum

Öğrenilecekler:

- MapKit
- CoreLocation
- Kullanıcıdan konum izni alma
- Harita pinleri
- Koordinat modeli
- Mesafe hesaplama
- Harita region yönetimi
- Konum izni reddedildiğinde alternatif akış

---

## 5.5 Yapay Zekâ Entegrasyonu

Öğrenilecekler:

- API ile AI kullanımı
- Prompt engineering
- Sistem promptu
- Kullanıcı promptu
- JSON formatında çıktı isteme
- AI hallucination riskleri
- Doğrulanmış veriyle cevap üretme
- API key güvenliği
- Backend üzerinden AI çağırma
- Kullanıcı verisi gizliliği

---

## 5.6 Ürün ve Girişim

Öğrenilecekler:

- MVP mantığı
- Hedef kitle analizi
- Rakip analizi
- Değer önerisi
- Gelir modeli
- Belediye sunumu
- SaaS mantığı
- Kullanıcı geri bildirimi toplama
- Ürün yol haritası çıkarma

---

## 6. Teknik Mimari Önerisi

Başlangıç için önerilen mimari:

- iOS: SwiftUI
- Mimari: MVVM + Repository
- Veritabanı: Firestore
- Görseller: Firebase Storage veya güvenilir URL
- Auth: Firebase Authentication
- Harita: MapKit
- Konum: CoreLocation
- AI: Backend üzerinden API çağrısı
- Bildirimler: Firebase Cloud Messaging
- Admin panel: sonraki aşamada web tabanlı

---

## 7. Firestore Veri Modeli Taslağı

```text
cities
  {cityId}
    name
    slug
    country
    description
    imageUrl
    isActive
    createdAt
    updatedAt

places
  {placeId}
    cityId
    name
    slug
    categoryId
    descriptionShort
    descriptionLong
    address
    district
    latitude
    longitude
    imageUrls
    openingHours
    priceType
    priceInfo
    ticketUrl
    sourceUrl
    tags
    accessibility
    isChildFriendly
    isStudentFriendly
    isIndoor
    isOutdoor
    averageVisitDuration
    lastVerifiedAt
    createdAt
    updatedAt

events
  {eventId}
    cityId
    title
    description
    venueName
    address
    latitude
    longitude
    startDate
    endDate
    priceType
    priceInfo
    ticketUrl
    sourceUrl
    imageUrl
    category
    tags
    isChildFriendly
    lastVerifiedAt
    createdAt
    updatedAt

users
  {userId}
    displayName
    email
    selectedCityId
    interests
    createdAt
    updatedAt

users/{userId}/favorites
  {favoriteId}
    itemId
    itemType
    cityId
    createdAt

users/{userId}/savedRoutes
  {routeId}
    cityId
    title
    preferences
    routeJson
    createdAt
```

---

## 8. Swift Proje Klasör Yapısı

Aşağıdaki klasör yapısı projenin karışmaması için kritik önemdedir.

```text
SehriniTani/
│
├── SehriniTaniApp.swift
│
├── App/
│   ├── AppRouter.swift
│   ├── AppState.swift
│   ├── AppEnvironment.swift
│   └── AppConstants.swift
│
├── Core/
│   ├── Extensions/
│   │   ├── String+Extensions.swift
│   │   ├── Date+Extensions.swift
│   │   ├── Color+Extensions.swift
│   │   └── CLLocationCoordinate2D+Extensions.swift
│   │
│   ├── Utilities/
│   │   ├── Logger.swift
│   │   ├── Validator.swift
│   │   ├── DateFormatterManager.swift
│   │   └── DistanceCalculator.swift
│   │
│   ├── Constants/
│   │   ├── APIConstants.swift
│   │   ├── FirestoreCollections.swift
│   │   ├── UIConstants.swift
│   │   └── AppTexts.swift
│   │
│   └── Errors/
│       ├── AppError.swift
│       ├── NetworkError.swift
│       └── FirebaseErrorMapper.swift
│
├── DesignSystem/
│   ├── Colors/
│   │   └── AppColors.swift
│   ├── Typography/
│   │   └── AppTypography.swift
│   ├── Components/
│   │   ├── Buttons/
│   │   │   ├── PrimaryButton.swift
│   │   │   └── SecondaryButton.swift
│   │   ├── Cards/
│   │   │   ├── PlaceCard.swift
│   │   │   ├── EventCard.swift
│   │   │   └── CategoryCard.swift
│   │   ├── Inputs/
│   │   │   ├── SearchBarView.swift
│   │   │   └── FilterChip.swift
│   │   ├── States/
│   │   │   ├── LoadingView.swift
│   │   │   ├── EmptyStateView.swift
│   │   │   └── ErrorStateView.swift
│   │   └── Badges/
│   │       ├── PriceBadge.swift
│   │       └── AccessibilityBadge.swift
│   │
│   └── Modifiers/
│       ├── CardModifier.swift
│       └── ShadowModifier.swift
│
├── Models/
│   ├── City.swift
│   ├── Place.swift
│   ├── Event.swift
│   ├── Category.swift
│   ├── User.swift
│   ├── Favorite.swift
│   ├── RoutePlan.swift
│   ├── RoutePreference.swift
│   ├── AccessibilityInfo.swift
│   ├── OpeningHours.swift
│   └── PriceInfo.swift
│
├── Features/
│   │
│   ├── Onboarding/
│   │   ├── Views/
│   │   │   └── OnboardingView.swift
│   │   └── ViewModels/
│   │       └── OnboardingViewModel.swift
│   │
│   ├── CitySelection/
│   │   ├── Views/
│   │   │   └── CitySelectionView.swift
│   │   └── ViewModels/
│   │       └── CitySelectionViewModel.swift
│   │
│   ├── Home/
│   │   ├── Views/
│   │   │   ├── HomeView.swift
│   │   │   └── HomeCategorySection.swift
│   │   └── ViewModels/
│   │       └── HomeViewModel.swift
│   │
│   ├── Places/
│   │   ├── Views/
│   │   │   ├── PlaceListView.swift
│   │   │   ├── PlaceDetailView.swift
│   │   │   └── PlaceFilterView.swift
│   │   └── ViewModels/
│   │       ├── PlaceListViewModel.swift
│   │       └── PlaceDetailViewModel.swift
│   │
│   ├── Events/
│   │   ├── Views/
│   │   │   ├── EventListView.swift
│   │   │   └── EventDetailView.swift
│   │   └── ViewModels/
│   │       ├── EventListViewModel.swift
│   │       └── EventDetailViewModel.swift
│   │
│   ├── Map/
│   │   ├── Views/
│   │   │   ├── CityMapView.swift
│   │   │   └── MapPlacePreviewCard.swift
│   │   └── ViewModels/
│   │       └── CityMapViewModel.swift
│   │
│   ├── Favorites/
│   │   ├── Views/
│   │   │   └── FavoritesView.swift
│   │   └── ViewModels/
│   │       └── FavoritesViewModel.swift
│   │
│   ├── AIRoutePlanner/
│   │   ├── Views/
│   │   │   ├── AIRouteFormView.swift
│   │   │   ├── AIRouteResultView.swift
│   │   │   └── AIRouteDaySectionView.swift
│   │   ├── ViewModels/
│   │   │   ├── AIRouteFormViewModel.swift
│   │   │   └── AIRouteResultViewModel.swift
│   │   └── Prompts/
│   │       ├── RoutePlannerPrompt.swift
│   │       └── PromptRules.swift
│   │
│   ├── SavedRoutes/
│   │   ├── Views/
│   │   │   ├── SavedRoutesView.swift
│   │   │   └── SavedRouteDetailView.swift
│   │   └── ViewModels/
│   │       └── SavedRoutesViewModel.swift
│   │
│   └── Profile/
│       ├── Views/
│       │   └── ProfileView.swift
│       └── ViewModels/
│           └── ProfileViewModel.swift
│
├── Services/
│   ├── Firebase/
│   │   ├── FirebaseManager.swift
│   │   ├── FirestoreService.swift
│   │   ├── FirebaseStorageService.swift
│   │   └── FirebaseAuthService.swift
│   │
│   ├── Location/
│   │   └── LocationService.swift
│   │
│   ├── Map/
│   │   └── MapService.swift
│   │
│   ├── AI/
│   │   ├── AIService.swift
│   │   ├── AIRequestBuilder.swift
│   │   └── AIResponseParser.swift
│   │
│   ├── Network/
│   │   ├── NetworkClient.swift
│   │   └── Endpoint.swift
│   │
│   └── Storage/
│       ├── LocalStorageService.swift
│       └── FavoritesStorageService.swift
│
├── Repositories/
│   ├── CityRepository.swift
│   ├── PlaceRepository.swift
│   ├── EventRepository.swift
│   ├── FavoriteRepository.swift
│   ├── RouteRepository.swift
│   └── UserRepository.swift
│
├── Resources/
│   ├── Assets.xcassets/
│   ├── Localizable.xcstrings
│   ├── MockData/
│   │   ├── cities_mock.json
│   │   ├── samsun_places_mock.json
│   │   ├── samsun_events_mock.json
│   │   └── route_plan_mock.json
│   └── Config/
│       ├── Debug.xcconfig
│       └── Release.xcconfig
│
├── Preview Content/
│   └── PreviewAssets.xcassets
│
└── Tests/
    ├── ViewModelTests/
    ├── RepositoryTests/
    ├── ServiceTests/
    └── MockHelpers/
```

---

## 9. Dokümantasyon Klasör Yapısı

Kod kadar dokümantasyon da düzenli tutulmalıdır.

```text
docs/
│
├── product/
│   ├── project-overview.md
│   ├── mvp-scope.md
│   ├── target-audience.md
│   ├── user-personas.md
│   ├── user-flows.md
│   ├── feature-prioritization.md
│   └── roadmap.md
│
├── design/
│   ├── wireframes.md
│   ├── design-system.md
│   ├── screen-list.md
│   └── ui-notes.md
│
├── technical/
│   ├── architecture.md
│   ├── folder-structure.md
│   ├── firebase-plan.md
│   ├── data-model.md
│   ├── ai-integration.md
│   ├── mapkit-plan.md
│   └── coding-standards.md
│
├── data/
│   ├── data-sources.md
│   ├── data-validation-rules.md
│   └── samsun-content-plan.md
│
├── business/
│   ├── revenue-model.md
│   ├── municipality-pitch.md
│   ├── competitor-analysis.md
│   └── partnership-plan.md
│
└── release/
    ├── mvp-checklist.md
    ├── testing-checklist.md
    ├── known-issues.md
    └── release-notes.md
```

---

## 10. Veri Klasör Yapısı

Şehir verileri koddan ayrı tutulmalıdır.

```text
data/
│
├── raw/
│   └── samsun/
│       ├── places_raw.md
│       ├── museums_raw.md
│       ├── nature_raw.md
│       ├── food_raw.md
│       ├── events_raw.md
│       └── sources.md
│
├── processed/
│   └── samsun/
│       ├── places.json
│       ├── events.json
│       ├── categories.json
│       └── city.json
│
├── images/
│   └── samsun/
│       ├── places/
│       ├── events/
│       └── city/
│
└── templates/
    ├── place-template.json
    ├── event-template.json
    └── city-template.json
```

---

## 11. AI Prompt Klasör Yapısı

AI promptları kod içine dağınık yazılmamalıdır.

```text
ai/
│
├── prompts/
│   ├── route-planner-system-prompt.md
│   ├── route-planner-user-template.md
│   ├── today-suggestion-prompt.md
│   ├── rainy-day-alternative-prompt.md
│   └── translation-prompt.md
│
├── schemas/
│   ├── route-plan-response.schema.json
│   ├── suggestion-response.schema.json
│   └── assistant-message.schema.json
│
├── examples/
│   ├── one-day-samsun-route.json
│   ├── two-day-family-route.json
│   └── student-budget-route.json
│
└── safety/
    ├── ai-grounding-rules.md
    ├── hallucination-prevention.md
    └── source-citation-rules.md
```

---

## 12. Git Branch ve Commit Düzeni

## Branch Yapısı

```text
main
develop
feature/home-screen
feature/place-detail
feature/mapkit
feature/firebase
feature/ai-route-planner
bugfix/favorites-state
release/mvp-1.0
```

## Commit Örnekleri

```text
feat: add home category cards
feat: implement place detail screen
fix: resolve map pin selection issue
docs: add MVP scope document
refactor: separate place repository from service
chore: update mock Samsun data
```

---

## 13. Ekran Listesi

MVP için temel ekranlar:

1. Splash Screen
2. Onboarding Screen
3. City Selection Screen
4. Home Screen
5. Category List Screen
6. Place List Screen
7. Place Detail Screen
8. Event List Screen
9. Event Detail Screen
10. Map Screen
11. Favorites Screen
12. AI Route Form Screen
13. AI Route Result Screen
14. Saved Routes Screen
15. Profile / Settings Screen

---

## 14. MVP Kontrol Listesi

MVP tamamlandı sayılması için:

- [ ] Uygulama açılıyor.
- [ ] Samsun şehir sayfası görüntüleniyor.
- [ ] Kategoriler listeleniyor.
- [ ] Mekânlar listeleniyor.
- [ ] Mekân detayı açılıyor.
- [ ] Etkinlikler listeleniyor.
- [ ] Etkinlik detayı açılıyor.
- [ ] Harita ekranında pinler görünüyor.
- [ ] Favori ekleme çalışıyor.
- [ ] Favoriler ekranı çalışıyor.
- [ ] Arama çalışıyor.
- [ ] Temel filtreler çalışıyor.
- [ ] AI rota formu çalışıyor.
- [ ] AI rota sonucu gösteriliyor.
- [ ] AI rota kaydedilebiliyor.
- [ ] Veri kaynağı alanı gösteriliyor.
- [ ] Hata durumları yönetiliyor.
- [ ] README güncel.
- [ ] Demo videosu hazır.

---

## 15. Riskler ve Önlemler

## 15.1 Projenin Büyüyüp Kontrolden Çıkması

Risk: Çok fazla özellik eklenirse MVP bitmez.

Önlem:

- İlk şehir sadece Samsun.
- İlk AI özelliği sadece gezi planı.
- Belediye paneli sonra.
- Uygulama içi bilet satışı sonra.

## 15.2 Veri Güncelliği

Risk: Açılış saatleri, fiyatlar ve etkinlikler değişebilir.

Önlem:

- Son güncelleme tarihi göster.
- Resmi kaynak bağlantısı ekle.
- Kullanıcıya “bilgiyi doğrula” butonu sun.
- Kritik bilgileri kesin ifade etme.

## 15.3 AI Yanlış Bilgi Verebilir

Risk: AI olmayan yerleri önerebilir veya yanlış saat/fiyat yazabilir.

Önlem:

- AI sadece veritabanındaki yerleri kullansın.
- Promptta açık kural yaz.
- Cevapta kaynak/uyarı göster.
- Açılış saati ve fiyat gibi alanları uygulama verisinden çek.

## 15.4 Kodun Dağılması

Risk: Büyük proje olduğu için dosyalar karışabilir.

Önlem:

- Feature bazlı klasör yapısı kullan.
- View, ViewModel, Model, Service, Repository ayrımını koru.
- Ortak componentleri DesignSystem altında tut.
- Her yeni özellik için ayrı branch aç.

## 15.5 API Key Güvenliği

Risk: AI API key doğrudan iOS uygulamasına konursa sızabilir.

Önlem:

- AI çağrılarını backend veya Cloud Function üzerinden yap.
- Client içinde gizli key saklama.
- Firebase security rules kullan.
- Rate limit planla.

---

## 16. Sonraki Sürümler

## Sürüm 1.1

- Kullanıcı hesabı
- Firebase Auth
- Kaydedilen rotalar
- Profil tercihleri
- Bildirim altyapısı

## Sürüm 1.2

- Takvime etkinlik ekleme
- Daha gelişmiş filtreleme
- “Bugün ne yapabilirim?” asistanı
- Hava durumu entegrasyonu

## Sürüm 2.0

- Çoklu şehir desteği
- Belediye paneli
- Etkinlik yönetimi
- İçerik yönetimi
- Kurumsal kullanıcı rolleri

## Sürüm 3.0

- Çoklu dil desteği
- Sesli şehir rehberi
- Görselden yer tanıma
- Kişiselleştirilmiş öneri sistemi
- Turizm analitik paneli

---

## 17. İlk Başlanacak Dosyalar

Projeye başlarken ilk oluşturulacak dosyalar:

```text
README.md
docs/product/project-overview.md
docs/product/mvp-scope.md
docs/product/user-personas.md
docs/product/user-flows.md
docs/technical/architecture.md
docs/technical/folder-structure.md
docs/technical/data-model.md
docs/design/screen-list.md
data/templates/place-template.json
data/templates/event-template.json
data/raw/samsun/places_raw.md
```

---

## 18. İlk 10 Somut Adım

1. GitHub reposu aç.
2. README dosyasını oluştur.
3. MVP kapsamını yaz.
4. Klasör yapısını oluştur.
5. SwiftUI projesini aç.
6. Mock JSON veri şablonlarını hazırla.
7. Samsun için ilk 10 mekânı topla.
8. Ana ekranın Figma wireframe’ini çiz.
9. SwiftUI ana sayfa ekranını oluştur.
10. İlk kategori liste ekranını mock veriyle çalıştır.

---

## 19. Proje İçin Ana İlke

Bu projede en önemli kural:

> Her şeyi bir anda yapmaya çalışma. Önce küçük, temiz, çalışan ve genişletilebilir bir çekirdek oluştur.

İlk hedef mükemmel uygulama değildir. İlk hedef şudur:

> Samsun için çalışan, düzenli kodlanmış, harita destekli ve AI rota oluşturabilen bir MVP.

Bu temel sağlam kurulursa proje daha sonra çoklu şehir, belediye paneli, bilet entegrasyonu, sesli rehber ve gelişmiş yapay zekâ özellikleriyle büyütülebilir.

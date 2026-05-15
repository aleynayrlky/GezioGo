# GezioGo – Veri Modeli Genel Bakış

> Hafta 3 / Gün 1 çıktısı  
> Dosya amacı: GezioGo’da kullanılacak temel veri tiplerini ve bu veri tiplerinin birbirleriyle ilişkisini tanımlamak.

---

## 1. Genel Amaç

GezioGo; mobil uygulama, AI rota sistemi ve yönetim paneli olan çok katmanlı bir şehir keşif platformudur.

Bu nedenle veri modeli yalnızca mobil uygulamayı değil, aynı zamanda şu alanları da desteklemelidir:

- Şehir seçimi
- Mekan listeleme
- Etkinlik listeleme
- Mekan detayları
- Harita gösterimi
- Favoriler
- AI rota oluşturma
- Panel üzerinden içerik girişi
- Kurum / işletme / iş ortağı yönetimi
- İçerik onay süreci

Ana ilke:

> Tek veri modeli, hem mobil uygulamayı hem paneli hem de AI servislerini beslemelidir.

---

## 2. Ana Veri Tipleri

GezioGo’nun temel veri tipleri şunlardır:

```text
City
Place
Event
User
Route
Partner
ContentStatus
MediaAsset
```

### 2.1 City

Şehir bilgisini temsil eder. Örneğin Samsun, İstanbul, Ordu.

Kullanıldığı yerler:

- Şehir seçimi
- Ana sayfa
- Şehir bazlı mekanlar
- Şehir bazlı etkinlikler
- Şehir bazlı panel yetkileri

---

### 2.2 Place

Mekan, tarihi alan, müze, doğa alanı, restoran, kafe gibi kullanıcıya gösterilecek fiziksel yerleri temsil eder.

Kullanıldığı yerler:

- Mekan listesi
- Mekan detay ekranı
- Harita pinleri
- AI rota durakları
- Favoriler
- Panel içerik yönetimi

---

### 2.3 Event

Konser, festival, sergi, tiyatro, atölye, çocuk etkinliği gibi tarih/saat bazlı içerikleri temsil eder.

Kullanıldığı yerler:

- Etkinlik listesi
- Etkinlik detay ekranı
- Bilet linki yönlendirme
- AI rota önerileri
- Panel etkinlik yönetimi

---

### 2.4 User

Mobil uygulama kullanıcısını veya panel kullanıcısını temsil eder.

Kullanıldığı yerler:

- Kullanıcı hesabı
- Favoriler
- Kaydedilen rotalar
- İlgi alanları
- Panel rol ve yetki sistemi

---

### 2.5 Route

AI tarafından oluşturulan veya kullanıcı tarafından kaydedilen gezi rotasını temsil eder.

Kullanıldığı yerler:

- AI rota sonucu
- Rota detay ekranı
- Rota haritası
- Kaydedilen rotalar

---

### 2.6 Partner

Belediye, il kültür ve turizm müdürlüğü, bakanlık, restoran/kafe, otel, acente, müze veya etkinlik organizatörü gibi platform paydaşlarını temsil eder.

Kullanıldığı yerler:

- Yönetim paneli
- Rol bazlı içerik yönetimi
- Kurum/işletme yetkilendirme
- İçerik sahipliği

---

### 2.7 ContentStatus

Bir içeriğin yayın sürecindeki durumunu temsil eder.

Örnek durumlar:

```text
draft
pending_review
approved
published
rejected
needs_revision
archived
```

---

## 3. Veri İlişkileri

### 3.1 Şehir ilişkisi

```text
City
 ├── Places
 ├── Events
 ├── Partners
 └── Routes
```

Bir şehir birden fazla mekan, etkinlik, rota ve iş ortağına sahip olabilir.

---

### 3.2 Mekan ilişkisi

```text
Place
 ├── City
 ├── Category
 ├── Location
 ├── Images
 ├── Partner
 └── ContentStatus
```

Bir mekan mutlaka bir şehre bağlı olmalıdır.

---

### 3.3 Etkinlik ilişkisi

```text
Event
 ├── City
 ├── Venue / Place
 ├── Date Range
 ├── Ticket URL
 ├── Organizer / Partner
 └── ContentStatus
```

Bir etkinlik bir şehirde gerçekleşir. Eğer fiziksel bir mekanda yapılıyorsa `placeId` ile o mekana bağlanabilir.

---

### 3.4 Rota ilişkisi

```text
Route
 ├── User
 ├── City
 ├── Stops
 │   ├── Place
 │   └── Event
 └── Preferences
```

Bir rota kullanıcının tercihleriyle oluşturulur ve şehirdeki mekan/etkinlik verisini kullanır.

---

### 3.5 Partner ilişkisi

```text
Partner
 ├── City
 ├── Users
 ├── Places
 ├── Events
 └── Permissions
```

Bir iş ortağı kendi yetkili olduğu şehirde veya içerik türünde işlem yapabilir.

---

## 4. Önerilen Firestore Koleksiyon Yapısı

İleride Firebase Firestore kullanılacaksa önerilen koleksiyon yapısı:

```text
cities
places
events
users
routes
partners
contentReviews
mediaAssets
reports
```

Alternatif olarak şehir bazlı alt koleksiyon yapısı da düşünülebilir:

```text
cities/{cityId}/places
cities/{cityId}/events
cities/{cityId}/partners
```

Başlangıç için daha kolay sorgulanabilir olması nedeniyle tekil ana koleksiyon yapısı önerilir:

```text
places → cityId alanıyla filtrelenir
events → cityId alanıyla filtrelenir
partners → cityId alanıyla filtrelenir
```

---

## 5. ID ve Slug Mantığı

Her ana veri tipinde benzersiz bir `id` olmalıdır.

Önerilen format:

```text
city: samsun
place: bandirma-vapuru-muzesi
event: samsun-caz-festivali-2026
partner: samsun-buyuksehir-belediyesi
route: route_2026_05_15_001
```

Slug alanları URL, arama ve dosya düzeni için kullanılabilir.

---

## 6. Ortak Alanlar

Birçok modelde ortak kullanılabilecek alanlar:

```text
id
createdAt
updatedAt
createdBy
updatedBy
contentStatus
isPublished
lastVerifiedAt
sourceUrl
```

Bu alanlar veri takibi, panel onayı ve güvenilirlik için önemlidir.

---

## 7. Yayın ve Onay Mantığı

GezioGo’da her içerik doğrudan yayına çıkmamalıdır.

Önerilen akış:

```text
Taslak → Onaya Gönderildi → Onaylandı → Yayında
                      ↓
                 Reddedildi / Revizyon Gerekli
```

Bu yapı özellikle belediye, kurum, işletme ve editör içerikleri için gereklidir.

---

## 8. AI İçin Veri Kullanımı

AI rota oluştururken şu verileri kullanmalıdır:

- Şehir bilgisi
- Mekan listesi
- Etkinlikler
- Kullanıcı tercihleri
- Bütçe tercihi
- Ulaşım tercihi
- Açık/kapalı alan bilgisi
- Ortalama ziyaret süresi
- Konum bilgileri

AI, doğrulanmamış veya yayında olmayan içerikleri rota önerisine almamalıdır.

---

## 9. Sonuç

GezioGo veri modeli, üç temel ihtiyacı aynı anda karşılamalıdır:

1. Mobil uygulamada hızlı ve anlaşılır içerik gösterimi
2. Yönetim panelinde kontrollü içerik girişi ve onay süreci
3. AI rota sisteminde güvenilir ve yapılandırılmış veri kullanımı

Ana ilke:

> Veriyi baştan düzenli kurarsak, uygulama geliştirme süreci daha hızlı, temiz ve sürdürülebilir olur.

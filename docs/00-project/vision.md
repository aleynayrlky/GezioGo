# Gezio – Vizyon Dosyası

> Hafta 1 / Gün 2 çıktısı  
> Dosya amacı: Gezio’nun kısa, orta ve uzun vadeli vizyonunu netleştirmek; MVP ile büyük platform hedefini birbirinden ayırmak.

---

## 1. Vizyonun Amacı

Bu dosya, **Gezio’nun yalnızca ilk sürümde ne yapacağını değil, ilerleyen dönemlerde neye dönüşebileceğini** tanımlamak için hazırlanmıştır.

Gezio büyük ve kapsamlı bir projedir. Bu yüzden her özelliği aynı anda geliştirmek doğru değildir. Vizyon dosyasının amacı, projeyi üç ayrı seviyede düşünmemizi sağlamaktır:

1. **Kısa vadeli vizyon:** İlk çalışan ürün ne olacak?
2. **Orta vadeli vizyon:** Ürün hangi özelliklerle güçlenecek?
3. **Uzun vadeli vizyon:** Gezio hangi platforma dönüşecek?

Bu ayrım sayesinde proje büyürken kontrol kaybedilmez.

---

## 2. Kısa Vadeli Vizyon

Kısa vadeli hedef, tek şehir üzerinden çalışan, sade ama güçlü bir MVP geliştirmektir.

İlk şehir: **Samsun**  
İlk platform: **iOS**  
Ana teknoloji: **Swift / SwiftUI**

Kısa vadede Gezio’nun amacı şudur:

> Kullanıcı Samsun’u uygulama üzerinden keşfedebilmeli, mekanları ve etkinlikleri görebilmeli, detaylara ulaşabilmeli, haritada inceleyebilmeli ve favorilerine ekleyebilmelidir.

Bu aşamada ürünün temel amacı, büyük ve karmaşık bir platform olmak değildir. İlk amaç, **küçük, temiz, çalışan ve genişletilebilir bir temel ürün** oluşturmaktır.

### Kısa Vadede Odaklanılacak Özellikler

- Samsun şehir ana sayfası
- Kategori listeleri
- Gezilecek yerler
- Müzeler
- Doğa ve yeşil alanlar
- Yeme-içme önerileri
- Etkinlikler
- Mekan detay sayfası
- Etkinlik detay sayfası
- Haritada gösterme
- Favorilere ekleme
- Basit arama
- Basit filtreleme
- Bilet linkine yönlendirme
- Yerel JSON veya Firestore üzerinden veri okuma

### Kısa Vadede Odaklanılmayacak Özellikler

- Belediye paneli
- Çoklu şehir yönetimi
- Fotoğraftan tarihi eser tanıma
- Uygulama içi bilet satışı
- Gelişmiş kişiselleştirme
- İşletme paneli
- Çoklu dil desteği
- Gelişmiş analitik

Bu özellikler önemli olsa da ilk aşamada projeyi büyütüp karmaşıklaştırabilir. Bu nedenle sonraki sürümlere bırakılmalıdır.

---

## 3. Orta Vadeli Vizyon

Orta vadeli hedef, Gezio’yu basit bir şehir rehberi olmaktan çıkarıp **kişiselleştirilmiş gezi ve şehir deneyimi sunan akıllı bir uygulamaya** dönüştürmektir.

Bu aşamada ürün artık sadece mekan ve etkinlik göstermez. Kullanıcının zamanına, bütçesine, ilgi alanına, konumuna, ulaşım tercihine ve özel ihtiyaçlarına göre öneriler üretmeye başlar.

### Orta Vadede Eklenecek Ana Özellikler

- AI rota oluşturma
- Kullanıcı hesabı
- Favorilerin kullanıcı hesabına bağlanması
- Kaydedilen rotalar
- Kullanıcı ilgi alanları
- Sesli rehber
- Erişilebilirlik iyileştirmeleri
- Bildirimler
- Etkinliği takvime ekleme
- Daha gelişmiş filtreleme
- Yağmurlu hava alternatifi
- Öğrenci / aile / çocuk / engelli dostu rota önerileri

### Orta Vadeli Ürün Deneyimi

Orta vadede kullanıcı uygulamaya sadece “nerelere gidilir?” sorusu için değil, şu sorular için de girebilmelidir:

- Bugün ne yapabilirim?
- 1 günde Samsun’u nasıl gezebilirim?
- Düşük bütçeyle nerelere gidebilirim?
- Çocukla gidilebilecek yerler neresi?
- Yağmur yağarsa hangi kapalı alanlara gidebilirim?
- Yakınımda gezilecek yer var mı?
- Bu hafta hangi etkinlikler var?

Bu aşamada Gezio’nun ana farkı daha görünür hale gelir:

> **Listeleyen değil, planlayan şehir rehberi.**

---

## 4. Uzun Vadeli Vizyon

Uzun vadede Gezio yalnızca bir iOS uygulaması olarak kalmamalıdır. Mobil uygulama, web yönetim paneli, AI servis katmanı ve şehir/turizm veri altyapısıyla birlikte daha büyük bir dijital şehir ve turizm platformuna dönüşmelidir.

Uzun vadeli hedef:

> Gezio’yu şehirlerin turizm, kültür, etkinlik ve rota deneyimini dijital olarak yöneten yapay zekâ destekli bir platforma dönüştürmek.

### Uzun Vadede Ürün Katmanları

```text
Mobil Kullanıcı Uygulaması
        |
Backend / Firebase / API Katmanı
        |
Yapay Zekâ Servis Katmanı
        |
Web Belediye ve Kurum Paneli
        |
Çoklu Şehir İçerik Yönetimi
```

### Uzun Vadede Eklenecek Ana Özellikler

- Belediye / kurum yönetim paneli
- Rol bazlı yetkilendirme
- Çoklu şehir desteği
- Şehir bazlı içerik yönetimi
- İçerik onay sistemi
- Fotoğraftan tarihi eser / mekan tanıma
- Çoklu dil desteği
- Çok dilli sesli rehber
- İşletme paneli
- Bilet entegrasyonları
- Premium kullanıcı özellikleri
- Turizm analitik paneli
- Şehir bazlı raporlama
- Bakanlık / kurum / belediye iş birlikleri

---

## 5. Nihai Ürün Vizyonu

Gezio’nun nihai ürün yapısı şu şekilde düşünülmelidir:

### 5.1 Kullanıcı Tarafı

Kullanıcı için Gezio:

- Şehir keşif uygulaması
- Kişisel gezi asistanı
- Etkinlik takip aracı
- Haritalı rota yardımcısı
- Sesli rehber
- AI gezi planlayıcı
- Fotoğraftan yer tanıma aracı

### 5.2 Belediye / Kurum Tarafı

Belediye ve kurumlar için Gezio:

- Şehir tanıtım platformu
- Etkinlik yönetim sistemi
- İçerik yönetim paneli
- Turizm verisi takip aracı
- Şehir markalaşma desteği
- Dijital kültür ve turizm vitrini

### 5.3 İşletme Tarafı

Yerel işletmeler için Gezio:

- Turistlere ulaşma kanalı
- Yerel görünürlük aracı
- Sponsorlu içerik fırsatı
- Kampanya ve etkinlik duyurusu alanı
- İleride işletme paneliyle yönetilebilir profil alanı

---

## 6. Vizyonu Sınırlayan Temel İlke

Gezio’nun vizyonu büyük olsa da geliştirme süreci küçük adımlarla ilerlemelidir.

Temel ilke:

> **Önce küçük ama çalışan ürün. Sonra düzenli büyüme.**

Bu yüzden proje şu sırayla ilerlemelidir:

```text
Dokümantasyon
   ↓
Statik SwiftUI Demo
   ↓
Gezio 1.0 MVP
   ↓
AI Rota Oluşturma
   ↓
Kullanıcı Hesabı
   ↓
Sesli Rehber
   ↓
Belediye / Kurum Paneli
   ↓
Fotoğraftan Mekan Tanıma
   ↓
Çoklu Şehir
   ↓
Gelir Modeli ve Ölçekleme
```

---

## 7. MVP ile Uzun Vadeli Vizyon Arasındaki Fark

Bu ayrım projenin sağlıklı ilerlemesi için çok önemlidir.

| Konu | MVP | Uzun Vadeli Vizyon |
|---|---|---|
| Şehir sayısı | Tek şehir: Samsun | Çoklu şehir / 81 il |
| Platform | iOS | iOS + Android + Web Panel |
| Veri yönetimi | Manuel / JSON / Firestore | Belediye ve kurum paneli |
| AI | İlk aşamada sınırlı veya 1.1’de rota | Gelişmiş AI asistan, görsel tanıma, öneri sistemi |
| Sesli rehber | Yok veya sonraki sürüm | Çok dilli sesli rehber |
| Bilet | Link yönlendirme | Entegrasyon / komisyon modeli |
| Kullanıcı hesabı | İlk MVP’de olmayabilir | Kişiselleştirilmiş profil ve rota geçmişi |
| Gelir modeli | Henüz test aşaması | SaaS, premium, işletme, bilet, raporlama |

---

## 8. Vizyon Kararları

Bu dosya ile alınan temel kararlar:

- Gezio tek seferde büyük bir platform olarak geliştirilmeyecek.
- İlk hedef Samsun için çalışan iOS MVP olacak.
- MVP’de temel keşif, listeleme, detay, harita, favori, arama ve filtreleme özellikleri olacak.
- AI rota oluşturma ürünün ana farkı olacak ancak sağlıklı geliştirme için 1.1 sürümünde ayrı ele alınabilir.
- Belediye / kurum paneli uzun vadede zorunlu bir ürün katmanı olacak.
- Fotoğraftan tarihi eser veya mekan tanıma ileri sürümlerde geliştirilecek.
- Sesli rehber, turizm deneyimini güçlendiren önemli bir orta vadeli özellik olacak.
- Gezio belediye uygulamalarına rakip değil, onları tamamlayan turizm ve şehir keşfi katmanı olarak konumlandırılacak.

---

## 9. Kısa Vizyon Cümlesi

> **Gezio, kullanıcıların şehirleri kendi ilgi alanlarına, zamanlarına ve bütçelerine göre keşfetmelerini sağlayan; uzun vadede belediyeler, kurumlar ve yerel işletmeler için yönetilebilir dijital turizm platformuna dönüşecek yapay zekâ destekli şehir ve gezi asistanıdır.**

---

## 10. Özet

Gezio’nun kısa vadeli amacı, Samsun için çalışan sade ve güçlü bir iOS MVP geliştirmektir.

Orta vadede ürün; AI rota oluşturma, kullanıcı hesabı, kişiselleştirme, sesli rehber ve erişilebilirlik özellikleriyle güçlenecektir.

Uzun vadede Gezio; belediye/kumrum paneli, çoklu şehir desteği, fotoğraftan mekan tanıma, çoklu dil, gelir modeli ve turizm analitiği ile daha büyük bir dijital şehir ve turizm platformuna dönüşebilecektir.

Ana yön:

> **Küçük başla, düzenli büyüt, platforma dönüştür.**

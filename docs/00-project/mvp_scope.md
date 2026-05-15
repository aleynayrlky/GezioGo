# Gezio – MVP Kapsamı

> Hafta 1 / Gün 3 çıktısı  
> Dosya amacı: Gezio’nun ilk gerçek sürümü olan 1.0 MVP’de nelerin olacağını ve nelerin sonraki sürümlere bırakılacağını netleştirmek.

---

## 1. Günün Ana Hedefi

Bu günün amacı, Gezio’nun ilk sürümünü küçük, yönetilebilir ve geliştirilebilir bir kapsamda tutmaktır.

Gezio büyük bir proje olacaktır; ancak bütün özellikleri ilk sürümde yapmaya çalışmak projeyi yavaşlatır, karmaşıklaştırır ve motivasyonu düşürür. Bu yüzden 1.0 MVP sadece temel kullanıcı deneyimini kanıtlamaya odaklanacaktır.

Ana karar:

> **Gezio 1.0, Samsun için çalışan temel şehir keşif uygulaması olacaktır.**

---

## 2. MVP Ne Demek?

MVP, “Minimum Viable Product” yani **minimum uygulanabilir ürün** anlamına gelir.

Bu projede MVP şu anlama gelir:

> Kullanıcının Samsun’u uygulama üzerinden keşfedebildiği, mekanları görebildiği, detaylara ulaşabildiği, haritada inceleyebildiği, favorilere ekleyebildiği ve temel keşif deneyimini yaşayabildiği ilk çalışan ürün.

MVP’nin amacı mükemmel ürün çıkarmak değildir. MVP’nin amacı şu soruya cevap vermektir:

> **Gezio fikri gerçek bir kullanıcı deneyimine dönüşebiliyor mu?**

---

## 3. Gezio 1.0 MVP Tanımı

## Ürün Adı

**Gezio**

## Slogan

**Şehir seninle keşfedilir.**

## İlk Platform

**iOS**

## Geliştirme Teknolojisi

- Swift
- SwiftUI
- MapKit
- CoreLocation
- Yerel JSON veya Firestore

## İlk Şehir

**Samsun**

## MVP’nin Ana Cümlesi

> Gezio 1.0, Samsun’daki gezilecek yerleri, müzeleri, doğa alanlarını, yeme-içme önerilerini ve etkinlikleri kullanıcıya düzenli, harita destekli ve sade bir mobil deneyimle sunan ilk iOS sürümüdür.

---

## 4. Gezio 1.0’da Kesin Olacak Özellikler

### 4.1 Şehir Ana Sayfası

Kullanıcı uygulamayı açtığında Samsun için hazırlanmış ana sayfayı görebilmelidir.

Bu ekranda bulunabilecek alanlar:

- Şehir adı
- Şehir görseli
- Kısa şehir açıklaması
- Kategori kartları
- Öne çıkan yerler
- Öne çıkan etkinlikler
- AI rota özelliğine yönlendirme butonu veya sonraki sürüm etiketi

---

### 4.2 Kategori Listeleri

Uygulamada temel kategoriler listelenmelidir.

MVP kategorileri:

- Gezilecek Yerler
- Müzeler
- Doğa ve Yeşil Alanlar
- Yeme İçme
- Etkinlikler

Bu kategoriler ileride genişleyebilir; ancak 1.0 için bu beş kategori yeterlidir.

---

### 4.3 Mekan Liste Ekranı

Kullanıcı bir kategoriye tıkladığında o kategoriye ait mekanları liste halinde görebilmelidir.

Liste kartında bulunabilecek bilgiler:

- Mekan adı
- Kategori
- Kısa açıklama
- İlçe
- Görsel
- Ücretsiz/ücretli bilgisi
- Favori ikonu

---

### 4.4 Mekan Detay Sayfası

Kullanıcı bir mekanı açtığında detaylarını görebilmelidir.

Detay sayfasında bulunabilecek bilgiler:

- Mekan adı
- Görseller
- Kısa açıklama
- Uzun açıklama
- Adres
- İlçe
- Konum bilgisi
- Açılış/kapanış bilgisi
- Ücret bilgisi
- Kaynak bağlantısı
- Erişilebilirlik bilgisi
- Haritada göster butonu
- Favorilere ekle butonu

---

### 4.5 Etkinlik Liste Ekranı

Kullanıcı Samsun’daki etkinlikleri listeleyebilmelidir.

Etkinlik kartında bulunabilecek bilgiler:

- Etkinlik adı
- Tarih
- Saat
- Yer
- Ücretsiz/ücretli bilgisi
- Bilet bağlantısı varsa kısa gösterim

---

### 4.6 Etkinlik Detay Sayfası

Etkinlik detayında bulunabilecek bilgiler:

- Etkinlik adı
- Açıklama
- Tarih
- Saat
- Mekan adı
- Adres
- Haritada göster butonu
- Bilet linki
- Düzenleyen kurum
- Kaynak bağlantısı

---

### 4.7 Haritada Gösterme

Mekanlar ve etkinlikler haritada gösterilebilmelidir.

MVP için yeterli harita özellikleri:

- MapKit entegrasyonu
- Mekan pinleri
- Etkinlik pinleri
- Kullanıcı konumu izni
- Mekan detayından haritaya geçiş
- Apple Maps ile yol tarifi açma

---

### 4.8 Favorilere Ekleme

Kullanıcı sevdiği mekanları favorilere ekleyebilmelidir.

MVP’de favoriler local olarak saklanabilir. Kullanıcı hesabı 1.2 sürümüne bırakılabilir.

MVP favori özellikleri:

- Favoriye ekle
- Favoriden çıkar
- Favoriler ekranı
- Boş favoriler ekranı

---

### 4.9 Basit Arama

Kullanıcı mekan veya etkinlik adıyla arama yapabilmelidir.

MVP arama kapsamı:

- Mekan adı
- Etkinlik adı
- Kategori adı
- İlçe adı

---

### 4.10 Basit Filtreleme

MVP’de çok gelişmiş filtre sistemi gerekmez. Basit filtreleme yeterlidir.

İlk filtreler:

- Kategori
- Ücretsiz / ücretli
- Kapalı alan / açık alan
- Çocukla gidilebilir
- Öğrenci dostu

---

### 4.11 Bilet Linkine Yönlendirme

Uygulama içinde bilet satışı yapılmayacaktır. İlk aşamada kullanıcı resmi veya güvenilir bilet bağlantısına yönlendirilir.

MVP yaklaşımı:

- Etkinlik detayında “Bilet Al” butonu
- Dış bağlantıya yönlendirme
- Link yoksa “Bilet bilgisi bulunamadı” durumu

---

### 4.12 Veri Okuma

İlk aşamada veri iki yöntemden biriyle okunabilir:

1. Yerel JSON dosyası
2. Firestore

Başlangıçta mock JSON ile ilerlemek daha kolaydır. Firebase/Firestore entegrasyonu daha sonra eklenebilir.

---

## 5. Gezio 1.0’da Olmayacak Özellikler

Aşağıdaki özellikler önemli olsa da 1.0 MVP’ye alınmayacaktır.

### 5.1 Belediye / Kurum Paneli

Bu özellik çok önemli ancak 2.0 sürümüne bırakılmalıdır.

Sebep:

- Web panel ayrı bir ürün katmanıdır.
- Yetkilendirme, rol sistemi ve içerik yönetimi gerektirir.
- MVP’nin odağını dağıtır.

---

### 5.2 Kullanıcı Hesabı

Kullanıcı hesabı 1.2 sürümüne bırakılmalıdır.

MVP’de favoriler local tutulabilir.

Sonraki sürümde eklenecekler:

- Firebase Authentication
- Kullanıcı profili
- Kaydedilen rotalar
- Kullanıcı bazlı favoriler

---

### 5.3 Gerçek AI Rota Entegrasyonu

AI rota Gezio’nun en önemli farklarından biridir. Ancak 1.0 temel MVP’den hemen sonra 1.1 sürümünde geliştirilmesi daha sağlıklıdır.

1.0’da yapılabilecek şey:

- AI rota ekranının taslak butonu
- “Yakında” etiketi
- Basit form tasarımı prototipi

1.1’de yapılacak şey:

- Gerçek AI API entegrasyonu
- Prompt sistemi
- Rota sonucu ekranı
- Rota kaydetme

---

### 5.4 Fotoğraftan Tarihi Eser / Mekan Tanıma

Bu özellik 2.5 sürümüne bırakılmalıdır.

Sebep:

- Kamera entegrasyonu gerekir.
- Görsel AI API gerekir.
- Backend üzerinden görsel işleme gerekir.
- Hatalı tanıma riskleri yönetilmelidir.

---

### 5.5 Sesli Rehber

Sesli rehber 1.5 sürümüne bırakılmalıdır.

Sebep:

- Önce mekan detay içerikleri oturmalıdır.
- Sonra bu içerikler sesli okunabilir hale getirilmelidir.
- AVSpeechSynthesizer entegrasyonu ayrı ele alınmalıdır.

---

### 5.6 Uygulama İçi Bilet Satışı

1.0’da bilet satışı yapılmayacaktır.

Sadece yönlendirme yapılacaktır.

Sebep:

- Ödeme altyapısı gerekir.
- Hukuki ve ticari sorumluluk doğurur.
- Bilet platformlarıyla anlaşma gerekir.

---

### 5.7 Çoklu Şehir Desteği

İlk sürüm sadece Samsun ile sınırlı olacaktır.

Sebep:

- Tek şehirle veri doğrulamak daha kolaydır.
- Ürün deneyimi önce küçük ölçekte test edilmelidir.
- Veri modeli ileride çoklu şehre uygun tasarlanabilir.

---

### 5.8 Yorum ve Puanlama

Yorum ve puanlama ilk sürümde olmayacaktır.

Sebep:

- Kullanıcı hesabı gerektirir.
- Moderasyon gerekir.
- Sahte yorum ve kötüye kullanım riski vardır.

---

## 6. MVP İçin İlk Veri Kapsamı

Gezio 1.0 için Samsun özelinde küçük ama yeterli bir veri seti hazırlanmalıdır.

Önerilen minimum veri hedefi:

| Kategori | Minimum İçerik Sayısı |
|---|---:|
| Gezilecek Yerler | 15 |
| Müzeler / Kültürel Alanlar | 5 |
| Doğa ve Yeşil Alanlar | 10 |
| Yeme İçme | 10 |
| Etkinlikler | 5 |

Toplam ilk veri hedefi:

> **Yaklaşık 45 içerik**

Bu sayı MVP için yeterlidir. İlk aşamada 100+ içerik toplamaya çalışmak gerekli değildir.

---

## 7. MVP Ekran Listesi

Gezio 1.0 için önerilen ekranlar:

1. Splash Screen
2. Onboarding Screen
3. Şehir Ana Sayfası
4. Kategori Liste Ekranı
5. Mekan Liste Ekranı
6. Mekan Detay Ekranı
7. Etkinlik Liste Ekranı
8. Etkinlik Detay Ekranı
9. Harita Ekranı
10. Favoriler Ekranı
11. Arama / Filtreleme Alanı
12. Ayarlar veya Basit Profil Ekranı

AI rota ekranı 1.0’da sadece taslak veya “yakında” alanı olarak yer alabilir.

---

## 8. MVP Kullanıcı Akışı

Temel kullanıcı akışı:

1. Kullanıcı uygulamayı açar.
2. Samsun şehir ana sayfasını görür.
3. Kategori seçer.
4. Mekan listesini inceler.
5. Bir mekanın detayına girer.
6. Mekanı haritada görür.
7. Mekanı favorilere ekler.
8. Etkinlikler ekranına girer.
9. Bir etkinliğin detayını açar.
10. Bilet linki varsa dış bağlantıya gider.

Bu akış sorunsuz çalışıyorsa 1.0 MVP için temel deneyim başarılıdır.

---

## 9. MVP Başarı Kriterleri

Gezio 1.0 tamamlandı sayılması için aşağıdaki maddeler çalışmalıdır.

- [ ] Uygulama açılıyor.
- [ ] Samsun ana sayfası görüntüleniyor.
- [ ] Kategori kartları görünüyor.
- [ ] Mekan listeleri açılıyor.
- [ ] Mekan detay ekranı çalışıyor.
- [ ] Etkinlik listesi açılıyor.
- [ ] Etkinlik detay ekranı çalışıyor.
- [ ] Harita ekranı çalışıyor.
- [ ] Mekanlar haritada pin olarak görünüyor.
- [ ] Konum izni doğru yönetiliyor.
- [ ] Favorilere ekleme çalışıyor.
- [ ] Favoriler ekranı çalışıyor.
- [ ] Arama çalışıyor.
- [ ] Basit filtreleme çalışıyor.
- [ ] Bilet linki dış bağlantıya yönlendiriyor.
- [ ] Veri kaynağı veya kaynak linki gösteriliyor.
- [ ] Boş veri durumu gösteriliyor.
- [ ] Yükleniyor durumu gösteriliyor.
- [ ] Hata durumu gösteriliyor.

---

## 10. 1.0 Sonrası İlk Geliştirme Sırası

MVP tamamlandıktan sonra geliştirme sırası şöyle olmalıdır:

1. **Gezio 1.1 – AI Rota Oluşturma**
2. **Gezio 1.2 – Kullanıcı Hesabı ve Kişiselleştirme**
3. **Gezio 1.5 – Sesli Rehber ve Erişilebilirlik**
4. **Gezio 2.0 – Belediye / Kurum Paneli**
5. **Gezio 2.5 – Fotoğraftan Mekan / Tarihi Eser Tanıma**
6. **Gezio 3.0 – Çoklu Şehir ve SaaS Modeli**

Bu sıralama projenin kontrollü büyümesini sağlar.

---

## 11. Gün 3 Sonunda Alınan Kararlar

- İlk gerçek sürümün adı **Gezio 1.0 MVP** olacaktır.
- İlk şehir **Samsun** olacaktır.
- İlk platform **iOS** olacaktır.
- 1.0 sürümünde temel keşif deneyimi yapılacaktır.
- AI rota gerçek entegrasyonu 1.1 sürümüne bırakılacaktır.
- Sesli rehber 1.5 sürümüne bırakılacaktır.
- Belediye/kumrum paneli 2.0 sürümüne bırakılacaktır.
- Fotoğraftan mekan tanıma 2.5 sürümüne bırakılacaktır.
- Uygulama içi bilet satışı ilk sürümde olmayacaktır.
- Çoklu şehir desteği ilk sürümde olmayacaktır.

---

## 12. Kısa Özet

Gezio 1.0 MVP, büyük vizyonun küçük ama çalışan ilk adımıdır.

Bu sürümde amaç her şeyi yapmak değil, Samsun için temel şehir keşif deneyimini başarılı şekilde sunmaktır.

Ana ilke:

> **Önce küçük, temiz ve çalışan ürün. Sonra kontrollü büyüme.**

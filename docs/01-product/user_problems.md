# Gezio – Hafta 1 / Gün 5
# Kullanıcı Problemleri

> Dosya amacı: Gezio’nun hangi kullanıcı problemlerini çözeceğini netleştirmek ve ileride geliştirilecek özellikleri bu problemlere bağlamak.

---

## 1. Genel Problem

Bir şehri gezmek veya yaşadığı şehirde yeni yerler keşfetmek isteyen kullanıcılar genellikle bilgileri farklı kaynaklardan toplamak zorunda kalır.

Bu süreçte kullanıcı:

- Nereden başlayacağını bilemez.
- Çok fazla dağınık bilgiyle karşılaşır.
- Güncel bilgiye ulaşmakta zorlanır.
- Kendi bütçesine, zamanına ve ilgi alanına uygun plan çıkaramaz.
- Harita, etkinlik, bilet, mekan bilgisi ve rota planını farklı yerlerden takip eder.

Gezio’nun temel çıkış noktası bu dağınıklığı azaltmak ve kullanıcıya daha kişisel bir şehir keşif deneyimi sunmaktır.

---

## 2. Kullanıcıların Temel Soruları

Gezio şu sorulara cevap verebilmelidir:

- Bu şehirde nerelere gidilir?
- Bugün ne yapabilirim?
- Bu hafta hangi etkinlikler var?
- Ücretsiz gezilecek yerler neresi?
- Çocukla gidilebilecek yerler var mı?
- Yağmurlu havada nereye gidebilirim?
- 1 günde bu şehri nasıl gezebilirim?
- Müze açık mı?
- Giriş ücreti var mı?
- Bilet gerekiyor mu?
- Yakınımda ne var?
- Akşam ne yapılabilir?
- Öğrenci bütçesine uygun yerler neresi?
- Toplu taşımayla gidilebilecek rotalar hangileri?
- Aileyle gidilecek güvenli yerler neresi?
- Engelli erişimine uygun mekanlar hangileri?

---

## 3. Problem 1: Bilgilerin Dağınık Olması

### Açıklama

Kullanıcı bir şehir hakkında bilgi aradığında genellikle birçok farklı kaynağa bakmak zorunda kalır.

Örnek kaynaklar:

- Belediye web sitesi
- Google Haritalar
- Sosyal medya
- Bilet platformları
- Blog yazıları
- Turizm siteleri
- Arkadaş önerileri

Bu durum zaman kaybettirir ve kullanıcıyı yorar.

### Gezio Çözümü

Gezio; şehirdeki gezilecek yerleri, etkinlikleri, müzeleri, doğal alanları, yeme-içme önerilerini ve bilet bağlantılarını tek bir uygulamada toplar.

---

## 4. Problem 2: Kişisel Rota Oluşturmanın Zor Olması

### Açıklama

Kullanıcının zamanı, bütçesi, konumu, ulaşım tercihi ve ilgi alanları farklıdır. Klasik uygulamalar herkese aynı listeyi gösterir.

Örnek:

- Bir kullanıcının sadece 4 saati olabilir.
- Başka bir kullanıcı 2 günlük gezi planı isteyebilir.
- Bir öğrenci düşük bütçeli rota arayabilir.
- Bir aile çocukla gidilebilecek yerleri görmek isteyebilir.

### Gezio Çözümü

Gezio, yapay zekâ desteğiyle kullanıcının tercihlerini alarak kişisel gezi planı oluşturur.

Rota oluştururken şunları dikkate alabilir:

- Zaman
- Bütçe
- İlgi alanı
- Konum
- Ulaşım tercihi
- Hava durumu
- Yürüme toleransı
- Aile/çocuk/engelli uygunluğu

---

## 5. Problem 3: Güncel Etkinlikleri Takip Etmenin Zor Olması

### Açıklama

Etkinlikler genellikle farklı platformlarda yayınlanır. Kullanıcı konserleri, tiyatroları, festivalleri, belediye etkinliklerini veya ücretsiz etkinlikleri tek yerden takip edemez.

### Gezio Çözümü

Gezio etkinlikleri şehir bazlı listeler.

Etkinlik detayında şunlar gösterilebilir:

- Etkinlik adı
- Tarih
- Saat
- Konum
- Ücret bilgisi
- Bilet bağlantısı
- Düzenleyen kurum
- Haritada gösterme
- Takvime ekleme

---

## 6. Problem 4: Bilgilerin Güncel Olup Olmadığının Belirsizliği

### Açıklama

Müze saatleri, bilet fiyatları, etkinlik tarihleri ve mekan bilgileri değişebilir. Kullanıcı internette eski veya yanlış bilgiyle karşılaşabilir.

### Gezio Çözümü

Gezio’da her içerikte şu alanlar tutulmalıdır:

- Kaynak bağlantısı
- Son güncelleme tarihi
- Doğrulama durumu
- Güncelleyen kurum veya kullanıcı

Uzun vadede belediye/kurum paneli sayesinde içerikler yetkili kişiler tarafından güncellenebilir.

---

## 7. Problem 5: Harita ve Rota Bilgisinin Eksik Olması

### Açıklama

Kullanıcı bir yere gitmek istediğinde mekanın nerede olduğunu, yakınında başka ne olduğunu ve hangi sırayla gezmenin mantıklı olduğunu görmek ister.

### Gezio Çözümü

Gezio:

- Mekanları haritada gösterir.
- Kullanıcının konumuna göre yakın yerleri gösterebilir.
- Mekan detayından haritaya geçiş sağlar.
- AI rota ile yerleri mantıklı sıraya koyabilir.

---

## 8. Problem 6: Bütçeye Uygun Plan Yapılamaması

### Açıklama

Kullanıcılar çoğu zaman ücretsiz veya uygun fiyatlı seçenekleri hızlıca görmek ister. Özellikle öğrenciler, gençler ve kalabalık aileler için bütçe önemlidir.

### Gezio Çözümü

Gezio şu filtreleri sunabilir:

- Ücretsiz
- Uygun fiyatlı
- Öğrenci dostu
- Aile dostu
- Biletli
- Bütçeye göre rota

AI rota oluşturma aşamasında kullanıcının bütçesi dikkate alınabilir.

---

## 9. Problem 7: Aile, Çocuk, Yaşlı ve Engelli İhtiyaçlarının Göz Ardı Edilmesi

### Açıklama

Her kullanıcı aynı şartlarda gezmez. Çocuklu aileler, yaşlılar veya engelli bireyler için mekan seçimi daha dikkatli yapılmalıdır.

### Gezio Çözümü

Gezio ilerleyen sürümlerde şu bilgileri gösterebilir:

- Çocukla gidilebilir
- Bebek arabasına uygun
- Tekerlekli sandalye erişimi var
- Çok yürüyüş gerektirir
- Kapalı alan
- Açık alan
- Dinlenme alanı var
- Toplu taşımaya yakın

---

## 10. Problem 8: Hava Durumuna Göre Plan Yapılamaması

### Açıklama

Kullanıcı açık hava rotası planlamış olabilir ancak hava yağmurlu olabilir. Klasik şehir rehberleri bu duruma göre alternatif önermez.

### Gezio Çözümü

Gezio, ilerleyen sürümlerde hava durumuna göre alternatif plan sunabilir.

Örnek:

- Hava güneşliyse sahil, park, yürüyüş rotası
- Hava yağmurluysa müze, AVM, kapalı sergi, kafe

AI rota oluşturma özelliği bu konuda büyük avantaj sağlar.

---

## 11. Problem 9: Belediyeler ve Kurumlar İçin İçerik Yönetiminin Zor Olması

### Açıklama

Şehir içeriklerini tek kişinin manuel olarak güncellemesi sürdürülebilir değildir. Etkinlikler, duyurular, mekan saatleri ve bilet bağlantıları sürekli değişebilir.

### Gezio Çözümü

Gezio’nun uzun vadede web belediye/kurum paneli olmalıdır.

Panel sayesinde kurumlar:

- Mekan ekleyebilir.
- Etkinlik ekleyebilir.
- Bilet bağlantısı girebilir.
- Görsel yükleyebilir.
- İçerik güncelleyebilir.
- Yayın durumunu yönetebilir.
- Kullanıcı geri bildirimlerini görebilir.

---

## 12. Problem 10: Klasik Uygulamalar Sadece Liste Sunar

### Açıklama

Birçok şehir/gezi uygulaması sadece mekan listesi gösterir. Kullanıcıya “senin için en mantıklı plan bu” diyemez.

### Gezio Çözümü

Gezio’nun ana farkı şudur:

> Listeleyen değil, planlayan şehir rehberi.

Bu yüzden Gezio yalnızca mekanları göstermekle kalmamalı, kullanıcının durumuna göre karar verebilen bir şehir asistanı gibi davranmalıdır.

---

## 13. MVP’de Öncelikli Çözülecek Problemler

Gezio 1.0 MVP’de öncelikle şu problemler çözülmelidir:

- Şehirde gezilecek yerleri tek yerde gösterme
- Mekan detaylarını düzenli sunma
- Etkinlikleri listeleme
- Haritada gösterme
- Favorilere ekleme
- Basit arama
- Basit filtreleme
- Bilet bağlantısına yönlendirme

AI rota, sesli rehber, belediye paneli ve fotoğraftan tanıma gibi özellikler sonraki versiyonlarda geliştirilebilir.

---

## 14. Sonuç

Gezio’nun çözmesi gereken ana problem şehir keşif sürecinin dağınık, kişiselleştirilmemiş ve zaman kaybettirici olmasıdır.

Uygulama ilk aşamada bu problemi temel şehir rehberi özellikleriyle çözecek; sonraki aşamalarda yapay zekâ, sesli rehber, fotoğraftan tanıma ve belediye paneli ile daha güçlü bir platforma dönüşecektir.

Ana ilke:

> Kullanıcıya sadece bilgi verme; onun yerine kullanıcının şartlarına göre anlamlı şehir deneyimi oluştur.

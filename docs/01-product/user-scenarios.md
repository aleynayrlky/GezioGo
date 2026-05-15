# GezioGo – Kullanıcı Senaryoları

> Hafta 2 / Gün 2 çıktısı  
> Dosya amacı: Mobil kullanıcıların ve panel kullanıcılarının GezioGo içinde gerçek hayatta ne yapacağını hikâye formatında tanımlamak.

---

## 1. Dokümanın Amacı

Bu dosya, GezioGo’nun gerçek kullanım senaryolarını netleştirmek için hazırlanmıştır.

Kullanıcı senaryoları, ileride şu konularda yardımcı olur:

- Hangi ekranların gerekli olduğunu anlamak
- Hangi akışların öncelikli geliştirileceğini görmek
- MVP kapsamını kontrol etmek
- Tasarım ve geliştirme sırasında kullanıcı davranışını unutmamak

Senaryolar iki ana gruba ayrılır:

```text
1. Mobil uygulama kullanıcı senaryoları
2. Panel / admin / iş ortağı kullanıcı senaryoları
```

---

# 2. Mobil Uygulama Kullanıcı Senaryoları

## 2.1 Senaryo: Yerli turist şehir keşfeder

### Kullanıcı

Elif, hafta sonu Samsun’a gelen yerli turist.

### Amaç

Samsun’da 1 gün içinde nereleri gezebileceğini öğrenmek.

### Akış

1. Elif GezioGo’yu açar.
2. Onboarding ekranlarını geçer.
3. Şehir seçimi ekranında **Samsun** seçer.
4. Ana sayfada öne çıkan yerleri görür.
5. Kategorilerden **Gezilecek Yerler** seçer.
6. Mekan listesinde Bandırma Vapuru Müzesi’ni görür.
7. Mekan detayına girer.
8. Açıklama, saat, ücret ve harita bilgisini inceler.
9. Mekanı favorilerine ekler.
10. Haritada yol tarifi alır.

### Başarı kriteri

Elif, şehirde nereye gideceğini hızlıca bulur ve harita desteğiyle yola çıkabilir.

---

## 2.2 Senaryo: Kullanıcı etkinlik bulur

### Kullanıcı

Deniz, Samsun’da yaşayan ve hafta sonu etkinlik arayan kullanıcı.

### Amaç

Bu hafta şehirde hangi etkinliklerin olduğunu görmek.

### Akış

1. Deniz uygulamayı açar.
2. Ana sayfada **Etkinlikler** alanına girer.
3. “Bu Hafta” filtresini seçer.
4. Konser, festival veya sergi etkinliklerini inceler.
5. Bir etkinliğin detayına girer.
6. Tarih, saat, mekan ve açıklamayı görür.
7. Bilet linki varsa dış bağlantıya gider.
8. Etkinliği favorilerine ekler.

### Başarı kriteri

Deniz, şehirdeki etkinlikleri tek yerden görebilir ve bilet linkine ulaşabilir.

---

## 2.3 Senaryo: Öğrenci düşük bütçeli rota oluşturur

### Kullanıcı

Mert, üniversite öğrencisi.

### Amaç

Arkadaşlarıyla düşük bütçeli bir şehir gezisi planlamak.

### Akış

1. Mert GezioGo’yu açar.
2. Ana sayfadan **Planla** sekmesine girer.
3. Şehir olarak Samsun seçer.
4. Süreyi “1 gün” seçer.
5. Bütçeyi “Düşük” seçer.
6. İlgi alanı olarak doğa, sahil ve yeme-içme seçer.
7. Ulaşım tercihini toplu taşıma + yürüyüş seçer.
8. AI rota oluştur butonuna basar.
9. Sistem düşük bütçeli bir rota oluşturur.
10. Mert rotayı kaydeder.

### Başarı kriteri

Mert, bütçesine uygun ve uygulanabilir bir gezi planı alır.

---

## 2.4 Senaryo: Çocuklu aile uygun mekan arar

### Kullanıcı

Zeynep, çocuğuyla hafta sonu planı yapmak isteyen kullanıcı.

### Amaç

Çocukla gidilebilecek güvenli ve rahat yerler bulmak.

### Akış

1. Zeynep uygulamayı açar.
2. Keşfet ekranına girer.
3. Filtrelerden **Çocukla Uygun** seçer.
4. Kapalı/açık alan tercihini belirler.
5. Liste üzerinden uygun mekanları inceler.
6. Mekan detayında açıklama ve erişilebilirlik bilgisini okur.
7. Haritada konuma bakar.
8. Mekanı favorilerine ekler.

### Başarı kriteri

Zeynep, çocuğuyla gidebileceği uygun mekanları güvenle seçer.

---

## 2.5 Senaryo: Kullanıcı yakınındaki yerleri haritada görür

### Kullanıcı

Ali, şehirde dolaşırken yakınında gezilecek yer arayan kullanıcı.

### Amaç

Konumuna yakın yerleri görmek.

### Akış

1. Ali uygulamayı açar.
2. Ana sayfadan **Harita** sekmesine girer.
3. Konum izni verir.
4. Yakındaki mekan pinlerini görür.
5. Bir pine tıklar.
6. Alt bilgi kartında mekan özetini görür.
7. Detaya gider veya yol tarifi alır.

### Başarı kriteri

Ali, yakınındaki gezilecek yerleri harita üzerinden hızlıca keşfeder.

---

## 2.6 Senaryo: Kullanıcı favorilerini yönetir

### Kullanıcı

Elif, gezi öncesi ilgisini çeken yerleri kaydetmek isteyen kullanıcı.

### Amaç

Beğendiği mekanları daha sonra kolayca bulmak.

### Akış

1. Elif mekan detayına girer.
2. Favori ikonuna basar.
3. Sistem “Favorilere eklendi” mesajı gösterir.
4. Elif Favoriler ekranına gider.
5. Kaydedilen mekanları görür.
6. İsterse bir mekanı favorilerden çıkarır.

### Başarı kriteri

Kullanıcı beğendiği içerikleri kaydedebilir ve daha sonra kolayca erişebilir.

---

# 3. Panel / Admin / İş Ortağı Kullanıcı Senaryoları

## 3.1 Senaryo: Super Admin yeni kurum hesabı açar

### Kullanıcı

GezioGo kurucusu / Super Admin.

### Amaç

Anlaşma yapılan belediye, il müdürlüğü, bakanlık veya işletme için panel hesabı açmak.

### Akış

1. Super Admin panele giriş yapar.
2. Kullanıcılar ve Roller ekranına gider.
3. Yeni kullanıcı oluşturur.
4. Kurum/işletme türünü seçer.
5. Kullanıcı rolünü belirler.
6. Yetki kapsamını seçer.
7. Örneğin “Samsun Belediyesi” için sadece Samsun yetkisi verir.
8. Davet e-postası gönderir.

### Başarı kriteri

Yeni kurum kullanıcısı yalnızca yetkili olduğu alanları görebilir.

---

## 3.2 Senaryo: Belediye yetkilisi etkinlik ekler

### Kullanıcı

Samsun Belediyesi kültür işleri yetkilisi.

### Amaç

Belediyenin düzenlediği etkinliği GezioGo’da yayınlatmak.

### Akış

1. Belediye yetkilisi paneline giriş yapar.
2. Etkinlikler ekranına gider.
3. “Yeni Etkinlik Ekle” butonuna basar.
4. Etkinlik adı, tarih, saat, mekan ve açıklama bilgilerini girer.
5. Görsel yükler.
6. Bilet linki varsa ekler.
7. İçeriği onaya gönderir.
8. Onay yetkilisi içeriği kontrol eder.
9. Uygunsa yayınlar.

### Başarı kriteri

Etkinlik mobil uygulamada doğru şehir ve kategori altında görünür.

---

## 3.3 Senaryo: İl Kültür ve Turizm Müdürlüğü müze bilgisi günceller

### Kullanıcı

İl Kültür ve Turizm Müdürlüğü yetkilisi.

### Amaç

Bir müzenin açıklama, saat veya kaynak bilgisini güncellemek.

### Akış

1. Kullanıcı kurum paneline giriş yapar.
2. Müzeler ekranına gider.
3. Güncellenecek müzeyi seçer.
4. Açılış saati, açıklama veya kaynak URL bilgisini düzenler.
5. Son doğrulama tarihini günceller.
6. İçeriği onaya gönderir.

### Başarı kriteri

Mobil uygulamada müze bilgisi güncel ve doğrulanmış şekilde görünür.

---

## 3.4 Senaryo: Restoran/kafe sahibi işletme profilini günceller

### Kullanıcı

Sahil Restoran işletme sahibi.

### Amaç

Kendi işletme profilini güncellemek.

### Akış

1. İşletme sahibi panele giriş yapar.
2. İşletme Bilgilerim ekranına gider.
3. Açıklama, çalışma saatleri ve fotoğrafları günceller.
4. Menü veya hizmet bilgisi ekler.
5. Kampanya oluşturur.
6. İçeriği onaya gönderir.

### Başarı kriteri

İşletme sahibi yalnızca kendi işletmesini düzenler; başka işletmeleri göremez.

---

## 3.5 Senaryo: İçerik editörü mekan taslağı oluşturur

### Kullanıcı

GezioGo içerik editörü.

### Amaç

Yeni bir mekan bilgisini taslak olarak eklemek.

### Akış

1. Editör panele giriş yapar.
2. Mekan Ekle ekranına gider.
3. Mekan adı, kategori, açıklama, adres ve konum bilgilerini girer.
4. Görsel ekler.
5. Kaynak URL girer.
6. Taslak olarak kaydeder.
7. Eksikler tamamlanınca onaya gönderir.

### Başarı kriteri

İçerik taslak olarak kaydedilir ve onay sürecine alınabilir.

---

## 3.6 Senaryo: Onay yetkilisi içeriği kontrol eder

### Kullanıcı

İçerik onay yetkilisi.

### Amaç

Bekleyen içerikleri kontrol edip yayınlamak veya reddetmek.

### Akış

1. Onay yetkilisi panele giriş yapar.
2. Onay Paneli ekranına gider.
3. Bekleyen içerikler listesini görür.
4. Bir içeriğin detayına girer.
5. Açıklama, görsel, kaynak, şehir ve kategori bilgisini kontrol eder.
6. Uygunsa onaylar.
7. Eksikse düzeltme notuyla reddeder.

### Başarı kriteri

Yalnızca doğrulanmış ve uygun içerikler yayına alınır.

---

# 4. Senaryo Öncelikleri

| Senaryo | Öncelik | Sürüm |
|---|---|---|
| Yerli turist şehir keşfeder | Çok yüksek | 1.0 |
| Kullanıcı etkinlik bulur | Yüksek | 1.0 |
| Kullanıcı favori ekler | Yüksek | 1.0 |
| Haritada yakın yerleri görür | Yüksek | 1.0 |
| AI rota oluşturur | Çok yüksek | 1.1 |
| Belediye etkinlik ekler | Yüksek | 2.0 |
| İşletme profil günceller | Orta-yüksek | 2.0+ |
| İçerik onaylanır | Yüksek | 2.1 |

---

# 5. Sonuç

GezioGo’da kullanıcı senaryoları hem mobil hem panel tarafında düşünülmelidir.

Mobil tarafta amaç:

> Kullanıcının şehirde ne yapacağını, nereye gideceğini ve rotasını nasıl planlayacağını kolaylaştırmak.

Panel tarafında amaç:

> Şehir, kurum ve işletme içeriklerinin kontrollü, yetkili ve sürdürülebilir şekilde yönetilmesini sağlamak.

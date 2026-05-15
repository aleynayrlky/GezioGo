# GezioGo – Kullanıcı Personaları

> Hafta 2 / Gün 1 çıktısı  
> Dosya amacı: GezioGo’nun hem mobil uygulama kullanıcılarını hem de panel/admin/iş ortağı kullanıcılarını tanımlamak.

---

## 1. Dokümanın Amacı

Bu dosya, GezioGo projesinde kimler için ürün geliştirildiğini netleştirmek için hazırlanmıştır.

GezioGo yalnızca bir mobil şehir keşif uygulaması değildir. Aynı zamanda arka tarafta farklı kurumların, işletmelerin ve editörlerin içerik yönetebileceği çok paydaşlı bir platformdur.

Bu yüzden kullanıcı personları iki ana gruba ayrılır:

```text
1. Mobil Uygulama Kullanıcıları
2. Panel / Admin / İş Ortağı Kullanıcıları
```

---

## 2. Kullanıcı Grupları

### 2.1 Mobil Uygulama Kullanıcıları

- Yerli turist
- Yabancı turist
- Şehirde yaşayan kullanıcı
- Öğrenci
- Çocuklu aile
- Yaşlı kullanıcı
- Engelli birey

### 2.2 Panel / Admin / İş Ortağı Kullanıcıları

- GezioGo Super Admin / Kurucu
- GezioGo içerik editörü
- Belediye yetkilisi
- İl Kültür ve Turizm Müdürlüğü yetkilisi
- Bakanlık temsilcisi
- Restoran / kafe / işletme sahibi
- Otel / acente yetkilisi
- Etkinlik organizatörü
- İçerik onay yetkilisi

---

# 3. Mobil Kullanıcı Personaları

## 3.1 Yerli Turist – Elif

### Kimdir?

Elif, hafta sonu veya kısa tatillerde Türkiye içinde şehir gezen bir kullanıcıdır. Gittiği şehirde en önemli yerleri kısa sürede görmek ister.

### Ne ister?

- Şehirde görülmesi gereken yerleri öğrenmek
- Kısıtlı zamanda iyi bir rota oluşturmak
- Haritada mekanları görmek
- Ücretsiz veya uygun fiyatlı alternatifleri bulmak
- Etkinliklerden haberdar olmak

### Hangi problemi yaşar?

- Bilgiler farklı kaynaklara dağılmıştır.
- Hangi yerin gerçekten görülmeye değer olduğunu anlamakta zorlanır.
- Rota oluşturmak zaman alır.
- Mekan, saat, bilet ve ulaşım bilgilerini ayrı ayrı arar.

### GezioGo’da ne yapar?

- Şehir seçer.
- Ana sayfadan önerileri inceler.
- Kategori seçer.
- Mekan detayına girer.
- Haritada görüntüler.
- AI rota oluşturur.
- Favorilere ekler.

### Kullandığı ekranlar

- Şehir Seçimi
- Ana Sayfa
- Keşfet / Kategoriler
- Mekan Listesi
- Mekan Detay
- Harita
- AI Rota Formu
- AI Rota Sonucu
- Favoriler

### MVP önceliği

**Çok yüksek**

---

## 3.2 Şehirde Yaşayan Kullanıcı – Deniz

### Kimdir?

Deniz, kendi şehrinde yaşayan ama hafta sonu veya akşamları yeni yerler ve etkinlikler keşfetmek isteyen kullanıcıdır.

### Ne ister?

- Bugün veya bu hafta ne yapabileceğini görmek
- Yakınındaki mekanları bulmak
- Etkinlikleri takip etmek
- Daha önce gitmediği yerleri keşfetmek

### Hangi problemi yaşar?

- Şehirdeki etkinliklerden geç haberdar olur.
- Yerel duyurular farklı sosyal medya hesaplarına dağılmıştır.
- Yakınındaki alternatifleri kolayca göremez.

### GezioGo’da ne yapar?

- Yakındaki keşifleri inceler.
- Etkinlikleri filtreler.
- Favori listesi oluşturur.
- Harita üzerinden yakın yerleri görür.

### Kullandığı ekranlar

- Ana Sayfa
- Etkinlikler
- Harita
- Favoriler
- Mekan Detay

### MVP önceliği

**Yüksek**

---

## 3.3 Öğrenci – Mert

### Kimdir?

Mert, düşük bütçeyle gezmek, arkadaşlarıyla plan yapmak ve ücretsiz etkinlikleri görmek isteyen üniversite öğrencisidir.

### Ne ister?

- Ücretsiz veya uygun fiyatlı yerler
- Toplu taşımayla gidilebilecek rotalar
- Öğrenci dostu mekanlar
- Arkadaş grubuyla kısa sürede plan

### Hangi problemi yaşar?

- Bütçesine uygun seçenekleri hızlı bulamaz.
- Etkinlikleri geç fark eder.
- Toplu taşıma ve yürüme mesafesini planlamak zor gelir.

### GezioGo’da ne yapar?

- Ücretsiz filtreyi kullanır.
- Öğrenci dostu yerleri inceler.
- AI rota formunda düşük bütçe seçer.
- Favorilerine yer ekler.

### Kullandığı ekranlar

- Keşfet
- Filtreleme
- Etkinlikler
- AI Rota Formu
- AI Rota Sonucu
- Favoriler

### MVP önceliği

**Yüksek**

---

## 3.4 Çocuklu Aile – Zeynep

### Kimdir?

Zeynep, çocuğuyla birlikte güvenli ve rahat gezilecek yerler arayan bir kullanıcıdır.

### Ne ister?

- Çocukla gidilebilir mekanlar
- Yorucu olmayan rota
- Kapalı/açık alan seçeneği
- Tuvalet, otopark, erişilebilirlik gibi pratik bilgiler

### Hangi problemi yaşar?

- Her mekan çocukla gitmeye uygun değildir.
- Mekanların aile dostu olup olmadığı net değildir.
- Plansız gezi aile için yorucu olabilir.

### GezioGo’da ne yapar?

- Çocukla uygun filtreleri kullanır.
- AI rota formunda aile seçeneğini işaretler.
- Mekan detayında erişilebilirlik ve pratik bilgileri inceler.

### Kullandığı ekranlar

- Keşfet
- Filtreleme
- Mekan Detay
- AI Rota Formu
- Harita

### MVP önceliği

**Orta-yüksek**

---

## 3.5 Engelli Birey – Ayşe

### Kimdir?

Ayşe, erişilebilir mekan bilgisine ihtiyaç duyan ve gitmeden önce mekanın uygunluğunu bilmek isteyen kullanıcıdır.

### Ne ister?

- Tekerlekli sandalye uygunluğu
- Kolay giriş bilgisi
- Ulaşım ve yürüme mesafesi bilgisi
- Daha güvenli rota önerisi

### Hangi problemi yaşar?

- Erişilebilirlik bilgisi çoğu yerde eksiktir.
- Uygun olmayan mekanlara gitme riski vardır.
- Alternatif rota bulmak zordur.

### GezioGo’da ne yapar?

- Erişilebilirlik filtresi kullanır.
- Mekan detayında erişilebilirlik notlarını inceler.
- AI rota formunda özel ihtiyaç bilgisini seçer.

### Kullandığı ekranlar

- Keşfet
- Mekan Detay
- Harita
- AI Rota Formu

### MVP önceliği

**Orta**

---

# 4. Panel / Admin / İş Ortağı Personaları

## 4.1 GezioGo Super Admin / Kurucu – Sen

### Kimdir?

GezioGo’nun kurucusu ve sistemin en yetkili kullanıcısıdır. Tüm sistemi görebilir, yönetebilir ve yetki verebilir.

### Ne ister?

- Tüm şehirleri yönetmek
- Kurum ve işletme hesapları oluşturmak
- Kullanıcı rolleri vermek
- İçerikleri görmek ve onaylamak
- Raporları incelemek
- Sistemin sağlıklı çalışmasını kontrol etmek

### Görebilir

- Tüm şehirler
- Tüm kurumlar
- Tüm işletmeler
- Tüm kullanıcılar
- Tüm içerikler
- Tüm onay süreçleri
- Tüm raporlar
- Sistem ayarları

### Yapabilir

- Şehir ekleyebilir.
- Kurum hesabı açabilir.
- İşletme hesabı açabilir.
- Kullanıcı rolü verebilir.
- İçerik yayınlayabilir veya kaldırabilir.
- Raporları görebilir.
- Panel yetkilerini düzenleyebilir.

### Yapamaz / Yapmamalı

- Yetkisiz kişilerin verilerine açık erişim vermemelidir.
- Kurumların kendi onay sürecini atlamamalıdır.

### Panel ekranları

- Dashboard
- Şehirler
- Kurumlar
- İşletmeler
- Kullanıcılar ve Roller
- İçerik Yönetimi
- Onay Süreci
- Raporlar
- Ayarlar

### MVP önceliği

**Çok yüksek**

---

## 4.2 Belediye Yetkilisi

### Kimdir?

Bir belediyenin kültür, turizm veya tanıtım tarafında çalışan yetkili kullanıcıdır.

### Ne ister?

- Kendi şehrindeki mekanları güncellemek
- Etkinlik eklemek
- Duyuru girmek
- Şehir bilgilerini güncel tutmak
- Kendi şehrine ait raporları görmek

### Görebilir

- Sadece kendi belediyesine bağlı şehir verileri
- Kendi belediyesinin eklediği mekanlar
- Kendi belediyesinin etkinlikleri
- Kendi şehriyle ilgili raporlar

### Yapabilir

- Mekan ekleyebilir.
- Etkinlik ekleyebilir.
- Duyuru ekleyebilir.
- İçeriği onaya gönderebilir.
- Kendi kurum bilgilerini düzenleyebilir.

### Göremez / Yapamaz

- Diğer şehirleri yönetemez.
- Diğer belediyelerin içeriklerini düzenleyemez.
- Tüm sistem kullanıcılarını göremez.
- Sistem ayarlarını değiştiremez.

### Panel ekranları

- Belediye Dashboard
- Şehir Bilgileri
- Mekanlar
- Etkinlikler
- Duyurular
- Onay Durumu
- Raporlar

### MVP önceliği

**Yüksek**

---

## 4.3 İl Kültür ve Turizm Müdürlüğü Yetkilisi

### Kimdir?

İl düzeyinde kültür, müze, turizm ve etkinlik içeriklerinden sorumlu kamu kurumu temsilcisidir.

### Ne ister?

- Kültürel alanları ve müzeleri yönetmek
- Turizm içeriklerini güncellemek
- İl genelindeki etkinlikleri eklemek
- Doğrulanmış içerik sunmak

### Görebilir

- Kendi ilindeki kültür/turizm içerikleri
- Müzeler
- Tarihi alanlar
- Kültür etkinlikleri
- Kendi kurumunun eklediği içerikler

### Yapabilir

- Müze ve kültürel alan ekleyebilir.
- Kültür etkinliği ekleyebilir.
- İçeriği onaya gönderebilir.
- Kaynak URL ve doğrulama tarihi ekleyebilir.

### Göremez / Yapamaz

- İşletme hesaplarını yönetemez.
- Başka ilin içeriklerini düzenleyemez.
- Sistem rollerini değiştiremez.

### Panel ekranları

- Kurum Dashboard
- Kültürel Alanlar
- Müzeler
- Etkinlikler
- Yayınlar / Duyurular
- Onay Durumu

### MVP önceliği

**Orta-yüksek**

---

## 4.4 Bakanlık Temsilcisi

### Kimdir?

Üst düzey görünüm, raporlama ve stratejik takip için sisteme erişen bakanlık kullanıcısıdır.

### Ne ister?

- Şehirlerin genel durumunu görmek
- Turizm içeriklerini izlemek
- Raporlar almak
- Ulusal ölçekte görünürlük ve performans takip etmek

### Görebilir

- Üst düzey şehir raporları
- İçerik dağılımları
- Kurum performansları
- Yayınlanan içerikler

### Yapabilir

- Rapor görüntüleyebilir.
- Kurum performansını takip edebilir.
- Genel değerlendirme yapabilir.

### Göremez / Yapamaz

- Günlük işletme içeriklerini doğrudan değiştirmemelidir.
- Restoran/kafe içeriklerini düzenlememelidir.
- Sistem ayarlarını değiştirmemelidir.

### Panel ekranları

- Bakanlık Dashboard
- Şehir Raporları
- Kurum Raporları
- İçerik İstatistikleri
- Genel Performans

### MVP önceliği

**Orta**

---

## 4.5 Restoran / Kafe / İşletme Sahibi

### Kimdir?

GezioGo’da kendi işletmesini görünür hale getirmek isteyen restoran, kafe veya mekan sahibidir.

### Ne ister?

- İşletme profilini düzenlemek
- Fotoğraf eklemek
- Menü veya hizmet bilgisi eklemek
- Kampanya eklemek
- Görüntülenme ve favori istatistiklerini görmek

### Görebilir

- Sadece kendi işletme profili
- Kendi fotoğrafları
- Kendi kampanyaları
- Kendi yorumları / geri bildirimleri
- Kendi istatistikleri

### Yapabilir

- İşletme bilgisi güncelleyebilir.
- Fotoğraf yükleyebilir.
- Kampanya oluşturabilir.
- Çalışma saatleri girebilir.
- İçeriği onaya gönderebilir.

### Göremez / Yapamaz

- Başka işletmeleri düzenleyemez.
- Belediye içeriklerini göremez.
- Kullanıcı listesini göremez.
- Sistemde yayınlama yetkisi olmayabilir.

### Panel ekranları

- İşletme Dashboard
- İşletme Bilgilerim
- Fotoğraflar
- Menü / Hizmetler
- Kampanyalar
- Yorumlar
- İstatistikler
- Onay Durumu

### MVP önceliği

**Yüksek**

---

## 4.6 Etkinlik Organizatörü

### Kimdir?

Konser, festival, tiyatro, atölye veya kültürel etkinlikleri GezioGo’da yayınlamak isteyen organizatördür.

### Ne ister?

- Etkinlik oluşturmak
- Bilet linki eklemek
- Tarih ve mekan bilgisi girmek
- Etkinlik görselleri yüklemek
- Katılım ve görüntülenme istatistiklerini görmek

### Görebilir

- Kendi etkinlikleri
- Kendi bilet linkleri
- Kendi etkinlik istatistikleri

### Yapabilir

- Etkinlik ekleyebilir.
- Etkinlik düzenleyebilir.
- Bilet linki ekleyebilir.
- Görsel yükleyebilir.
- Onaya gönderebilir.

### Göremez / Yapamaz

- Başka organizatörlerin etkinliklerini düzenleyemez.
- Mekan verilerini yönetemez.
- Kullanıcı veya kurum yönetemez.

### Panel ekranları

- Etkinlik Dashboard
- Etkinliklerim
- Yeni Etkinlik Ekle
- Bilet Linkleri
- İstatistikler
- Onay Durumu

### MVP önceliği

**Orta-yüksek**

---

## 4.7 GezioGo Editörü

### Kimdir?

GezioGo ekibi içinde içerik giren, düzenleyen ve taslak oluşturan kullanıcıdır.

### Ne ister?

- Mekan ve etkinlik içeriği oluşturmak
- Eksik içerikleri tamamlamak
- Kaynak ve doğrulama bilgisi eklemek
- İçeriği onaya göndermek

### Görebilir

- Kendisine atanmış içerikler
- Taslaklar
- Düzenleme bekleyen içerikler

### Yapabilir

- İçerik girebilir.
- İçerik düzenleyebilir.
- Taslak oluşturabilir.
- Onaya gönderebilir.

### Göremez / Yapamaz

- İçeriği doğrudan yayına alamaz.
- Kullanıcı rolleri veremez.
- Sistem ayarlarını değiştiremez.

### Panel ekranları

- Editör Dashboard
- İçeriklerim
- Taslaklar
- Yeni Mekan Ekle
- Yeni Etkinlik Ekle
- Onaya Gönderilenler

### MVP önceliği

**Yüksek**

---

## 4.8 İçerik Onay Yetkilisi

### Kimdir?

Editör, kurum veya işletmelerden gelen içerikleri kontrol eden ve yayınlanıp yayınlanmayacağına karar veren kullanıcıdır.

### Ne ister?

- Bekleyen içerikleri görmek
- İçerikleri kontrol etmek
- Eksik bilgi varsa reddetmek
- Uygun içerikleri onaylamak

### Görebilir

- Onay bekleyen içerikler
- İçerik detayları
- Kaynak URL’leri
- Değişiklik geçmişi

### Yapabilir

- İçerik onaylayabilir.
- İçerik reddedebilir.
- Düzeltme notu yazabilir.
- Yayına alabilir.

### Göremez / Yapamaz

- Sistem ayarlarını değiştiremez.
- Kullanıcı rolleri veremez.
- Kendi yetkisi dışındaki kurumları yönetemez.

### Panel ekranları

- Onay Paneli
- Bekleyen İçerikler
- İçerik Detay
- Onayla / Reddet
- Reddedilenler
- Onaylananlar

### MVP önceliği

**Yüksek**

---

# 5. Rol ve Yetki Özeti

| Kullanıcı Tipi | Görebilir | Yapabilir | Göremez / Yapamaz |
|---|---|---|---|
| Super Admin | Tüm sistem | Her şeyi yönetir | Yok |
| Belediye Yetkilisi | Kendi şehri | Mekan, etkinlik, duyuru ekler | Diğer şehirleri yönetemez |
| İl Müdürlüğü | Kendi ilindeki kültür/turizm içerikleri | Müze, kültür alanı, etkinlik ekler | İşletme hesaplarını yönetemez |
| Bakanlık | Genel raporlar | Denetler ve raporlar | Günlük işletme içeriği düzenlemez |
| Restoran/Kafe | Kendi işletmesi | Profil, fotoğraf, kampanya ekler | Başka işletmeleri göremez |
| Etkinlik Organizatörü | Kendi etkinlikleri | Etkinlik ekler/düzenler | Şehir verilerini yönetemez |
| Editör | Atanan içerikler | Taslak oluşturur | Yayınlayamaz |
| Onay Yetkilisi | Bekleyen içerikler | Onaylar/reddeder | Sistem ayarlarını değiştiremez |

---

# 6. MVP Önceliklendirmesi

## 6.1 Mobil MVP için öncelikli kullanıcılar

1. Yerli turist
2. Şehirde yaşayan kullanıcı
3. Öğrenci
4. Çocuklu aile

## 6.2 Panel MVP için öncelikli kullanıcılar

1. GezioGo Super Admin
2. GezioGo Editörü
3. Belediye / Kurum Yetkilisi
4. Restoran / Kafe / İşletme Sahibi
5. İçerik Onay Yetkilisi

---

# 7. Sonuç

GezioGo’da kullanıcı yapısı iki taraflı düşünülmelidir:

- **Mobil tarafta:** şehir keşfeden son kullanıcılar.
- **Panel tarafında:** şehir, kurum, işletme ve içerik yönetimi yapan paydaşlar.

Ana kural:

> Her kullanıcı yalnızca kendi rolüne, kurumuna, şehrine veya işletmesine ait alanları görmeli ve yönetmelidir.

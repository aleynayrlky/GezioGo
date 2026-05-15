# GezioGo – Panel Kullanıcı Akışları ve Rol Bazlı Yetkiler

> Hafta 2 / Gün 4 çıktısı  
> Dosya amacı: GezioGo yönetim panelinde farklı kullanıcı tiplerinin hangi ekranları göreceğini, hangi işlemleri yapabileceğini ve hangi alanlara erişemeyeceğini netleştirmek.

---

## 1. Dokümanın Amacı

GezioGo paneli yalnızca belediye paneli değildir. Bu panel; GezioGo ekibi, belediyeler, il kültür ve turizm müdürlükleri, bakanlık temsilcileri, restoran/kafe işletmeleri, oteller, acenteler ve etkinlik organizatörleri tarafından farklı yetkilerle kullanılacak çok paydaşlı bir sistemdir.

Ana ilke:

> Her kullanıcı sadece kendi rolüne, kurumuna, şehrine veya işletmesine ait alanları görmeli ve yönetmelidir.

---

## 2. Temel Panel Mantığı

```text
Kullanıcı Giriş Yapar
   ↓
Kimlik Doğrulama
   ↓
Rol ve Yetki Kontrolü
   ↓
Kullanıcı Tipine Uygun Panel Görünümü
   ↓
Yetkili Olduğu İşlemleri Yapar
   ↓
Gerekirse İçerik Onay Sürecine Girer
```

---

## 3. Panel Kullanıcı Tipleri

1. Super Admin / GezioGo Kurucusu
2. GezioGo Editörü
3. Belediye Yetkilisi
4. İl Kültür ve Turizm Müdürlüğü Yetkilisi
5. Bakanlık Temsilcisi
6. Restoran / Kafe / İşletme Sahibi
7. Otel / Acente Yetkilisi
8. Etkinlik Organizatörü
9. İçerik Onay Yetkilisi

---

# 4. Kullanıcı Tipine Göre Panel Akışları

## 4.1 Super Admin Akışı

### Kullanıcı tipi

GezioGo kurucusu / sistem yöneticisi.

### Giriş sonrası gördüğü ekran

```text
Login
   ↓
Super Admin Dashboard
```

### Görebildiği menüler

- Dashboard
- Şehirler
- Kurumlar
- İşletmeler
- Kullanıcılar ve Roller
- İçerik Yönetimi
- Mekanlar
- Etkinlikler
- Onay Süreci
- Başvurular / Talepler
- Raporlar
- Analitik
- Ayarlar

### Yapabildiği işlemler

- Şehir ekleme
- Kurum hesabı oluşturma
- İşletme hesabı oluşturma
- Kullanıcı oluşturma
- Rol ve yetki verme
- Tüm içerikleri görme
- İçerik yayınlama / yayından kaldırma
- Raporları inceleme
- Onay sürecini yönetme
- Sistem ayarlarını düzenleme

### Göremediği / yapamadığı alan

Yok. Ancak güvenlik gereği tüm işlemler loglanmalıdır.

### Akış

```text
Super Admin Dashboard
   ↓
Kullanıcılar ve Roller
   ↓
Yeni Kullanıcı Oluştur
   ↓
Kurum / İşletme Seç
   ↓
Rol Belirle
   ↓
Yetki Kapsamı Belirle
   ↓
Davet Gönder
```

---

## 4.2 Belediye Yetkilisi Akışı

### Kullanıcı tipi

Belediye / şehir yöneticisi.

### Giriş sonrası gördüğü ekran

```text
Login
   ↓
Belediye Dashboard
```

### Görebildiği menüler

- Panelim
- Şehir Bilgileri
- Mekanlar
- Etkinlikler
- Duyurular
- Kampanyalar
- Onay Durumu
- Raporlar
- Ayarlar

### Yapabildiği işlemler

- Kendi şehrine mekan ekleme
- Kendi şehrine etkinlik ekleme
- Duyuru oluşturma
- Görsel yükleme
- İçeriği onaya gönderme
- Kendi şehir raporlarını görme

### Göremediği / yapamadığı alanlar

- Başka şehirleri yönetemez.
- Başka belediyelerin içeriklerini düzenleyemez.
- Tüm kullanıcı listesini göremez.
- Sistem rollerini değiştiremez.

### Akış: belediye etkinlik ekler

```text
Belediye Dashboard
   ↓
Etkinlikler
   ↓
Yeni Etkinlik Ekle
   ↓
Etkinlik Bilgilerini Gir
   ↓
Görsel Yükle
   ↓
Bilet Linki Ekle
   ↓
Onaya Gönder
   ↓
Onay Bekleniyor
```

---

## 4.3 İl Kültür ve Turizm Müdürlüğü Akışı

### Kullanıcı tipi

İl düzeyinde kültür/turizm içeriklerinden sorumlu kurum kullanıcısı.

### Görebildiği menüler

- Kurum Paneli
- Kültürel Alanlar
- Müzeler
- Tarihi Yerler
- Etkinlikler
- Yayınlar / Duyurular
- Onay Durumu
- Raporlar

### Yapabildiği işlemler

- Müze ekleme
- Tarihi alan bilgisi güncelleme
- Kültür etkinliği ekleme
- Kaynak URL ekleme
- Son doğrulama tarihi girme
- İçeriği onaya gönderme

### Göremediği / yapamadığı alanlar

- İşletme hesaplarını yönetemez.
- Restoran/kafe içeriklerini doğrudan değiştiremez.
- Başka illerin içeriklerini düzenleyemez.
- Sistem kullanıcı rolleri veremez.

### Akış: müze bilgisi günceller

```text
Kurum Paneli
   ↓
Müzeler
   ↓
Müze Seç
   ↓
Bilgileri Düzenle
   ↓
Kaynak URL Ekle
   ↓
Son Doğrulama Tarihi Gir
   ↓
Onaya Gönder
```

---

## 4.4 Bakanlık Temsilcisi Akışı

### Kullanıcı tipi

Ulusal ölçekte takip, raporlama ve strateji amacıyla sisteme erişen üst düzey kurum kullanıcısı.

### Görebildiği menüler

- Genel Dashboard
- Şehir Raporları
- Kurum Raporları
- İçerik İstatistikleri
- Yayınlanan İçerikler
- Performans Raporları

### Yapabildiği işlemler

- Şehir raporlarını görüntüleme
- Kurum performansını inceleme
- İçerik dağılımlarını görme
- Genel turizm verisi raporlarını alma

### Göremediği / yapamadığı alanlar

- Günlük işletme içeriğini düzenleyemez.
- Restoran/kafe profillerini yönetemez.
- Kullanıcı rolleri değiştiremez.
- Sistem ayarlarına müdahale etmez.

### Akış: genel rapor inceler

```text
Bakanlık Dashboard
   ↓
Şehir Raporları
   ↓
Şehir / Bölge Filtresi
   ↓
Turizm İçerik Dağılımı
   ↓
Raporu Görüntüle
   ↓
PDF / Excel Olarak Dışa Aktar
```

---

## 4.5 Restoran / Kafe / İşletme Sahibi Akışı

### Kullanıcı tipi

Kendi işletmesini GezioGo’da yöneten işletme sahibi.

### Görebildiği menüler

- Panelim
- İşletme Bilgilerim
- Fotoğraflar
- Menü / Hizmetler
- Kampanyalar
- Yorumlar
- İstatistikler
- Onay Durumu
- Ayarlar

### Yapabildiği işlemler

- Kendi işletme bilgisini düzenleme
- Görsel yükleme
- Menü/hizmet bilgisi ekleme
- Kampanya oluşturma
- Çalışma saatlerini düzenleme
- Onaya gönderme

### Göremediği / yapamadığı alanlar

- Başka işletmeleri göremez.
- Belediyenin şehir içeriklerini yönetemez.
- Kullanıcı listelerini göremez.
- İçeriği doğrudan yayına alma yetkisi olmayabilir.

### Akış: kampanya ekler

```text
İşletme Paneli
   ↓
Kampanyalar
   ↓
Yeni Kampanya Oluştur
   ↓
Başlık / Açıklama / Tarih Gir
   ↓
Görsel Ekle
   ↓
Onaya Gönder
   ↓
Onay Bekleniyor
```

---

## 4.6 Otel / Acente Yetkilisi Akışı

### Kullanıcı tipi

Turistlere ulaşmak isteyen otel veya turizm acentesi kullanıcısı.

### Görebildiği menüler

- Panelim
- İşletme / Acente Bilgilerim
- Paketler / Öneriler
- Kampanyalar
- Görseller
- İstatistikler
- Onay Durumu

### Yapabildiği işlemler

- Profil bilgisi düzenleme
- Tur/öneri paketi ekleme
- Görsel yükleme
- Kampanya ekleme
- Onaya gönderme

### Göremediği / yapamadığı alanlar

- Şehir verilerini yönetemez.
- Belediye etkinliklerini düzenleyemez.
- Diğer işletme veya acenteleri göremez.

---

## 4.7 Etkinlik Organizatörü Akışı

### Kullanıcı tipi

Konser, festival, tiyatro, atölye veya özel etkinlikleri ekleyen organizatör.

### Görebildiği menüler

- Etkinlik Paneli
- Etkinliklerim
- Yeni Etkinlik Ekle
- Bilet Linkleri
- Görseller
- Katılımcı / Görüntülenme İstatistikleri
- Onay Durumu

### Yapabildiği işlemler

- Etkinlik ekleme
- Etkinlik düzenleme
- Tarih/saat/mekan bilgisi girme
- Bilet linki ekleme
- Görsel yükleme
- Onaya gönderme

### Göremediği / yapamadığı alanlar

- Diğer organizatörlerin etkinliklerini düzenleyemez.
- Mekan veri tabanını yönetemez.
- Kullanıcı rolleri veremez.

### Akış: etkinlik ekler

```text
Etkinlik Paneli
   ↓
Yeni Etkinlik Ekle
   ↓
Temel Bilgiler
   ↓
Tarih ve Saat
   ↓
Mekan Seç / Yeni Mekan Öner
   ↓
Bilet Linki Ekle
   ↓
Görsel Yükle
   ↓
Onaya Gönder
```

---

## 4.8 GezioGo Editörü Akışı

### Kullanıcı tipi

GezioGo ekibi içinde içerik hazırlayan ve taslak oluşturan kullanıcı.

### Görebildiği menüler

- Editör Paneli
- İçeriklerim
- Taslaklar
- Yeni Mekan Ekle
- Yeni Etkinlik Ekle
- Onaya Gönderilenler

### Yapabildiği işlemler

- İçerik taslağı oluşturma
- İçerik düzenleme
- Kaynak URL ekleme
- Görsel ekleme
- Onaya gönderme

### Göremediği / yapamadığı alanlar

- İçeriği doğrudan yayına alamaz.
- Kullanıcı rolleri veremez.
- Sistem ayarlarını değiştiremez.

---

## 4.9 İçerik Onay Yetkilisi Akışı

### Kullanıcı tipi

Onay sürecindeki içerikleri kontrol eden kullanıcı.

### Görebildiği menüler

- Onay Paneli
- Bekleyen İçerikler
- Onaylananlar
- Reddedilenler
- Düzeltme Bekleyenler

### Yapabildiği işlemler

- İçerik detayını açma
- Kaynak ve doğruluk kontrolü yapma
- Onaylama
- Reddetme
- Düzeltme notu yazma
- Yayına alma

### Göremediği / yapamadığı alanlar

- Sistem ayarlarını değiştiremez.
- Kullanıcı rolleri veremez.
- Kendi yetkisi dışındaki kurum içeriklerini onaylayamaz.

### Akış: içerik onaylar

```text
Onay Paneli
   ↓
Bekleyen İçerikler
   ↓
İçerik Detayını Aç
   ↓
Bilgi / Görsel / Kaynak Kontrolü
   ↓
Karar Ver
   ├── Onayla → Yayına Al
   └── Reddet → Düzeltme Notu Gönder
```

---

# 5. İçerik Yayın Süreci

```text
İçerik Girişi
   ↓
Taslak Kaydı
   ↓
Onaya Gönder
   ↓
İnceleme
   ↓
Onay / Red
   ↓
Yayınlama
   ↓
Mobil Uygulamada Görünme
```

---

# 6. Rol Bazlı Erişim Matrisi

| Ekran / İşlem | Super Admin | Belediye | İl Müdürlüğü | Bakanlık | İşletme | Organizatör | Editör | Onaycı |
|---|---|---|---|---|---|---|---|---|
| Tüm şehirleri görme | Evet | Hayır | Hayır | Evet | Hayır | Hayır | Kısmi | Kısmi |
| Kendi şehir içeriklerini yönetme | Evet | Evet | Evet | Hayır | Hayır | Hayır | Kısmi | Hayır |
| İşletme profil düzenleme | Evet | Hayır | Hayır | Hayır | Evet | Hayır | Hayır | Hayır |
| Etkinlik ekleme | Evet | Evet | Evet | Hayır | Kısmi | Evet | Evet | Hayır |
| İçerik onaylama | Evet | Kısmi | Kısmi | Hayır | Hayır | Hayır | Hayır | Evet |
| Kullanıcı rolü verme | Evet | Hayır | Hayır | Hayır | Hayır | Hayır | Hayır | Hayır |
| Rapor görüntüleme | Evet | Kendi şehri | Kendi ili | Genel | Kendi işletmesi | Kendi etkinlikleri | Hayır | Kısmi |
| Sistem ayarları | Evet | Hayır | Hayır | Hayır | Hayır | Hayır | Hayır | Hayır |

---

# 7. Panel MVP Öncelikleri

## Panel MVP’de olmalı

- Giriş / yetkilendirme
- Rol bazlı menü görünümü
- Super Admin dashboard
- Belediye / kurum dashboard
- İşletme dashboard başlangıcı
- Mekan ekleme formu
- Etkinlik ekleme formu
- İçerik onay listesi
- Onayla / reddet işlemi

## Panel MVP sonrası

- Gelişmiş raporlar
- Bakanlık üst düzey paneli
- Otel/acente paneli
- Kampanya yönetimi
- Detaylı analitik
- Kurum içi çoklu kullanıcı yönetimi

---

# 8. Sonuç

GezioGo panel sistemi, çok paydaşlı ve rol bazlı düşünülmelidir.

Ana kural:

> Panelde herkes aynı ekranı görmemeli; herkes yalnızca kendi rolüne ve yetki kapsamına uygun işlemleri yapmalıdır.

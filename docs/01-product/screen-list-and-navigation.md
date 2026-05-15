# GezioGo – Ekran Listesi ve Navigasyon Planı

> Hafta 2 / Gün 6 çıktısı  
> Dosya amacı: GezioGo mobil uygulaması ve yönetim paneli için gerekli ekranları listelemek ve temel navigasyon yapısını tanımlamak.

---

## 1. Dokümanın Amacı

Bu dosya, GezioGo’da hangi ekranların olacağını ve bu ekranların nasıl bağlanacağını netleştirmek için hazırlanmıştır.

İki ayrı ürün yüzeyi vardır:

```text
1. Mobil Uygulama
2. Yönetim Paneli / Admin Panel
```

---

# 2. Mobil Uygulama Ekranları

## 2.1 Giriş ve Kurulum Ekranları

| Ekran | Amaç | MVP |
|---|---|---|
| Splash Screen | Marka açılışı | Evet |
| Onboarding | Uygulamayı tanıtmak | Evet |
| Konum İzni | Yakındaki yerler için izin almak | Evet |
| Bildirim İzni | Etkinlik/rota bildirimleri için | Sonra |
| Şehir Seçimi | Kullanıcının şehir seçmesi | Evet |

---

## 2.2 Ana Navigasyon Ekranları

Alt tab bar önerisi:

```text
Ana Sayfa | Keşfet | Planla | Favoriler | Profil
```

| Ekran | Amaç | MVP |
|---|---|---|
| Ana Sayfa | Öne çıkan şehir, öneriler, hızlı erişim | Evet |
| Keşfet / Kategoriler | Kategori bazlı keşif | Evet |
| Planla | AI rota oluşturma başlangıcı | 1.1 |
| Favoriler | Kaydedilen içerikler | Evet |
| Profil | Kullanıcı tercihleri ve ayarlar | 1.2 |

---

## 2.3 Keşif ve İçerik Ekranları

| Ekran | Amaç | MVP |
|---|---|---|
| Kategori Listesi | Gezilecek yer, müze, doğa, yeme-içme vb. | Evet |
| Mekan Listesi | Seçilen kategoriye ait mekanlar | Evet |
| Mekan Detay | Mekan açıklaması, saat, adres, ücret, harita | Evet |
| Etkinlik Listesi | Şehirdeki etkinlikleri gösterir | Evet |
| Etkinlik Detay | Etkinlik tarih, saat, mekan, bilet linki | Evet |
| Harita | Mekan ve etkinlik pinleri | Evet |
| Arama Sonuçları | Arama ile bulunan içerikler | Evet |
| Filtre Paneli | Kategori ve özellik filtreleri | Evet |

---

## 2.4 AI Rota Ekranları

| Ekran | Amaç | Sürüm |
|---|---|---|
| AI Rota Formu | Kullanıcı tercihlerini toplar | 1.1 |
| AI Rota Yükleniyor | Rota oluşturulurken gösterilir | 1.1 |
| AI Rota Sonucu | Oluşturulan rotayı gösterir | 1.1 |
| Rota Detay | Durakları ve açıklamaları gösterir | 1.1 |
| Rota Haritası | Rota pinlerini haritada gösterir | 1.1 |
| Kaydedilen Rotalar | Kullanıcının kayıtlı rotaları | 1.2 |

---

## 2.5 Profil ve Ayarlar Ekranları

| Ekran | Amaç | Sürüm |
|---|---|---|
| Profilim | Kullanıcı genel bilgileri | 1.2 |
| Tercihlerim | İlgi alanı, bütçe, ulaşım | 1.2 |
| Bildirim Ayarları | Bildirim izinleri | 1.2 |
| Dil Ayarları | Türkçe/İngilizce vb. | 5.0 |
| Hesap Ayarları | Giriş/çıkış, hesap yönetimi | 1.2 |

---

## 2.6 Durum Ekranları

| Ekran | Amaç | MVP |
|---|---|---|
| Loading State | Veri yükleniyor | Evet |
| Empty State | Veri yok | Evet |
| Error State | Hata oluştu | Evet |
| İnternet Yok | Bağlantı hatası | Evet |
| Konum İzni Yok | Konum izni isteme | Evet |
| AI Rota Hatası | Rota oluşturulamadı | 1.1 |

---

# 3. Mobil Navigasyon Haritası

## 3.1 Ana akış

```text
Splash
   ↓
Onboarding
   ↓
Şehir Seçimi
   ↓
Ana Sayfa
```

## 3.2 Keşif akışı

```text
Ana Sayfa
   ↓
Keşfet
   ↓
Kategori
   ↓
Mekan Listesi
   ↓
Mekan Detay
   ↓
Harita / Favori / Yol Tarifi
```

## 3.3 Etkinlik akışı

```text
Ana Sayfa
   ↓
Etkinlikler
   ↓
Etkinlik Listesi
   ↓
Etkinlik Detay
   ↓
Bilet Linki / Favori / Harita
```

## 3.4 AI rota akışı

```text
Ana Sayfa
   ↓
Planla
   ↓
AI Rota Formu
   ↓
AI Rota Sonucu
   ↓
Rota Haritası
   ↓
Rotayı Kaydet
```

## 3.5 Favori akışı

```text
Favoriler
   ↓
Mekanlar / Etkinlikler / Rotalar
   ↓
Detay Ekranı
```

---

# 4. Yönetim Paneli Ekranları

## 4.1 Ortak Panel Ekranları

| Ekran | Amaç |
|---|---|
| Login | Panel girişi |
| Dashboard | Kullanıcı tipine göre genel görünüm |
| Profil / Hesap | Kullanıcının panel hesabı |
| Bildirimler | Onay ve sistem bildirimleri |
| Ayarlar | Rolüne uygun ayarlar |

---

## 4.2 Super Admin Panel Ekranları

| Ekran | Amaç |
|---|---|
| Super Admin Dashboard | Tüm sistem genel görünümü |
| Şehirler | Şehir yönetimi |
| Kurumlar | Belediye, müdürlük, bakanlık hesapları |
| İşletmeler | Restoran/kafe/otel/acente hesapları |
| Kullanıcılar ve Roller | Kullanıcı yetki yönetimi |
| İçerik Yönetimi | Tüm içerikler |
| Onay Süreci | Tüm onaylar |
| Raporlar | Sistem raporları |
| Ayarlar | Sistem ayarları |

---

## 4.3 Belediye / Kurum Panel Ekranları

| Ekran | Amaç |
|---|---|
| Kurum Dashboard | Kendi şehir/kurum özeti |
| Şehir Bilgileri | Şehir açıklaması, görseller, temel bilgiler |
| Mekanlar | Kendi şehrindeki mekanlar |
| Mekan Ekle | Yeni mekan girişi |
| Etkinlikler | Kendi etkinlikleri |
| Etkinlik Ekle | Yeni etkinlik girişi |
| Duyurular | Şehir/kultur duyuruları |
| Onay Durumu | Gönderilen içeriklerin durumu |
| Raporlar | Kendi şehir/kurum raporları |

---

## 4.4 İşletme Panel Ekranları

| Ekran | Amaç |
|---|---|
| İşletme Dashboard | İşletme özeti |
| İşletme Bilgilerim | Adres, açıklama, kategori |
| Fotoğraflar | Görsel yönetimi |
| Menü / Hizmetler | Sunulan hizmetler |
| Kampanyalar | İşletme kampanyaları |
| Yorumlar | Geri bildirimler |
| İstatistikler | Görüntülenme, favori, etkileşim |
| Onay Durumu | Yayın durumu |

---

## 4.5 Etkinlik Organizatörü Panel Ekranları

| Ekran | Amaç |
|---|---|
| Etkinlik Dashboard | Organizasyon özeti |
| Etkinliklerim | Kendi etkinlikleri |
| Yeni Etkinlik Ekle | Etkinlik giriş formu |
| Bilet Linkleri | Kayıt/bilet linkleri |
| Görseller | Etkinlik görselleri |
| İstatistikler | Görüntülenme/kayıt verileri |
| Onay Durumu | Yayın/onay durumu |

---

## 4.6 Onay Paneli Ekranları

| Ekran | Amaç |
|---|---|
| Onay Dashboard | Bekleyen içerik özeti |
| Bekleyen İçerikler | Onay bekleyen içerikler |
| İçerik Detay | İnceleme ekranı |
| Onayla / Reddet | Karar ekranı |
| Reddedilenler | Red verilen içerikler |
| Onaylananlar | Yayına alınan içerikler |

---

# 5. Panel Navigasyon Mantığı

## 5.1 Rol bazlı yönlendirme

```text
Panel Login
   ↓
Kullanıcı Rolü Kontrolü
   ↓
Rolüne Uygun Dashboard
```

Örnek:

```text
Super Admin → Super Admin Dashboard
Belediye → Belediye Dashboard
Restoran/Kafe → İşletme Dashboard
Editör → Editör Dashboard
Onaycı → Onay Paneli
```

## 5.2 İçerik yayın akışı

```text
İçerik Ekle
   ↓
Taslak Kaydet
   ↓
Onaya Gönder
   ↓
Onay Paneli
   ↓
Onayla / Reddet
   ↓
Yayınla
   ↓
Mobil Uygulamada Görünür
```

---

# 6. MVP İçin Öncelikli Ekranlar

## 6.1 Mobil MVP ekranları

1. Splash
2. Onboarding
3. Şehir Seçimi
4. Ana Sayfa
5. Keşfet / Kategoriler
6. Mekan Listesi
7. Mekan Detay
8. Etkinlik Listesi
9. Etkinlik Detay
10. Harita
11. Favoriler
12. Arama / Filtreleme
13. Durum ekranları

## 6.2 Panel MVP ekranları

1. Login
2. Super Admin Dashboard
3. Belediye / Kurum Dashboard
4. İşletme Dashboard
5. Mekan Ekle
6. Etkinlik Ekle
7. İçerik Listesi
8. Onay Paneli
9. Kullanıcılar ve Roller
10. Raporlar başlangıç ekranı

---

# 7. Sonuç

GezioGo’nun ekran yapısı iki ürün yüzeyiyle düşünülmelidir:

- **Mobil uygulama:** şehir keşfi, rota, harita, etkinlik, favori.
- **Panel:** içerik girişi, rol bazlı yönetim, onay ve raporlama.

Ana ilke:

> Her ekran, kullanıcının rolüne ve amacına hizmet etmeli; gereksiz ekranlar erken sürüme alınmamalıdır.

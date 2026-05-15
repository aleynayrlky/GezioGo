# GezioGo – Özellik Önceliklendirme

> Hafta 2 / Gün 5 çıktısı  
> Dosya amacı: GezioGo özelliklerini öncelik sırasına koymak; MVP, MVP sonrası ve ileri sürüm ayrımını netleştirmek.

---

## 1. Dokümanın Amacı

GezioGo büyük ve kapsamlı bir projedir. Bu nedenle tüm özellikleri aynı anda geliştirmek doğru değildir.

Bu dosyanın amacı:

- Hangi özelliklerin ilk sürüm için zorunlu olduğunu belirlemek
- Hangi özelliklerin MVP sonrasına bırakılacağını netleştirmek
- Panel ve mobil tarafı ayrı ayrı önceliklendirmek
- Projenin gereksiz büyüyüp dağılmasını engellemek

Ana ilke:

> Önce küçük ama çalışan ürün. Sonra kontrollü büyüme.

---

## 2. Öncelik Seviyeleri

| Seviye | Anlamı |
|---|---|
| P0 | Olmazsa MVP çalışmaz |
| P1 | MVP için çok önemli |
| P2 | MVP sonrası kısa vadede eklenir |
| P3 | Orta vadeli özellik |
| P4 | Uzun vadeli / ileri sürüm |

---

# 3. Mobil Uygulama Özellikleri

## 3.1 P0 – MVP için zorunlu özellikler

Bu özellikler olmadan GezioGo 1.0 temel kullanıcı deneyimi eksik kalır.

| Özellik | Açıklama | Sürüm |
|---|---|---|
| Splash Screen | Marka açılış ekranı | 1.0 |
| Onboarding | Uygulamanın ne yaptığını anlatır | 1.0 |
| Şehir Seçimi | İlk şehir olarak Samsun seçimi | 1.0 |
| Ana Sayfa | Kullanıcının ana keşif alanı | 1.0 |
| Kategori Listesi | Gezilecek yerler, müzeler, doğa, yeme-içme, etkinlik | 1.0 |
| Mekan Listesi | Kategoriye göre mekanları listeler | 1.0 |
| Mekan Detay | Açıklama, görsel, adres, saat, ücret bilgisi | 1.0 |
| Etkinlik Listesi | Şehirdeki etkinlikleri listeler | 1.0 |
| Etkinlik Detay | Tarih, saat, yer, açıklama, bilet linki | 1.0 |
| Harita | Mekanları haritada gösterir | 1.0 |
| Favorilere Ekleme | Kullanıcı mekan/etkinlik kaydeder | 1.0 |
| Arama | Mekan/etkinlik araması | 1.0 |
| Basit Filtreleme | Ücretsiz, çocukla uygun, kapalı alan vb. | 1.0 |
| Boş/Yükleniyor/Hata Durumları | Profesyonel kullanıcı deneyimi | 1.0 |

---

## 3.2 P1 – MVP için çok önemli özellikler

| Özellik | Açıklama | Sürüm |
|---|---|---|
| Konum İzni Yönetimi | Yakındaki yerler için gerekli | 1.0 |
| Apple Maps Yol Tarifi | Kullanıcıyı haritaya yönlendirir | 1.0 |
| Bilet Linkine Yönlendirme | Uygulama içi satış yok, dış link var | 1.0 |
| Kaynak URL Gösterimi | Güvenilirlik sağlar | 1.0 |
| Erişilebilirlik Bilgisi Alanı | İleri erişilebilirlik için temel | 1.0 |
| Temel Ayarlar | Dil/izin gibi basit ayarlar | 1.0 |

---

## 3.3 P2 – MVP sonrası kısa vadeli özellikler

| Özellik | Açıklama | Sürüm |
|---|---|---|
| AI Rota Formu | Kişisel gezi planı için tercih toplar | 1.1 |
| AI Rota Sonucu | Yapay zekâ rota önerisi gösterir | 1.1 |
| Rota Kaydetme | Kullanıcı rotasını saklar | 1.1 / 1.2 |
| Kullanıcı Hesabı | Favori ve rota verisini hesaba bağlar | 1.2 |
| Bildirimler | Etkinlik, rota ve öneri bildirimi | 1.2+ |

---

## 3.4 P3 – Orta vadeli mobil özellikler

| Özellik | Açıklama | Sürüm |
|---|---|---|
| Sesli Rehber | Mekan açıklamasını sesli okur | 1.5 |
| Erişilebilirlik Geliştirmeleri | VoiceOver, büyük yazı, erişim etiketleri | 1.5 |
| Gelişmiş Filtreleme | Bütçe, erişilebilirlik, öğrenci, aile vb. | 1.5+ |
| Kaydedilen Rotalar | Kullanıcı geçmiş rotalarını görür | 1.2+ |

---

## 3.5 P4 – Uzun vadeli mobil özellikler

| Özellik | Açıklama | Sürüm |
|---|---|---|
| Fotoğraftan Mekan Tanıma | Kamera ile tarihi eser/mekan tanıma | 2.5 |
| Çoklu Şehir Desteği | Samsun dışına genişleme | 3.0 |
| Çoklu Dil Desteği | Yabancı turistler için | 5.0 |
| AR Rehber | Gelişmiş turistik deneyim | 5.0+ |
| Offline Rota | İnternetsiz gezi desteği | 4.0+ |

---

# 4. Panel / Admin Özellikleri

## 4.1 P0 – Panel için temel zorunlu özellikler

| Özellik | Açıklama | Sürüm |
|---|---|---|
| Panel Login | Kullanıcı giriş ekranı | 2.0 |
| Rol Bazlı Yetkilendirme | Herkes kendi yetkisini görür | 2.0 |
| Super Admin Dashboard | Tüm sistemi yönetir | 2.0 |
| Kurum / Belediye Dashboard | Kendi şehir/kurum verisini görür | 2.0 |
| Mekan Ekleme | İçerik yönetiminin temeli | 2.0 |
| Etkinlik Ekleme | Etkinlik yönetiminin temeli | 2.0 |
| İçerik Listesi | Eklenen içerikleri gösterir | 2.0 |
| Onaya Gönderme | İçerik yayın sürecini başlatır | 2.0 |

---

## 4.2 P1 – Panel için çok önemli özellikler

| Özellik | Açıklama | Sürüm |
|---|---|---|
| İçerik Onay Paneli | Onayla/reddet sistemi | 2.1 |
| Düzeltme Notu | Reddedilen içeriğe açıklama | 2.1 |
| Görsel Yükleme | Mekan/etkinlik görsel yönetimi | 2.0 |
| Kurum / İş Ortağı Yönetimi | Belediye, il müdürlüğü, işletme hesapları | 2.0 |
| İşletme Paneli | Restoran/kafe kendi verisini yönetir | 2.0+ |
| Etkinlik Organizatörü Paneli | Organizatör kendi etkinliğini yönetir | 2.0+ |

---

## 4.3 P2 – Panel sonrası geliştirmeler

| Özellik | Açıklama | Sürüm |
|---|---|---|
| Raporlama | Şehir, kurum, işletme raporları | 2.1+ |
| Kullanıcı Geri Bildirimleri | Hatalı bilgi bildirimi | 2.1+ |
| İçerik Geçmişi | Değişiklik geçmişi | 2.1 |
| Son Doğrulama Tarihi | İçeriğin güncelliğini takip eder | 2.1 |
| Kampanya Yönetimi | İşletme ve kurum kampanyaları | 4.0 |

---

## 4.4 P3 / P4 – Uzun vadeli panel özellikleri

| Özellik | Açıklama | Sürüm |
|---|---|---|
| Bakanlık Üst Paneli | Genel raporlar ve strateji görünümü | 3.0+ |
| Çoklu Şehir Yönetimi | Şehir bazlı yetki sistemi | 3.0 |
| SaaS Abonelik Yönetimi | Kurum ve işletme paketleri | 3.0+ |
| Gelişmiş Analitik | Turizm verisi ve raporlar | 4.0 |
| Otel / Acente Paneli | Turizm iş ortakları için | 4.0 |

---

# 5. Özelliklerin Sürüm Bazlı Dağılımı

| Sürüm | Ana Odak | Özellikler |
|---|---|---|
| 0.5 | Statik demo | Ekran tasarımları, mock veri |
| 1.0 | Samsun MVP | Ana sayfa, liste, detay, harita, favori, etkinlik |
| 1.1 | AI rota | AI formu, rota sonucu, rota kaydetme |
| 1.2 | Kullanıcı hesabı | Auth, profil, kaydedilen rotalar |
| 1.5 | Sesli rehber | AVSpeechSynthesizer, erişilebilirlik |
| 2.0 | Panel | Super Admin, kurum, işletme, mekan/etkinlik ekleme |
| 2.1 | Onay sistemi | Onayla, reddet, içerik geçmişi |
| 2.5 | Görsel AI | Fotoğraftan mekan tanıma |
| 3.0 | Çoklu şehir | Şehir bazlı yönetim, SaaS başlangıcı |
| 4.0 | Gelir modeli | İşletme paneli, kampanya, bilet yönlendirme |
| 5.0 | Uluslararasılaşma | Çoklu dil, yabancı turist akışları |

---

# 6. İlk 3 Ay İçin Odak

İlk 3 ayda sadece şu alanlara odaklanılmalıdır:

```text
1. Statik SwiftUI demo
2. Samsun için temel içerik
3. Ana ekranlar
4. Mekan ve etkinlik listeleri
5. Harita
6. Favoriler
7. Basit arama / filtreleme
```

AI rota çok önemli olduğu için 1.0 tamamlandıktan hemen sonra 1.1 olarak ele alınmalıdır.

---

# 7. Yapılmaması Gerekenler

İlk aşamada aşağıdakiler yapılmamalıdır:

- 81 ili aynı anda eklemek
- Tam gelişmiş belediye paneline erken başlamak
- Uygulama içi bilet satışına girmek
- Premium üyelik kurgusuna erken başlamak
- Fotoğraftan tanımayı MVP’ye almak
- Çoklu dili ilk sürüme sıkıştırmak
- Sosyal medya benzeri yorum/puan sistemi kurmak

---

# 8. Sonuç

GezioGo’nun başarı şansı, özellikleri doğru sıraya koymaya bağlıdır.

Ana odak:

> Önce Samsun için çalışan güçlü bir mobil MVP; sonra AI rota; sonra rol bazlı panel ve çoklu şehir yapısı.

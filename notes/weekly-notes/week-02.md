# GezioGo – Hafta 02 Özeti

> Hafta 2 çıktısı  
> Ana konu: Kullanıcı personları, kullanıcı senaryoları, mobil akışlar, panel akışları, özellik önceliklendirme ve ekran/navigasyon planı.

---

## 1. Haftanın Ana Amacı

2. haftanın amacı, GezioGo projesinde kullanıcıların ve sistem paydaşlarının nasıl davranacağını netleştirmektir.

1. haftada proje kimliği, vizyon, MVP sınırı ve yol haritası konuşuldu. 2. haftada ise şu sorulara cevap verildi:

- GezioGo’da hangi kullanıcı tipleri var?
- Mobil kullanıcılar uygulamada hangi akışlardan geçecek?
- Panel kullanıcıları hangi yetkilere sahip olacak?
- Her kullanıcı aynı paneli mi görecek?
- Hangi özellikler MVP’ye, hangileri sonraya kalacak?
- Hangi ekranlar mobil uygulamada ve panelde olmalı?

---

## 2. Bu Hafta Hazırlanan Dosyalar

```text
docs/product/user-personas.md
docs/product/user-scenarios.md
docs/product/mobile-user-flows.md
docs/panel/admin-panel-user-flows.md
docs/product/feature-prioritization.md
docs/product/screen-list-and-navigation.md
docs/weekly/week-02-summary.md
```

---

## 3. Bu Haftanın En Önemli Kararı

GezioGo iki taraflı bir platform olarak düşünülmelidir:

```text
1. Mobil Kullanıcı Tarafı
2. Panel / Admin / İş Ortağı Tarafı
```

Mobil tarafta kullanıcı şehir keşfeder, etkinlik bulur, haritada yerleri görür, favori ekler ve AI rota oluşturur.

Panel tarafında ise farklı rol ve yetkilerle kurumlar, işletmeler, editörler ve onay yetkilileri içerik yönetir.

---

## 4. Netleşen Mobil Kullanıcı Tipleri

- Yerli turist
- Yabancı turist
- Şehirde yaşayan kullanıcı
- Öğrenci
- Çocuklu aile
- Yaşlı kullanıcı
- Engelli birey

MVP için öncelikli mobil kullanıcılar:

1. Yerli turist
2. Şehirde yaşayan kullanıcı
3. Öğrenci
4. Çocuklu aile

---

## 5. Netleşen Panel Kullanıcı Tipleri

- GezioGo Super Admin / Kurucu
- GezioGo içerik editörü
- Belediye yetkilisi
- İl Kültür ve Turizm Müdürlüğü yetkilisi
- Bakanlık temsilcisi
- Restoran / kafe / işletme sahibi
- Otel / acente yetkilisi
- Etkinlik organizatörü
- İçerik onay yetkilisi

Panel için ana karar:

> Her kullanıcı yalnızca kendi rolüne, kurumuna, şehrine veya işletmesine ait alanları görmelidir.

---

## 6. Netleşen Mobil Akışlar

### Ana giriş akışı

```text
Splash → Onboarding → Şehir Seçimi → Ana Sayfa
```

### Keşif akışı

```text
Ana Sayfa → Keşfet → Kategori → Mekan Listesi → Mekan Detay → Harita
```

### Etkinlik akışı

```text
Ana Sayfa → Etkinlikler → Etkinlik Detay → Bilet Linki
```

### AI rota akışı

```text
Ana Sayfa → Planla → AI Rota Formu → AI Rota Sonucu → Rotayı Kaydet
```

### Favori akışı

```text
Mekan / Etkinlik / Rota → Favorilere Ekle → Favorilerim
```

---

## 7. Netleşen Panel Akışları

### Rol bazlı giriş akışı

```text
Login → Rol Kontrolü → Kullanıcı Tipine Uygun Dashboard
```

### İçerik yayın akışı

```text
İçerik Girişi → Taslak → Onaya Gönder → İnceleme → Onay / Red → Yayınlama
```

### Super Admin akışı

```text
Dashboard → Kullanıcılar ve Roller → Yeni Kullanıcı → Rol Ver → Yetki Kapsamı Belirle
```

### Belediye / kurum akışı

```text
Dashboard → Mekan / Etkinlik Ekle → Onaya Gönder → Yayın Durumu Takibi
```

### İşletme akışı

```text
İşletme Paneli → İşletme Bilgisi / Fotoğraf / Kampanya → Onaya Gönder
```

---

## 8. MVP İçin Öncelikli Özellikler

### Mobil MVP

- Splash
- Onboarding
- Şehir seçimi
- Ana sayfa
- Kategori listesi
- Mekan listesi
- Mekan detay
- Etkinlik listesi
- Etkinlik detay
- Harita
- Favoriler
- Arama
- Basit filtreleme
- Boş/yükleniyor/hata durumları

### Panel MVP

- Login
- Rol bazlı menü görünümü
- Super Admin dashboard
- Belediye / kurum dashboard
- İşletme dashboard başlangıcı
- Mekan ekleme formu
- Etkinlik ekleme formu
- İçerik onay listesi
- Onayla / reddet işlemi

---

## 9. Sonraya Bırakılan Özellikler

- Gelişmiş AI rota
- Kullanıcı hesabı detayları
- Sesli rehber
- Fotoğraftan mekan tanıma
- Çoklu şehir
- Çoklu dil
- Uygulama içi bilet satışı
- Gelişmiş analitik
- SaaS abonelik yönetimi

---

## 10. 3. Haftaya Hazırlık

3. haftanın konusu şu olmalıdır:

> Veri modeli + içerik şablonları + Samsun için ilk veri yapısı

3. haftada hazırlanacak olası dosyalar:

```text
docs/data/city-model.md
docs/data/place-model.md
docs/data/event-model.md
docs/data/user-model.md
docs/data/route-model.md
docs/data/content-entry-rules.md
data/templates/place-template.json
data/templates/event-template.json
```

---

## 11. Kısa Sonuç

2. haftada GezioGo’nun kullanıcı davranışı netleşti.

Ana karar:

> GezioGo yalnızca bir mobil uygulama değil; mobil kullanıcı deneyimi ile rol bazlı panel yönetimini birlikte taşıyan çok paydaşlı şehir keşif platformudur.

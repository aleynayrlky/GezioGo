# GezioGo – Mobil Kullanıcı Akışları

> Hafta 2 / Gün 3 çıktısı  
> Dosya amacı: Mobil uygulama içinde kullanıcının hangi ekrandan hangi ekrana gideceğini netleştirmek.

---

## 1. Dokümanın Amacı

Bu dosya, GezioGo mobil uygulamasının temel kullanıcı akışlarını tanımlar.

Akışlar, tasarım ve geliştirme sürecinde şu sorulara cevap verir:

- Kullanıcı uygulamayı açınca nereye gider?
- Ana sayfadan hangi sayfalara ulaşır?
- Mekan detayından hangi aksiyonları alabilir?
- AI rota nasıl başlar ve nasıl tamamlanır?
- Favoriler, harita ve etkinlik akışları nasıl çalışır?

---

## 2. Ana Giriş Akışı

```text
Uygulama Açılışı
   ↓
Splash Screen
   ↓
Onboarding
   ↓
Konum İzni / Bildirim İzni
   ↓
Şehir Seçimi
   ↓
Ana Sayfa
```

### Açıklama

Kullanıcı ilk kez uygulamayı açtığında marka ekranı, kısa tanıtım, izinler ve şehir seçimi ile karşılaşır. Sonraki girişlerde doğrudan ana sayfaya yönlendirilebilir.

### Alternatif durumlar

- Kullanıcı konum izni vermezse: şehir seçimi manuel yapılır.
- Kullanıcı onboarding’i geçerse: şehir seçimine gider.
- Kullanıcı daha önce şehir seçtiyse: doğrudan ana sayfaya gider.

---

## 3. Şehir Keşfetme Akışı

```text
Ana Sayfa
   ↓
Keşfet / Kategoriler
   ↓
Kategori Seçimi
   ↓
Mekan Listesi
   ↓
Mekan Detay
   ↓
Haritada Göster
   ↓
Yol Tarifi Al
```

### Kullanıcı amacı

Şehirde gezilecek yerleri keşfetmek.

### Ana ekranlar

- Ana Sayfa
- Keşfet / Kategoriler
- Mekan Listesi
- Mekan Detay
- Harita

### Ana aksiyonlar

- Kategori seçme
- Filtreleme
- Mekan detayı görüntüleme
- Haritada görüntüleme
- Yol tarifi alma
- Favorilere ekleme

---

## 4. Etkinlik Bulma Akışı

```text
Ana Sayfa
   ↓
Etkinlikler
   ↓
Etkinlik Listesi
   ↓
Etkinlik Detay
   ↓
Bilet Linkine Git
```

### Kullanıcı amacı

Şehirdeki güncel etkinlikleri görmek ve bilet/kayıt bilgisine ulaşmak.

### Ana aksiyonlar

- Bugün / Bu Hafta filtresi
- Ücretsiz etkinlik filtresi
- Kategori seçimi
- Etkinlik detayı görüntüleme
- Bilet linkine gitme
- Favorilere ekleme

### Not

MVP’de uygulama içi bilet satışı yapılmaz. Kullanıcı resmi veya güvenilir bilet linkine yönlendirilir.

---

## 5. AI Rota Oluşturma Akışı

```text
Ana Sayfa
   ↓
Planla
   ↓
AI Rota Formu
   ↓
Tercihleri Gir
   ↓
Rota Oluştur
   ↓
AI Rota Sonucu
   ↓
Rotayı Kaydet / Paylaş / Haritada Gör
```

### Kullanıcı amacı

Kendi zamanına, bütçesine, ilgi alanına ve ulaşım tercihine göre kişisel gezi planı almak.

### Form alanları

- Şehir
- Tarih
- Süre
- Bütçe
- İlgi alanları
- Tempo
- Ulaşım tercihi
- Kişi sayısı
- Özel ihtiyaçlar

### Sonuç ekranında gösterilecekler

- Rota başlığı
- Gün planı
- Sabah / öğleden sonra / akşam ayrımı
- Harita üzerinde rota
- Tahmini süre
- Tahmini bütçe
- Yürüme mesafesi
- Durak listesi

### Alternatif durumlar

- AI cevap veremezse: tekrar dene ekranı.
- Eksik bilgi varsa: form alanı uyarısı.
- Rota kaydedilirse: kayıtlı rotalara eklenir.

---

## 6. Favorilere Ekleme Akışı

```text
Mekan Detay / Etkinlik Detay / Rota Sonucu
   ↓
Favori İkonuna Bas
   ↓
Favorilere Eklendi Mesajı
   ↓
Favorilerim
```

### Kullanıcı amacı

Beğendiği yerleri, etkinlikleri veya rotaları daha sonra kolay bulmak.

### Favori türleri

- Mekan favorisi
- Etkinlik favorisi
- Rota favorisi

### Boş durum

Favoriler boşsa kullanıcıya şu mesaj gösterilir:

> Henüz favorin yok. Beğendiğin mekanları, etkinlikleri veya rotaları favorilere ekleyerek burada görebilirsin.

---

## 7. Haritada Keşfetme Akışı

```text
Ana Sayfa
   ↓
Harita
   ↓
Konum İzni Kontrolü
   ↓
Yakındaki Pinler
   ↓
Pin Seçimi
   ↓
Alt Bilgi Kartı
   ↓
Mekan Detay / Yol Tarifi
```

### Kullanıcı amacı

Konumuna yakın yerleri harita üzerinden keşfetmek.

### Alternatif durumlar

- Konum izni yoksa: izin ekranı gösterilir.
- İnternet yoksa: bağlantı hatası gösterilir.
- Yakında mekan yoksa: boş durum gösterilir.

---

## 8. Arama ve Filtreleme Akışı

```text
Ana Sayfa / Keşfet
   ↓
Arama Çubuğu
   ↓
Arama Sonuçları
   ↓
Filtrele
   ↓
Mekan / Etkinlik Detay
```

### Arama kapsamı

- Mekan adı
- Etkinlik adı
- Kategori adı
- İlçe adı
- Etiketler

### Filtreler

- Ücretsiz / ücretli
- Kapalı alan / açık alan
- Çocukla uygun
- Öğrenci dostu
- Erişilebilir
- Yakınımdaki

---

## 9. Profil ve Tercihler Akışı

```text
Ana Sayfa
   ↓
Profil
   ↓
Tercihler
   ↓
Bütçe / İlgi Alanı / Ulaşım / Dil / Bildirimler
   ↓
Kaydet
```

### Kullanıcı amacı

Uygulamanın önerilerini kişiselleştirmek.

### Profilde olabilecek alanlar

- Kullanıcı bilgileri
- Favoriler
- Kaydedilen rotalar
- İlgi alanları
- Bütçe tercihi
- Ulaşım tercihi
- Bildirim ayarları
- Dil tercihi

---

## 10. Mobil Akış Öncelikleri

| Akış | MVP | Not |
|---|---|---|
| Giriş ve şehir seçimi | Evet | İlk kurulum için gerekli |
| Şehir keşfetme | Evet | 1.0’ın ana akışı |
| Mekan detayı | Evet | Temel deneyim |
| Harita | Evet | MapKit ile yapılacak |
| Favoriler | Evet | Local başlayabilir |
| Etkinlik bulma | Evet | Bilet linki yönlendirme |
| AI rota | 1.1 | MVP sonrası ana fark |
| Profil / hesap | 1.2 | Kullanıcı bazlı veri için |
| Sesli rehber | 1.5 | Mekan detayına eklenir |

---

## 11. Sonuç

Mobil kullanıcı akışlarının ana hedefi şudur:

> Kullanıcının şehir keşif sürecini sade, hızlı, kişisel ve yönlendirilebilir hale getirmek.

# Gezio – Hafta 01 / Gün 04: Versiyon Planı

> Dosya amacı: Gezio projesinin tüm özelliklerini tek seferde geliştirmek yerine, kontrollü ve sürdürülebilir versiyonlara bölmek.  
> Hafta: 1  
> Gün: 4  
> Çıktı dosyası önerisi: `docs/product/version-plan.md`

---

## 1. Günün Amacı

Bugünün amacı, Gezio’nun gelişim sürecini net versiyonlara ayırmaktır.

Gezio büyük ve kapsamlı bir proje olduğu için bütün özellikleri aynı anda geliştirmek doğru değildir. Bu dosya, hangi özelliğin hangi sürümde geliştirileceğini belirler.

Temel yaklaşım:

> Önce küçük ama çalışan ürün. Sonra düzenli büyüme.

Bu sayede proje kontrolsüz şekilde büyümez, motivasyon düşmez ve her aşamada elle tutulur bir çıktı ortaya çıkar.

---

## 2. Versiyon Planı Neden Önemli?

Versiyon planı şu sorulara cevap verir:

- İlk sürümde ne olacak?
- İlk sürümde ne olmayacak?
- Yapay zekâ ne zaman eklenecek?
- Sesli rehber ne zaman eklenecek?
- Belediye paneli ne zaman geliştirilecek?
- Fotoğraftan tarihi eser tanıma hangi aşamada yapılacak?
- Çoklu şehir desteğine ne zaman geçilecek?
- Gelir modeli ne zaman düşünülmeye başlanacak?

Bu ayrım yapılmazsa proje çok büyür ve nereden başlanacağı karışır.

---

## 3. Ana Geliştirme Mantığı

Gezio şu sırayla büyümelidir:

```text
0.1 Dokümantasyon
0.5 Statik Demo
1.0 Temel MVP
1.1 AI Rota
1.2 Kullanıcı Hesabı
1.5 Sesli Rehber
2.0 Belediye/Kurum Paneli
2.1 İçerik Onay Sistemi
2.5 Fotoğraftan Mekân Tanıma
3.0 Çoklu Şehir ve SaaS
3.5 Gelişmiş Kişiselleştirme
4.0 Gelir Modeli ve İşletme Paneli
5.0 Uluslararasılaşma
```

Bu sıra kesin ve değişmez değildir. Ancak başlangıç için en sağlıklı ve yönetilebilir sıradır.

---

# 4. Gezio 0.1 – Fikir, Dokümantasyon ve Teknik Hazırlık

## Amaç

Projeyi kod yazmaya başlamadan önce netleştirmek.

Bu sürümde uygulama geliştirilmez. Ana amaç proje fikrini, hedefleri, kullanıcı problemlerini, MVP kapsamını ve teknik yönü yazılı hale getirmektir.

## Yapılacaklar

- Proje genel bakış dosyası hazırlanır.
- Vizyon dosyası hazırlanır.
- MVP kapsamı yazılır.
- Versiyon planı oluşturulur.
- Hedef kitle belirlenir.
- Kullanıcı problemleri listelenir.
- İlk şehir kararı netleştirilir.
- İlk platform kararı netleştirilir.
- Dokümantasyon klasör yapısı planlanır.
- GitHub reposu için hazırlık yapılır.

## Bu Sürümde Olmayacaklar

- SwiftUI geliştirme
- Firebase kurulumu
- AI entegrasyonu
- Harita entegrasyonu
- Gerçek veri toplama
- Belediye paneli
- App Store süreci

## Çıktı

- Projenin yazılı ve düzenli temeli.
- Geliştirmeye başlamadan önce net ürün yönü.

## Başarı Kriteri

Aşağıdaki sorulara net cevap verilebiliyorsa 0.1 başarılıdır:

- Gezio nedir?
- Kime hitap eder?
- Hangi problemi çözer?
- İlk sürümde ne olacak?
- İlk şehir hangisi?
- İlk platform hangisi?
- Proje hangi sırayla büyüyecek?

---

# 5. Gezio 0.5 – Statik Demo / Tasarım Prototipi

## Amaç

Uygulamanın nasıl görüneceğini ve temel akışının nasıl çalışacağını göstermek.

Bu sürümde amaç gerçek backend veya AI yapmak değil, uygulamanın temel ekranlarını mock veriyle gezilebilir hale getirmektir.

## Olacak Özellikler

- SwiftUI proje kurulumu
- Ana sayfa taslağı
- Şehir seçimi taslağı
- Kategori ekranları
- Mekân liste ekranı
- Mekân detay ekranı
- Etkinlik liste ekranı
- Etkinlik detay ekranı
- Harita önizleme
- Mock JSON veri kullanımı
- Basit favori butonu
- Temel tasarım sistemi başlangıcı

## Bu Sürümde Olmayacaklar

- Gerçek Firebase bağlantısı
- Kullanıcı hesabı
- AI rota oluşturma
- Belediye paneli
- Fotoğraftan tanıma
- Sesli rehber
- Canlı etkinlik verisi
- Uygulama içi bilet satışı

## Çıktı

- Sunumda gösterilebilecek, ekranları gezilebilen ilk SwiftUI demo.

## Başarı Kriteri

Kullanıcı uygulamayı açıp şu ekranları gezebiliyorsa 0.5 başarılıdır:

- Ana sayfa
- Kategori listesi
- Mekân detayı
- Etkinlik detayı
- Harita önizleme

---

# 6. Gezio 1.0 – Temel MVP

## Amaç

Samsun için çalışan ilk kullanılabilir ürünü geliştirmek.

Bu sürüm, Gezio’nun temel kullanıcı deneyimini test etmek için hazırlanır. Amaç mükemmel ürün değil, küçük ama çalışan bir ürün çıkarmaktır.

## İlk Şehir

**Samsun**

## İlk Platform

**iOS**

## Olacak Özellikler

- Samsun şehir ana sayfası
- Gezilecek yerler listesi
- Müzeler listesi
- Doğa ve yeşil alanlar listesi
- Yeme-içme önerileri
- Etkinlikler listesi
- Mekân detay sayfası
- Etkinlik detay sayfası
- MapKit ile haritada gösterme
- CoreLocation ile kullanıcı konumu
- Favorilere ekleme
- Basit arama
- Basit filtreleme
- Bilet linkine yönlendirme
- Yerel JSON veya Firestore üzerinden veri okuma
- Loading, empty state ve error state ekranları

## Bu Sürümde Olmayacaklar

- Belediye paneli
- İşletme paneli
- Kullanıcı yorumları
- Uygulama içi bilet satışı
- Fotoğraftan tarihi eser tanıma
- Sesli rehber
- Çoklu şehir yönetimi
- Gelişmiş öneri algoritması
- Premium üyelik
- Çoklu dil desteği

## AI Durumu

AI rota oluşturma Gezio’nun en önemli özelliklerinden biridir. Ancak teknik karmaşıklığı azaltmak için ana AI rota özelliği 1.1 sürümüne bırakılmalıdır.

1.0 içinde sadece şu yapılabilir:

- AI rota ekranının tasarım taslağı
- AI rota butonu
- “Yakında” veya “1.1 sürümünde” notu

## Çıktı

- Samsun için çalışan temel mobil uygulama.

## Başarı Kriteri

Aşağıdaki soruya “evet” denebiliyorsa Gezio 1.0 başarılıdır:

> Kullanıcı Samsun’u uygulama üzerinden keşfedebiliyor, mekân detayına girebiliyor, haritada görebiliyor, favorilere ekleyebiliyor ve etkinlik/bilet bilgilerine ulaşabiliyor mu?

---

# 7. Gezio 1.1 – AI Rota Oluşturma

## Amaç

Gezio’nun ana farkını oluşturan ilk gerçek yapay zekâ özelliğini eklemek.

Bu sürümde kullanıcı kendi zamanına, bütçesine, ilgi alanına ve ulaşım tercihine göre kişisel rota alabilmelidir.

## Olacak Özellikler

- “Bana Gezi Planı Oluştur” ekranı
- Kullanıcı tercih formu
- Gezi süresi seçimi
- Bütçe seçimi
- İlgi alanı seçimi
- Ulaşım tercihi
- Kimlerle gezdiği bilgisi
- Kapalı/açık alan tercihi
- Yürüme toleransı
- Erişilebilirlik ihtiyacı
- AI API entegrasyonu
- Backend üzerinden AI çağrısı
- AI yanıtını JSON formatında alma
- Sabah / öğle / öğleden sonra / akşam planı
- Alternatif plan
- Yağmurlu hava planı
- Düşük bütçe / ücretsiz rota önerisi
- Rota sonucunu kaydetme

## Bu Sürümde Olmayacaklar

- Serbest sohbet asistanı
- Kullanıcının her sorusuna açık uçlu cevap veren chatbot
- Fotoğraftan yer tanıma
- Gelişmiş öneri algoritması
- Çoklu şehir AI planlama

## AI Güvenlik İlkesi

AI sadece doğrulanmış uygulama verilerini kullanarak öneri üretmelidir.

AI’nın dikkat etmesi gerekenler:

- Olmayan yer önermemeli.
- Açılış saatlerini kesin bilgi gibi uydurmamalı.
- Bilet fiyatı gibi değişken bilgileri kesin ifade etmemeli.
- Kritik bilgilerde resmi kaynak kontrolü önerilmeli.
- Uygulama verisindeki yerleri önceliklendirmeli.

## Çıktı

- Kullanıcının kişisel gezi planı alabildiği ilk AI deneyimi.

## Başarı Kriteri

Kullanıcı tercihlerini girip mantıklı, okunabilir ve Samsun verilerine dayalı gezi planı alabiliyorsa Gezio 1.1 başarılıdır.

---

# 8. Gezio 1.2 – Kullanıcı Hesabı ve Kişiselleştirme

## Amaç

Kullanıcının uygulamaya geri dönmesini sağlayacak kişisel alanı oluşturmak.

## Olacak Özellikler

- Firebase Authentication
- E-posta ile kayıt
- E-posta ile giriş
- Apple ile giriş opsiyonu
- Profil ekranı
- Favori mekânlar
- Kaydedilen rotalar
- İlgi alanları
- Dil tercihi
- Bütçe tercihi
- Ulaşım tercihi
- Bildirim izinleri

## Bu Sürümde Olmayacaklar

- Sosyal medya benzeri profil
- Kullanıcı takip sistemi
- Yorum ve puanlama
- Premium üyelik
- Rozet / oyunlaştırma

## Çıktı

- Kullanıcı bazlı veri saklayan uygulama.

## Başarı Kriteri

Kullanıcı hesabıyla giriş yapıp favorilerini ve rotalarını kendi hesabında saklayabiliyorsa Gezio 1.2 başarılıdır.

---

# 9. Gezio 1.5 – Sesli Rehber ve Erişilebilirlik

## Amaç

Gezio’yu daha erişilebilir ve turistik açıdan daha değerli hale getirmek.

Bu sürümde kullanıcı bir mekânın açıklamasını sesli dinleyebilmelidir.

## Olacak Özellikler

- Mekân detayında “Sesli Dinle” butonu
- AVSpeechSynthesizer ile Türkçe sesli okuma
- Ses başlatma
- Ses durdurma
- Ses devam ettirme
- Kısa anlatım / detaylı anlatım seçeneği
- Büyük yazı desteği
- VoiceOver uyumluluğuna dikkat
- Erişilebilirlik etiketleri
- Engelli erişim bilgisi alanı

## Bu Sürümde Olmayacaklar

- Profesyonel stüdyo seslendirmesi
- Çok dilli sesli rehber
- Otomatik konuma göre ses başlatma
- Müze içi adım adım sesli tur

## Çıktı

- Basit ama etkili sesli şehir rehberi deneyimi.

## Başarı Kriteri

Kullanıcı bir mekânın açıklamasını uygulama içinde sesli dinleyebiliyorsa Gezio 1.5 başarılıdır.

---

# 10. Gezio 2.0 – Belediye / Kurum Web Paneli

## Amaç

İçerik yönetimini sürdürülebilir hale getirmek.

Gezio 81 ile yayılacaksa içerikleri tek kişinin yönetmesi mümkün değildir. Bu yüzden belediye, turizm kurumu veya editörlerin içerik girebildiği bir web panel gereklidir.

## Olacak Özellikler

- Web admin panel kurulumu
- Kurum kullanıcısı girişi
- Rol sistemi
- Super Admin
- City Admin
- Editor
- Approver
- Event Manager
- Mekân ekleme
- Mekân düzenleme
- Mekân yayından kaldırma
- Etkinlik ekleme
- Etkinlik düzenleme
- Görsel yükleme
- Bilet linki ekleme
- Duyuru ekleme
- İçerik yayınlama / yayından kaldırma
- Son güncelleme tarihi takibi

## Bu Sürümde Olmayacaklar

- Gelişmiş analitik panel
- Otomatik veri çekme
- İşletme paneli
- Çok gelişmiş tasarım özelleştirme
- Kurum içi detaylı iş akışı sistemi

## Çıktı

- Belediyeye veya kuruma gösterilebilecek yönetilebilir platform.

## Başarı Kriteri

Bir kurum kullanıcısı panelden mekân veya etkinlik eklediğinde bu içerik mobil uygulamada görünebiliyorsa Gezio 2.0 başarılıdır.

---

# 11. Gezio 2.1 – İçerik Onay ve Kalite Sistemi

## Amaç

Kurumsal kullanım için güvenli ve kontrollü içerik yönetimi sağlamak.

## Olacak Özellikler

- Taslak içerik
- Onay bekleyen içerik
- Onayla / reddet sistemi
- İçerik değişiklik geçmişi
- Kaynak URL zorunluluğu
- Son doğrulama tarihi
- Kullanıcı hatalı bilgi bildirimi
- Admin notları
- Geri bildirim paneli

## Bu Sürümde Olmayacaklar

- Tam otomatik doğrulama
- Yapay zekâ ile otomatik içerik onayı
- Resmi kurum API’leriyle tam entegrasyon

## Çıktı

- Kurumlar için daha güvenli içerik yönetim yapısı.

## Başarı Kriteri

İçerikler kontrolsüz şekilde yayına çıkmadan önce onay sürecinden geçiyorsa Gezio 2.1 başarılıdır.

---

# 12. Gezio 2.5 – Fotoğraftan Mekân / Tarihi Eser Tanıma

## Amaç

Kullanıcının kamera ile gördüğü tarihi eser, yapı, müze veya turistik alan hakkında bilgi almasını sağlamak.

Bu özellik çok etkileyici olduğu için sunumlarda güçlü görünür. Ancak teknik olarak ileri seviye olduğu için MVP’ye değil, ilerleyen sürüme alınmalıdır.

## Olacak Özellikler

- Kamera açma
- Galeriden fotoğraf seçme
- Görseli backend’e gönderme
- Görsel AI API kullanımı
- Olası mekân eşleştirme
- Güven skoru gösterme
- Alternatif mekânlar gösterme
- Tanınan mekân detayına yönlendirme
- Tanınan mekân için sesli anlatım başlatma

## Bu Sürümde Olmayacaklar

- Kendi özel görsel modelini eğitme
- Tüm Türkiye’deki eserleri tanıma
- Offline görsel tanıma
- AR rehber
- Müze içi obje tanıma sistemi

## Çıktı

- 5-10 önemli Samsun noktasıyla çalışan etkileyici görsel AI demosu.

## Başarı Kriteri

Kullanıcı fotoğraf çektiğinde sistem olası mekânı tanıyıp ilgili bilgi sayfasına yönlendirebiliyorsa Gezio 2.5 başarılıdır.

---

# 13. Gezio 3.0 – Çoklu Şehir ve SaaS Modeli

## Amaç

Tek şehirli yapıdan çoklu şehir platformuna geçmek.

## Olacak Özellikler

- Çoklu şehir desteği
- Şehir seçimi
- Şehir bazlı veri ayrımı
- Şehir bazlı admin yetkisi
- Şehir bazlı istatistikler
- Belediye abonelik paketleri
- Kurum yönetimi
- Çoklu dil altyapısı başlangıcı

## Bu Sürümde Olmayacaklar

- Tüm 81 ili bir anda eklemek
- Tam ulusal kurum entegrasyonu
- Gelişmiş bilet satış altyapısı
- Tam kapsamlı uluslararasılaşma

## Çıktı

- Samsun dışında en az bir şehir daha eklenebilen platform.

## Başarı Kriteri

Sisteme ikinci şehir eklenebiliyor, bu şehir ayrı verilerle ve ayrı panel yetkileriyle yönetilebiliyorsa Gezio 3.0 başarılıdır.

---

# 14. Gezio 3.5 – Gelişmiş Kişiselleştirme ve Öneri Sistemi

## Amaç

Kullanıcıya daha akıllı ve kişisel öneriler sunmak.

## Olacak Özellikler

- Kullanıcı davranış analizi
- En çok görüntülenen mekânlar
- İlgi alanına göre öneriler
- Benzer kullanıcı önerileri
- Hava durumuna göre öneriler
- Konuma göre yakın öneriler
- Akıllı bildirimler
- Haftalık gezi önerileri

## Bu Sürümde Olmayacaklar

- Kullanıcı mahremiyetini riske atacak takip sistemi
- Reklam odaklı manipülatif öneriler
- Tam otomatik kişisel profil çıkarımı
- Karmaşık makine öğrenmesi modeli eğitimi

## Çıktı

- Daha kişisel ve geri dönüş oranı yüksek kullanıcı deneyimi.

## Başarı Kriteri

Uygulama tüm kullanıcılara aynı önerileri vermek yerine kişiye göre öneriler sunmaya başladıysa Gezio 3.5 başarılıdır.

---

# 15. Gezio 4.0 – Gelir Modeli, Bilet ve İşletme Paneli

## Amaç

Projeyi ticari olarak daha güçlü hale getirmek.

## Olacak Özellikler

- Bilet platformlarına gelişmiş yönlendirme
- Komisyon modeli altyapısı
- Yerel işletme paneli
- Sponsorlu ama açıkça etiketli içerikler
- Premium kullanıcı özellikleri
- PDF gezi planı oluşturma
- Çevrimdışı rota
- Reklamsız kullanım
- Otel / turizm acentesi paketleri

## Bu Sürümde Olmayacaklar

- İlk günden zorunlu ücretli kullanım
- Kullanıcı deneyimini bozacak yoğun reklam
- Güvenilir olmayan bilet sağlayıcılarıyla entegrasyon
- Denetlenmeyen sponsorlu içerik

## Çıktı

- Gelir modeli oluşturulmaya başlanmış ürün.

## Başarı Kriteri

Gezio sadece kullanılabilir değil, gelir üretmeye hazır bir yapıya dönüşüyorsa 4.0 başarılıdır.

---

# 16. Gezio 5.0 – Uluslararasılaşma ve Gelişmiş Turizm Platformu

## Amaç

Gezio’yu Türkiye içi şehir rehberinden yabancı turistlere ve daha büyük pazara hitap eden platforma dönüştürmek.

## Olacak Özellikler

- İngilizce arayüz
- Arapça, Almanca, Rusça dil seçenekleri
- Çok dilli sesli rehber
- Uluslararası turist akışları
- Şehirler arası rota
- AR rehber denemeleri
- Turizm raporları
- Bakanlık / ülke çapı iş birlikleri

## Bu Sürümde Olmayacaklar

- İlk aşamada bütün ülkeleri destekleme
- Kontrolsüz global büyüme
- Tüm dillerde eksiksiz içerik
- Yetersiz doğrulanmış veriyle uluslararası lansman

## Çıktı

- Büyük ölçekli dijital turizm platformu.

## Başarı Kriteri

Gezio yabancı turistler için de anlamlı ve kullanılabilir hale gelirse 5.0 başarılıdır.

---

## 17. Öncelik Tablosu

| Sürüm | Öncelik | Neden |
|---|---|---|
| 0.1 | Çok yüksek | Projenin temeli |
| 0.5 | Çok yüksek | İlk görsel demo |
| 1.0 | Çok yüksek | İlk çalışan ürün |
| 1.1 | Çok yüksek | Ana farklılaştırıcı AI özellik |
| 1.2 | Yüksek | Kullanıcı bağlılığı |
| 1.5 | Orta-yüksek | Turizm deneyimi ve erişilebilirlik |
| 2.0 | Çok yüksek | Kurumsal satış ve ölçeklenme |
| 2.1 | Yüksek | Veri kalitesi ve güven |
| 2.5 | Orta-yüksek | Etkileyici AI demo |
| 3.0 | Yüksek | Çoklu şehir ve SaaS |
| 3.5 | Orta | Kişiselleştirme |
| 4.0 | Orta-yüksek | Gelir modeli |
| 5.0 | Uzun vadeli | Uluslararası büyüme |

---

## 18. İlk 6 Ay İçin Gerçekçi Odak

İlk 6 ayda tüm versiyonlara odaklanmak doğru değildir.

İlk 6 ayın gerçekçi odağı:

```text
0.1 → 0.5 → 1.0 → 1.1
```

Yani:

1. Dokümantasyon
2. Statik SwiftUI demo
3. Samsun temel MVP
4. AI rota oluşturma

Kullanıcı hesabı, sesli rehber ve belediye paneli önemli olsa da 1.0 ve 1.1 sağlam olmadan bu aşamalara geçilmemelidir.

---

## 19. Sürüm Geçiş Kuralı

Bir üst sürüme geçmeden önce şu üç soru sorulmalıdır:

1. Önceki sürüm gerçekten çalışıyor mu?
2. Kullanıcı bu sürümden değer alıyor mu?
3. Eklediğimiz yeni özellik projeyi büyütüyor mu, yoksa karıştırıyor mu?

Bu üç soruya olumlu cevap verilemiyorsa yeni sürüme geçilmemelidir.

---

## 20. Gün 4 Sonunda Alınan Kararlar

- Gezio versiyonlara bölünerek geliştirilecek.
- İlk odak 0.1, 0.5, 1.0 ve 1.1 olacak.
- İlk şehir Samsun olacak.
- İlk platform iOS olacak.
- Belediye paneli 2.0 sürümüne bırakılacak.
- Fotoğraftan mekân tanıma 2.5 sürümüne bırakılacak.
- Sesli rehber 1.5 sürümüne bırakılacak.
- Çoklu şehir yapısı 3.0 sürümüne bırakılacak.
- Gelir modeli 4.0 sürümünde detaylandırılacak.
- Uluslararasılaşma 5.0 sürümünde ele alınacak.

---

## 21. Kontrol Listesi

Gün sonunda şu maddeler tamamlanmış olmalıdır:

- [ ] Versiyonlar belirlendi.
- [ ] 0.1 kapsamı yazıldı.
- [ ] 0.5 kapsamı yazıldı.
- [ ] 1.0 kapsamı yazıldı.
- [ ] 1.1 kapsamı yazıldı.
- [ ] 1.2 kapsamı yazıldı.
- [ ] 1.5 kapsamı yazıldı.
- [ ] 2.0 kapsamı yazıldı.
- [ ] 2.5 kapsamı yazıldı.
- [ ] 3.0 ve sonrası yazıldı.
- [ ] İlk 6 ay odağı belirlendi.
- [ ] Sürüm geçiş kuralı yazıldı.

---

## 22. Kısa Özet

Gezio büyük bir proje olduğu için bütün özellikler tek seferde geliştirilmeyecektir.

En doğru geliştirme sırası:

```text
Dokümantasyon → Statik Demo → Temel MVP → AI Rota → Kullanıcı Hesabı → Sesli Rehber → Belediye Paneli → Fotoğraftan Tanıma → Çoklu Şehir → Gelir Modeli → Uluslararasılaşma
```

Ana ilke:

> Küçük başla, doğru sırayla büyüt.

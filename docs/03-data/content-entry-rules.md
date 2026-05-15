# GezioGo – İçerik Giriş Kuralları

> Hafta 3 / Gün 7 çıktısı  
> Dosya amacı: Panelden girilecek şehir, mekan, etkinlik ve iş ortağı içerikleri için kalite ve yayın kurallarını belirlemek.

---

## 1. Dokümanın Amacı

GezioGo’da içerikler farklı kaynaklardan gelebilir:

- GezioGo ekibi
- Belediyeler
- İl kültür ve turizm müdürlükleri
- Bakanlık
- Restoran/kafe işletmeleri
- Oteller ve acenteler
- Etkinlik organizatörleri

Bu nedenle içerik girişinde ortak kalite kuralları olmalıdır.

Ana ilke:

> Eksik, doğrulanmamış veya hatalı içerik mobil uygulamada yayına alınmamalıdır.

---

## 2. Genel İçerik Kuralları

- Her içerikte benzersiz `id` olmalıdır.
- Her içerik bir `cityId` değerine bağlı olmalıdır.
- Her içerikte `contentStatus` bulunmalıdır.
- Mümkünse her içerikte `sourceUrl` bulunmalıdır.
- Her içerikte `createdAt` ve `updatedAt` alanları olmalıdır.
- Yayına alınan içeriklerde `lastVerifiedAt` alanı bulunmalıdır.
- Mobil uygulamada sadece `published` içerikler gösterilmelidir.

---

## 3. Şehir İçeriği Kuralları

Şehir içerikleri için zorunlu alanlar:

```text
id
name
slug
country
region
shortDescription
latitude
longitude
isActive
```

Kurallar:

- Şehir adı doğru yazılmalıdır.
- Şehir ID’si küçük harf ve Türkçe karakter içermeyen formatta olmalıdır.
- Şehir aktif değilse mobil uygulamada görünmemelidir.
- Şehir görseli yoksa geçici placeholder kullanılabilir.

---

## 4. Mekan İçeriği Kuralları

Mekan içerikleri için zorunlu alanlar:

```text
id
cityId
name
category
shortDescription
district
address
latitude
longitude
priceType
contentStatus
```

Kurallar:

- Konum bilgisi olmayan mekan yayına alınmamalıdır.
- Kategori seçilmeden mekan kaydedilmemelidir.
- Açıklama çok kısa veya anlamsız olmamalıdır.
- Görsel yoksa içerik taslak veya revizyon durumunda kalabilir.
- Ücret bilgisi bilinmiyorsa `priceType = unknown` kullanılmalıdır.
- Saat ve ücret gibi değişken bilgiler kesin ifade edilmemeli, kaynakla desteklenmelidir.

---

## 5. Etkinlik İçeriği Kuralları

Etkinlik içerikleri için zorunlu alanlar:

```text
id
cityId
title
category
description
venueName
startDate
priceType
contentStatus
```

Kurallar:

- Başlangıç tarihi olmayan etkinlik kaydedilmemelidir.
- Tarihi geçmiş etkinlikler otomatik olarak arşive alınabilir.
- Bilet linki varsa `ticketUrl` alanına eklenmelidir.
- Bilet linki yoksa mobilde “Bilet bilgisi bulunamadı” gösterilmelidir.
- Etkinlik görseli yoksa geçici görsel kullanılabilir ama onay sürecinde kontrol edilmelidir.

---

## 6. İşletme / Partner İçeriği Kuralları

Partner kayıtları için zorunlu alanlar:

```text
id
name
type
cityId
status
permissions
```

Kurallar:

- Her işletme yalnızca kendi içeriğini düzenleyebilmelidir.
- Belediye ve kurumlar yalnızca yetkili oldukları şehir içeriklerini yönetebilmelidir.
- Partner yetkileri `permissions` alanında açıkça tanımlanmalıdır.
- İşletme içerikleri çoğu durumda doğrudan yayına çıkmamalı, onaya gönderilmelidir.

---

## 7. Görsel Kuralları

- Görseller mümkün olduğunca yüksek kaliteli olmalıdır.
- Telif hakkı belirsiz görseller kullanılmamalıdır.
- Görsel içeriği mekan veya etkinlikle uyumlu olmalıdır.
- Ana görsel ile ek görseller ayrılmalıdır.
- Görsel yükleme panelde ayrı bir adım olarak düşünülmelidir.

---

## 8. Kaynak ve Doğrulama Kuralları

- Resmi kurum içeriklerinde kaynak URL tercih edilmelidir.
- Etkinliklerde bilet veya resmi duyuru linki eklenmelidir.
- Son doğrulama tarihi `lastVerifiedAt` alanına yazılmalıdır.
- Kaynağı belirsiz içerikler onaydan geçmemelidir.

---

## 9. AI Rota İçin İçerik Kuralları

AI rota yalnızca şu içerikleri kullanmalıdır:

```text
contentStatus = published
latitude / longitude dolu
cityId kullanıcının seçtiği şehirle aynı
kategori veya etiket bilgisi mevcut
```

AI rota şu içerikleri kullanmamalıdır:

```text
draft
pending_review
rejected
needs_revision
archived
```

---

## 10. Onay Süreci Kuralları

İçerik yayın akışı:

```text
Taslak
  ↓
Onaya Gönder
  ↓
İnceleme
  ↓
Onay / Red / Revizyon
  ↓
Yayınlama
```

Kurallar:

- Editör ve işletme kullanıcıları içerikleri doğrudan yayına alamamalıdır.
- Onay yetkilisi eksik içeriklere düzeltme notu yazabilmelidir.
- Onaylanan içerik yayına alınmadan önce son kez kontrol edilmelidir.
- Yayınlanan içerik sonradan arşive alınabilmelidir.

---

## 11. MVP İçin Minimum Kalite Kriterleri

Bir mekanın MVP’de yayınlanması için:

- Şehir ID’si olmalı
- Adı olmalı
- Kategorisi olmalı
- Kısa açıklaması olmalı
- Adresi veya konumu olmalı
- Enlem/boylam bilgisi olmalı
- Yayın durumu `published` olmalı

Bir etkinliğin MVP’de yayınlanması için:

- Şehir ID’si olmalı
- Etkinlik adı olmalı
- Tarih/saat bilgisi olmalı
- Mekan adı veya adres bilgisi olmalı
- Açıklaması olmalı
- Yayın durumu `published` olmalı

---

## 12. Sonuç

İçerik giriş kuralları GezioGo’nun güvenilir, düzenli ve kurumsal kullanılabilir olmasını sağlar.

Ana ilke:

> GezioGo’da içerik yalnızca güzel görünmek için değil, doğru, güncel ve güvenilir olmak için yönetilmelidir.

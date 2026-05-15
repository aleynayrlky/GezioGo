# GezioGo – Content Status Model / İçerik Durum Modeli

> Hafta 3 / Gün 6 çıktısı  
> Dosya amacı: GezioGo’da içeriklerin taslak, inceleme, onay ve yayın sürecindeki durumlarını tanımlamak.

---

## 1. Modelin Amacı

GezioGo’da içerikler farklı kullanıcılar tarafından eklenebilir:

- GezioGo editörü
- Belediye yetkilisi
- İl kültür ve turizm müdürlüğü
- Restoran/kafe işletmesi
- Etkinlik organizatörü
- Otel/acente

Bu nedenle içerikler doğrudan yayına çıkmamalı, kontrollü bir onay sürecinden geçmelidir.

Ana ilke:

> Mobil uygulamada yalnızca onaylanmış ve yayında olan içerikler görünmelidir.

---

## 2. Content Status Değerleri

```text
draft
pending_review
approved
published
rejected
needs_revision
archived
```

---

## 3. Durum Açıklamaları

| Durum | Türkçe Ad | Açıklama |
|---|---|---|
| `draft` | Taslak | İçerik kaydedildi ama onaya gönderilmedi |
| `pending_review` | İnceleme Bekliyor | İçerik onaya gönderildi |
| `approved` | Onaylandı | İçerik onaylandı ama henüz yayına alınmadı |
| `published` | Yayında | İçerik mobil uygulamada görünür |
| `rejected` | Reddedildi | İçerik uygun bulunmadı |
| `needs_revision` | Revizyon Gerekli | İçerik düzeltilmeli |
| `archived` | Arşivlendi | İçerik yayından kaldırıldı |

---

## 4. İçerik Yayın Akışı

```text
Taslak
  ↓
Onaya Gönderildi
  ↓
İnceleme
  ├── Onaylandı → Yayında
  ├── Revizyon Gerekli → Taslak / Düzenleme
  └── Reddedildi
```

Teknik karşılık:

```text
draft
  ↓
pending_review
  ↓
approved
  ↓
published
```

Alternatif durumlar:

```text
pending_review → needs_revision
pending_review → rejected
published → archived
```

---

## 5. İçerik Review Modeli

Onay sürecini takip etmek için ayrı bir review kaydı tutulabilir.

| Alan | Tip | Açıklama |
|---|---|---|
| `id` | String | Review ID |
| `contentId` | String | İçerik ID |
| `contentType` | String | place / event / partner |
| `submittedBy` | String | Onaya gönderen kullanıcı |
| `reviewedBy` | String | Onaylayan/reddeden kullanıcı |
| `status` | String | pending / approved / rejected / needs_revision |
| `reviewNote` | String | Onay/red açıklaması |
| `submittedAt` | String | Gönderim tarihi |
| `reviewedAt` | String | İnceleme tarihi |

---

## 6. Örnek Review JSON

```json
{
  "id": "review_001",
  "contentId": "bandirma-vapuru-muzesi",
  "contentType": "place",
  "submittedBy": "editor_001",
  "reviewedBy": "approver_001",
  "status": "approved",
  "reviewNote": "İçerik uygun. Kaynak ve konum bilgisi kontrol edildi.",
  "submittedAt": "2026-05-15T10:00:00+03:00",
  "reviewedAt": "2026-05-15T12:00:00+03:00"
}
```

---

## 7. Mobil Uygulama Kuralı

Mobil uygulama aşağıdaki içerikleri göstermelidir:

```text
contentStatus = published
```

Mobil uygulama aşağıdaki içerikleri göstermemelidir:

```text
draft
pending_review
approved
rejected
needs_revision
archived
```

Not: `approved` içerik henüz yayına alınmamış olabilir. Bu nedenle mobilde sadece `published` durumundaki içerikler gösterilmelidir.

---

## 8. Panel Kuralı

Panelde kullanıcı rolüne göre farklı durumlar görünür:

| Rol | Görebileceği Durumlar |
|---|---|
| Super Admin | Tüm durumlar |
| Editör | Kendi taslakları, revizyonları, onaya gönderdikleri |
| Belediye / Kurum | Kendi içerikleri |
| İşletme | Kendi işletme içerikleri |
| Onay Yetkilisi | `pending_review`, `needs_revision`, `approved` |

---

## 9. Durum Değişikliği Kimler Yapabilir?

| İşlem | Yetkili Roller |
|---|---|
| Taslak oluşturma | Editör, Belediye, Kurum, İşletme, Organizatör |
| Onaya gönderme | İçerik sahibi / editör |
| Onaylama | Onay yetkilisi, Super Admin |
| Reddetme | Onay yetkilisi, Super Admin |
| Yayına alma | Super Admin, yetkili onaycı |
| Arşivleme | Super Admin, yetkili kurum |

---

## 10. Sonuç

Content status yapısı GezioGo’nun güvenilir içerik yönetimi için zorunludur.

Ana kural:

> Yayında olmayan hiçbir içerik mobil kullanıcıya gösterilmemelidir.

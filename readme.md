# DAO GROW NFT Oluşturucu Platformu

## Genel Bakış

DAO GROW, Sui Network üzerinde çalışmak üzere tasarlanmış, NFT tabanlı topraksız tarım tariflerini tokenize eden yenilikçi bir platformdur. Platform, hidroponik ve aeroponik yetiştirme tekniklerini NFT ile birleştirerek kullanıcıların deneyimlerini güvenli ve şeffaf şekilde paylaşmalarını sağlar.

## Akıllı Kontratlar

### 1. Treasury Modülü

[`daogrow::treasury`](daogrow/sources/treasury.move) modülü, NFT mint işlemleri için uygulanacak ücreti ve kasanın sahibini yönetir.

- **Yapı:** `Treasury`
- **Sabit Ücret:** `NFT_MINT_FEE`
- **Fonksiyonlar:**
  - [`get_nft_mint_cost`](daogrow/sources/treasury.move): Mint ücretini döner.
  - [`get_owner`](daogrow/sources/treasury.move): Kasayı oluşturan cüzdan adresini döner.

### 2. DAO GROW Modülü

[`daogrow::daogrow`](daogrow/sources/daogrow.move) modülü, NFT mint sürecini yönetir.

- **Yapı:** `RecipeNFT` – NFT özelliklerini tanımlar.
- **Fonksiyon:**
  - [`mint_with_fee`](daogrow/sources/daogrow.move): Mint işlemi sırasında kullanıcının hesabından mint ücreti kesilerek, ücret treasury’ye transfer edilir ve kalan bakiye kontrol edilip işleme devam edilir. Ardından yeni NFT oluşturulup kullanıcının hesabına aktarılır.

## İşleyiş Süreci

1. **Mint İşlemi Başlatılır:**  
   Kullanıcı, NFT mint işlemi gerçekleştirmek istediğinde [`mint_with_fee`](daogrow/sources/daogrow.move) fonksiyonu devreye girer.

2. **Mint Ücreti Kontrolü ve Transferi:**

   - Kullanıcının mevcut bakiyesi, Treasury modülündeki mint ücreti ile karşılaştırılır.
   - Hesaptan mint ücreti kesilerek, kesilen tutar treasury’de tanımlı adrese transfer edilir.

3. **NFT Oluşturulması:**
   - Kullanıcının bakiyesi sıfırlanmazsa kalan miktar kontrol edilir ve gerekirse tekrar kullanıcıya transfer edilir.
   - Yeni NFT, `RecipeNFT` yapısıyla oluşturulup kullanıcının hesabına aktarılır.

## Proje Yapısı

- **daogrow/sources/treasury.move:** Treasury modülü tanımlamaları ve fonksiyonları.
- **daogrow/sources/daogrow.move:** NFT mint işlemi ve `RecipeNFT` yapısı.
- Diğer modüller ve dosyalar, platformun ek işlevselliği için genişletilebilir.

## Kurulum ve Çalıştırma

- **Gereksinimler:**  
  Move derleyicisi, Sui SDK ve ilgili bağımlılıklar.
- **Derleme:**  
  İlgili Move ve Sui komutları kullanılarak proje derlenir ve test edilir.

## Lisans

Proje, ilgili lisans bilgilerini içeren [LICENSE](LICENSE) dosyası kapsamında

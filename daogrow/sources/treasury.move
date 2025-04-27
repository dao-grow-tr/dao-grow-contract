module daogrow::treasury;

const NFT_MINT_FEE: u64 = 1_000;

// Kasa yapısı
public struct Treasury has key, store {
    id: UID,
    owner: address,
    nft_mint_fee: u64,
}

// Init fonksiyonu
fun init(ctx: &mut TxContext) {
    let treasury = create_treasury(ctx);
    transfer::share_object(treasury);
}

// Kasa oluşturma fonksiyonu
fun create_treasury(ctx: &mut TxContext): Treasury {
    Treasury {
        id: object::new(ctx),
        owner: tx_context::sender(ctx),
        nft_mint_fee: NFT_MINT_FEE,
    }
}

// NFT mint ücretini dönen fonksiyon
public fun get_nft_mint_cost(treasury: &Treasury): u64 {
    treasury.nft_mint_fee
}

public fun get_owner(treasury: &Treasury): address {
    treasury.owner
}
module daogrow::daogrow;

use std::string::String;
use sui::{sui::SUI, coin::{Coin}};

use daogrow::treasury::Treasury;

// NFT'yi temsil eden struct
public struct RecipeNFT has key, store {
    id: UID,
    name: String,
    description: String,
    recipe: String,  // recipe başlangıçta gizlenmiş olacak
    price: u64,
    owner: address,
    image_url: String,
}

// NFT oluşturma fonksiyonu
#[allow(lint(self_transfer))]
public fun mint_with_fee(
    name: String,
    description: String,
    recipe: String,
    price: u64,
    treasury: &mut Treasury,
    mut account_balance: Coin<SUI>,
    ctx: &mut TxContext,
) {
    let nft_mint_fee = treasury.get_nft_mint_cost();
    assert!(account_balance.value() >= nft_mint_fee, 0);

    let fee_coin = account_balance.split(nft_mint_fee, ctx);

    transfer::public_transfer(fee_coin, treasury.get_owner());

    if (account_balance.value()==0) {
        account_balance.destroy_zero();
    } else {
        transfer::public_transfer(account_balance, tx_context::sender(ctx));
    };

    let nft = RecipeNFT {
        id: object::new(ctx),
        name: name,
        description: description,
        recipe: recipe,  // recipe verisi owner tarafından görülebilir
        price: price,
        image_url: (b"https://raw.githubusercontent.com/Svobodennn/Dao.grow/refs/heads/main/token.png").to_string(),
        owner: tx_context::sender(ctx),
    };

    transfer::public_transfer(
        nft,
        tx_context::sender(ctx)
    );
}
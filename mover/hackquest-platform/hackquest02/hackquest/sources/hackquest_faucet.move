module hackquest::hackquest_faucet {

    // 依赖
    use sui::coin::{Self, TreasuryCap};
    use sui::url;
    use std::ascii::string;

    // 结构体
    public struct HACKQUEST_FAUCET has drop {}

    // 初始化函数
    #[allow(lint(share_owned))]
    fun init(witness: HACKQUEST_FAUCET, ctx: &mut TxContext) {
        let ( treasuryCap, coinMetadata) = 
            coin::create_currency(
                witness, 
                9, 
                b"HQF", 
                b"HackQuestFaucet", 
                b"this is hackquest faucet coin", 
                option::some(url::new_unsafe(string(b"https://www.hackquest.io/images/landing/center_astronaut.svg"))), 
                ctx
            );
        
        transfer::public_freeze_object(coinMetadata);
        transfer::public_share_object(treasuryCap);
    }

    // 铸造
    public entry fun mint_in_my_module(cap: &mut TreasuryCap<HACKQUEST_FAUCET>, value: u64, receipt: address, ctx: &mut TxContext) {
        let my_coin = coin::mint(cap, value, ctx);
        transfer::public_transfer(my_coin, receipt);
    }

}
module hackquest::hackquest {

    // 依赖
    use sui::coin::{Self, TreasuryCap};
    use sui::url;
    use std::ascii::string;

    // 结构体
    public struct HACKQUEST has drop {}

    // 初始化函数
    fun init(witness: HACKQUEST, ctx: &mut TxContext) {
        let ( treasuryCap, coinMetadata) = 
            coin::create_currency(
                witness, 
                9, 
                b"HQ", 
                b"HackQuest", 
                b"this is hackquest coin", 
                option::some(url::new_unsafe(string(b"https://www.hackquest.io/images/landing/center_astronaut.svg"))), 
                ctx
            );
        
        transfer::public_freeze_object(coinMetadata);
        transfer::public_transfer(treasuryCap, ctx.sender());
    }

    // 铸造
    public entry fun mint_in_my_module(cap: &mut TreasuryCap<HACKQUEST>, value: u64, receipt: address, ctx: &mut TxContext) {
        let my_coin = coin::mint(cap, value, ctx);
        transfer::public_transfer(my_coin, receipt);
    }

    public entry fun mint_in_my_module2(cap: &mut TreasuryCap<HACKQUEST>, value: u64, receipt: address, ctx: &mut TxContext) {
        coin::mint_and_transfer(cap, value, receipt, ctx);
    }

}
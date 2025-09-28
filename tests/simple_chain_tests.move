module 0x1::simple_chain_tests {
use std::vector;
use std::signer;
use 0x1::SimpleChain;


#[test]
public fun test_init_and_append(account: &signer) {
// ініціалізація
SimpleChain::init_chain(account);
// додаємо блоки
SimpleChain::append_block(account, vector::from_u8(1, 2, 3));
SimpleChain::append_block(account, vector::from_u8(4, 5, 6));
let blocks = SimpleChain::get_blocks(signer::address_of(account));
assert!(vector::length(&blocks) == 3, 1);
// індекси
let b0 = vector::borrow(&blocks, 0);
let b1 = vector::borrow(&blocks, 1);
let b2 = vector::borrow(&blocks, 2);
assert!(b0.index == 0, 2);
assert!(b1.index == 1, 3);
assert!(b2.index == 2, 4);
}
}

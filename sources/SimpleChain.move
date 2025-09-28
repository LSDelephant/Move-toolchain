module 0x1::SimpleChain {
use std::vector;
use std::signer;
use std::error;
use 0x1::Block;
use 0x1::AddressHelpers;


const E_NOT_INITIALIZED: u64 = 1;


/// Ресурс, що зберігає ланцюг блоків під контролем однієї адреси
struct Chain has key {
blocks: vector<Block::Block>,
}


/// Ініціалізація ланцюга: додається genesis-блок
public fun init_chain(account: &signer) {
let genesis_data = vector::empty<u8>();
let prev = vector::empty<u8>();
let genesis = Block::new(0, prev, genesis_data);
let vec = vector::empty<Block::Block>();
vector::push_back(&mut (vec), genesis);
move_to(account, Chain { blocks: vec });
}


public fun append_block(account: &signer, data: vector<u8>) acquires Chain {
let addr = signer::address_of(account);
if (!exists<Chain>(addr)) {
// подати помилку, якщо не ініціалізовано
abort E_NOT_INITIALIZED;
}
let chain_ref = borrow_global_mut<Chain>(addr);
let len = vector::length(&chain_ref.blocks);
let prev_block = vector::borrow(&chain_ref.blocks, len - 1);
let prev_hash = prev_block.hash;
let new_block = Block::new((prev_block.index + 1), prev_hash, data);
vector::push_back(&mut chain_ref.blocks, new_block);
}


public fun get_blocks(account_addr: address): vector<Block::Block> acquires Chain {
if (!exists<Chain>(account_addr)) {
abort E_NOT_INITIALIZED;
}
let chain_ref = borrow_global<Chain>(account_addr);
chain_ref.blocks
}
}

module 0x1::Block {
use std::vector;
use std::option::{Self, Option};
use std::signer;
use std::timestamp;


/// Примітивний тип Block — зберігається як ресурс-пакет у SimpleChain
struct Block has copy, drop, store {
index: u64,
timestamp: u64,
prev_hash: vector<u8>,
hash: vector<u8>,
data: vector<u8>,
}


public fun new(index: u64, prev_hash: vector<u8>, data: vector<u8>): Block {
let ts = timestamp::now_seconds();
let payload = make_payload(index, ts, &prev_hash, &data);
let hash = hash_bytes(&payload);
Block { index, timestamp: ts, prev_hash, hash, data }
}


fun make_payload(index: u64, ts: u64, prev: &vector<u8>, data: &vector<u8>): vector<u8> {
let mut out = vector::empty<u8>();
vector::append(&mut out, &u64_to_bytes(index));
vector::append(&mut out, &u64_to_bytes(ts));
vector::append(&mut out, prev);
vector::append(&mut out, data);
out
}


fun u64_to_bytes(x: u64): vector<u8> {
let mut out = vector::empty<u8>();
let mut i = 0;
while (i < 8) {
let b = (x >> (i * 8)) as u8;
vector::push_back(&mut out, b);
i = i + 1;
}
out
}


// Примітивний "hash" — для демонстрації використовуємо blake2b (якщо доступний),
// або fallback на просте збирання байт. Тут викликується зовнішня утиліта hash_bytes
native public fun hash_bytes(data: &vector<u8>): vector<u8>;
}

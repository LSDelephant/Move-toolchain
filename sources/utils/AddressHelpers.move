module 0x1::AddressHelpers {
use std::vector;


// Проста реалізація hash_bytes для середовищ без native-хешу:
// Це НЕ криптографічний хеш — тільки для демонстрації/тестів.
public fun hash_bytes_fallback(data: &vector<u8>): vector<u8> {
let mut acc = 0u64;
let mut i = 0;
while (i < vector::length(data)) {
let b = *vector::borrow(data, i);
acc = acc.wrapping_mul(31) ^ (b as u64);
i = i + 1;
}
// конвертувати acc в байти (8 байтів)
let mut out = vector::empty<u8>();
let mut j = 0;
while (j < 8) {
let byte = (acc >> (j * 8)) as u8;
vector::push_back(&mut out, byte);
j = j + 1;
}
out
}
}

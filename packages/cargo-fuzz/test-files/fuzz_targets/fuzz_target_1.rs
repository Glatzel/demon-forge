#![no_main]

use libfuzzer_sys::fuzz_target;

fn buggy_parse(data: &[u8]) -> u32 {
    // BUG: no length check
    let value = u32::from_le_bytes([data[0], data[1], data[2], data[3]]);

    value
}

fuzz_target!(|data: &[u8]| {
    buggy_parse(data);
});

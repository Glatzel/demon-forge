#![no_main]

use libfuzzer_sys::fuzz_target;

fuzz_target!(|data: &[u8]| {
    let _len = data.len();

    if data.is_empty() {
        return;
    }

    let _first = data[0];
});

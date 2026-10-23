$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:RUSTC_BOOTSTRAP = "1"
cargo test -- --ignored
cargo-build --path ./crates/edit --config .cargo/release.toml

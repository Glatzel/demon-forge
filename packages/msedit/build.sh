ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
export RUSTC_BOOTSTRAP=1
cargo test -- --ignored
cargo_build --path ./crates/edit --config .cargo/release.toml

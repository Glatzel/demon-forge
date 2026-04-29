ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
set -- $(get_cargo_arg)
export RUSTC_BOOTSTRAP=1
cargo test -- --ignored
cargo install --path ./crates/edit --config .cargo/release.toml "$@"

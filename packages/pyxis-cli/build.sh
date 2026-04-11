cd rust
export PROJ_ROOT="$(realpath "$PREFIX")"
cargo install --bin pyxis --root $PREFIX --path ./crates/pyxis-cli

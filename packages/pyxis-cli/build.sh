cd rust
export PROJ_ROOT="$(realpath "$BUILD_PREFIX")"
cargo install --bin pyxis --root $PREFIX --path ./crates/pyxis-cli

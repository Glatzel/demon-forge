$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:RUSTC_BOOTSTRAP = "1"
cargo test -- --ignored
cargo-build --git https://github.com/microsoft/edit --tag "v$env:PKG_VERSION" --config .cargo/release.toml edit

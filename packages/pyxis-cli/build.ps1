$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build --git https://github.com/Glatzel/pyxis --tag "v$env:PKG_VERSION" pyxis-cli

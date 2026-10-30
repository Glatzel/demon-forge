$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build --git https://github.com/rtk-ai/rtk --tag "v$env:PKG_VERSION" rtk

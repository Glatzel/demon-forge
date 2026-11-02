$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build --git https://github.com/xerj-org/xerj --tag "v$env:PKG_VERSON-rc.100"

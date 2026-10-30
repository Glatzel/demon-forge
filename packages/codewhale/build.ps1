$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build --git https://github.com/codewhale-hq/CodeWhale --tag "v$env:PKG_VERSION" codewhale-cli

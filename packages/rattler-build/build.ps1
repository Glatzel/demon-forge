$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo-build --git https://github.com/prefix-dev/rattler-build --tag "v$env:PKG_VERSION" rattler-build

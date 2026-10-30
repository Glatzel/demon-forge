$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:LIBRARY_PATH="$(realpath $PREFIX/lib):$LIBRARY_PATH"
cargo-build --git https://github.com/superradcompany/microsandbox --tag "v$env:PKG_VERSION" microsandbox-cli

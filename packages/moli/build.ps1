$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:CC  = "clang-cl"
$env:CXX = "clang-cl"
cargo-build --git https://github.com/lexmount/moli --tag v$env:PKG_VERSION moli

$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:CXX = "$env:BUILD_PREFIX\Library\bin\clang-cl.exe"
cargo-build --git https://github.com/lexmount/moli --tag "v$env:PKG_VERSION" moli

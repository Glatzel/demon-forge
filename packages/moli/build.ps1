$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:CXX = "$env:BUILD_PREFIX\Library\bin\clang-cl.exe"
Copy-Item ./skills/ $PREFIX/skills/ -Recurse
cargo-build --path ./moli

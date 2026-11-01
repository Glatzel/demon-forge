$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$env:CXX = "$env:BUILD_PREFIX\Library\bin\clang-cl.exe"
process-skills ./skills
cargo-build --path ./moli

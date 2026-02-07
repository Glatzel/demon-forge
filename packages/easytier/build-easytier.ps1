$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsLinux) { $env:LIBCLANG_PATH = "$env:BUILD_PREFIX/lib"}
cargo install @(Get-Cargo-Arg) --path ./easytier

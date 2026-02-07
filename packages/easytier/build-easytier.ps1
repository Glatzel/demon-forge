$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    $env:LIB = "$PWD/LIB/x64;$env:LIB"
    $env:INCLUDE = "$PWD/Include;$env:INCLUDE"
}
cargo install @(Get-Cargo-Arg) --path ./easytier

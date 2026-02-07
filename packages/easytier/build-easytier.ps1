$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if($IsLinux){
    $env:CFLAGS="-std=c11"
    $env:CXXFLAGS="-std=c++11"
}
cargo install @(Get-Cargo-Arg) easytier

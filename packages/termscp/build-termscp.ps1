$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if($IsLinux){dnf install }
cargo install --path . @(Get-Cargo-Arg)

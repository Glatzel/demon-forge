$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if($IsLinux){dnf install -y samba}
if($IsMacOS){brew install -y samba}
cargo install --path . @(Get-Cargo-Arg)

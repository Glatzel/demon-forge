$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsLinux) {
    dnf install -y samba-devel
     $Env:PKG_CONFIG_PATH = "/usr/share/pkgconfig`:/usr/lib/pkgconfig`:/usr/lib64/pkgconfig`:$Env:PKG_CONFIG_PATH"
}
if ($IsMacOS) {
    brew install samba
    $brewPrefix = brew --prefix
    $Env:PKG_CONFIG_PATH = "$brewPrefix/share/pkgconfig`:$brewPrefix/lib/pkgconfig`:$Env:PKG_CONFIG_PATH"
}
cargo install --path . @(Get-Cargo-Arg)

if($IsLinux){
    $env:OPENSSL_DIR="$env:BUILD_PREFIX"
}$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
cargo install $name @(Get-Cargo-Arg)
if ($IsWindows) {
    Rename-Item $env:PREFIX/bin/unused-features.exe $env:PREFIX/bin/${env:PKG_NAME}.exe
}
else {
    Rename-Item $env:PREFIX/bin/unused-features $env:PREFIX/bin/${env:PKG_NAME}
}

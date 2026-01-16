if($IsLinux){
    $env:OPENSSL_DIR="$env:BUILD_PREFIX"
}
build-cargo-package ${env:PKG_NAME}
if ($IsWindows) {
    Rename-Item $env:PREFIX/bin/unused-features.exe $env:PREFIX/bin/${env:PKG_NAME}.exe
}
else {
    Rename-Item $env:PREFIX/bin/unused-features $env:PREFIX/bin/${env:PKG_NAME}
}

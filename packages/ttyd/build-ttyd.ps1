$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
New-Item $env:PREFIX/bin -ItemType Directory
switch ($env:TARGET_PLATFORM) {
    "win-64" { copy-item $ROOT/temp/$env:PKG_NAME/$env:PKG_NAME/build/$env:PKG_NAME.exe $env:PREFIX/bin/$env:PKG_NAME.exe }
    "linux-64" { copy-item $ROOT/temp/$env:PKG_NAME/$env:PKG_NAME/build/$env:PKG_NAME $env:PREFIX/bin/$env:PKG_NAME }
    "linux-aarch64" { copy-item $ROOT/temp/$env:PKG_NAME/$env:PKG_NAME/build/$env:PKG_NAME $env:PREFIX/bin/$env:PKG_NAME }
}

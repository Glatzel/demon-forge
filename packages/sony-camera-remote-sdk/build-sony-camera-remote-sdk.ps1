$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsWindows) {
    aria2c -c -x16 -s16 -d ./ `
        https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/win?fm=en-us `
        -o "${env:PKG_NAME}.zip"
}
if ($IsMacOS) {
    aria2c -c -x16 -s16 -d ./ `
        https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/mac?fm=en-us `
        -o "${env:PKG_NAME}.zip"
}
if ($IsLinux -and $arch -eq "X64") {
    aria2c -c -x16 -s16 -d ./ `
        https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_x86?fm=en-us `
        -o "${env:PKG_NAME}.zip"
}
if ($IsMacOS -and $arch -eq "Arm64") {
    aria2c -c -x16 -s16 -d ./ `
        https://support.d-imaging.sony.co.jp/disoft_DL/SDK_DL/linux_64?fm=en-us `
        -o "${env:PKG_NAME}.zip"
}
7z x "$f" "-osdk"

New-Item "$env:PREFIX/${env:PKG_NAME}" -ItemType Directory
Copy-Item "./sdk/*" "$env:PREFIX/${env:PKG_NAME}" -Recurse
Remove-Item $env:PREFIX/${env:PKG_NAME}/app/*.h
Remove-Item $env:PREFIX/${env:PKG_NAME}/app/*.cpp
Remove-Item $env:PREFIX/${env:PKG_NAME}/*.zip
Remove-Item $env:PREFIX/${env:PKG_NAME}/external/opencv/ -Recurse

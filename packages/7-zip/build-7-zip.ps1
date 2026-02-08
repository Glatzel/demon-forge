New-Item $env:PREFIX/bin -ItemType Directory
if ($IsWindows) {
    Copy-Item "$env:BUILD_PREFIX/bin/7zz.exe" "$env:PREFIX/bin/7z.exe"
}
else {
    Copy-Item "$env:BUILD_PREFIX/bin/7zz" "$env:PREFIX/bin/7z"
}

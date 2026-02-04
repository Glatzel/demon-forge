$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

7z x "crsdk.zip" "-osdk"
Set-Location sdk
Remove-Item "*.zip" -Recurse -Force
7z x "*.zip"
if ($IsWindows) {
    New-Item "$env:PREFIX/Library/bin" -ItemType Directory
    New-Item "$env:PREFIX/Library/include" -ItemType Directory
    New-Item "$env:PREFIX/Library/share/crsdk" -ItemType Directory

    Copy-Item "./RemoteCli/app/crsdk/*" "$env:PREFIX/Library/include" -Recurse
    Copy-Item "./RemoteCli/external/crsdk/*" "$env:PREFIX/Library/bin" -Recurse
    Copy-Item "./*" "$env:PREFIX/Library/share/crsdk" -Recurse
}
else {
    New-Item "$env:PREFIX/lib" -ItemType Directory
    New-Item "$env:PREFIX/include" -ItemType Directory
    New-Item "$env:PREFIX/share/crsdk" -ItemType Directory

    Copy-Item "./RemoteCli/app/crsdk/*" "$env:PREFIX/include" -Recurse
    Copy-Item "./RemoteCli/external/crsdk/*" "$env:PREFIX/lib" -Recurse
    Copy-Item "./*" "$env:PREFIX/share/crsdk" -Recurse
}

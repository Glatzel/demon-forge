$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

7z x "crsdk.zip" "-osdk"
Set-Location sdk
foreach ($f in Get-ChildItem ./*.zip) {
    $zip_name = $f.BaseName
    7z x "$f" "-o$zip_name"
}
Remove-Item ./SourceCodeOfOpenSourceSoftware -Recurse -Force
Remove-Item ./RemoteCli/external/opencv -Recurse -Force
Remove-Item "*.zip" -Recurse -Force
if ($IsWindows) {
    New-Item "$env:PREFIX/Library/bin" -ItemType Directory
    New-Item "$env:PREFIX/Library/include" -ItemType Directory
    New-Item "$env:PREFIX/Library/share/crsdk" -ItemType Directory

    Copy-Item "./RemoteCli/app/CRSDK/*" "$env:PREFIX/Library/include" -Recurse
    Copy-Item "./RemoteCli/external/crsdk/*" "$env:PREFIX/Library/bin" -Recurse
    Copy-Item "./*" "$env:PREFIX/Library/share/crsdk" -Recurse
}
else {
    New-Item "$env:PREFIX/lib" -ItemType Directory
    New-Item "$env:PREFIX/include" -ItemType Directory
    New-Item "$env:PREFIX/share/crsdk" -ItemType Directory

    Copy-Item "./RemoteCli/app/CRSDK/*" "$env:PREFIX/include" -Recurse
    Copy-Item "./RemoteCli/external/crsdk/*" "$env:PREFIX/lib" -Recurse
    Copy-Item "./*" "$env:PREFIX/share/crsdk" -Recurse
}

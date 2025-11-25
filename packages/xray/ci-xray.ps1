Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "EasyTier/EasyTier"
update-recipe -version $latest_version

if ($IsWindows) {
    gh release download -R "EasyTier/EasyTier" -p "Xray-windows-64.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
if ($IsLinux -and ($arch -eq "X64")) {
    gh release download -R "EasyTier/EasyTier" -p "Xray-linux-64.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
if ($IsLinux -and ($arch -eq "Arm64")) {
    gh release download -R "EasyTier/EasyTier" -p "Xray-linux-arm64-v8a.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
if ($IsMacOS) {
    gh release download -R "EasyTier/EasyTier" -p "Xray-macos-arm64-v8a.zip" `
        -O  $ROOT/temp/$name/$name.zip --clobber
}
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
build-pkg

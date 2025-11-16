Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-latest-version -repo "Glatzel/$name"

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
if ($IsWindows) {
    gh release download -R "Glatzel/$name" -p "*.exe" `
        -O  $ROOT/temp/$name/$name.exe --clobber
}
if ($IsLinux -and ($arch -ne "Arm64")) {
    gh release download -R "Glatzel/$name" -p "*.x86_64" `
        -O  $ROOT/temp/$name/$name --clobber
}
if ($IsLinux -and ($arch -eq "Arm64")) {
    gh release download -R "Glatzel/$name" -p "*.aarch64" `
        -O  $ROOT/temp/$name/$name --clobber
}
update-recipe -version $latest_version
build-pkg

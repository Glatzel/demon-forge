Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-latest-version -repo "Glatzel/$name"
$latest_version = "$latest_version".Replace("$name-", "")

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
if ($IsWindows) {
    gh release download -R "tsl0922/$name" -p "*.exe" `
        -O  $ROOT/temp/$name/$name.exe --clobber
}
if ($IsLinux) {
    gh release download -R "tsl0922/$name" -p "*.x86_64" `
        -O  $ROOT/temp/$name/$name --clobber
}
update-recipe -version $latest_version
build-pkg

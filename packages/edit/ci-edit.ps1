Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-latest-version -repo "microsoft/$name"
$latest_version = "$latest_version".Replace("v", "")

Remove-Item $ROOT/temp/$name -Recurse -ErrorAction SilentlyContinue
New-Item  $ROOT/temp/$name -ItemType Directory
if ($isWindows) {
    gh release download -R "microsoft/$name" -p "*x86_64-windows*" `
        -O  $ROOT/temp/$name/$name.zip --clobber
    7z x $ROOT/temp/$name/$name.zip -o$ROOT/temp/$name
}
if ($IsLinux) {
    gh release download -R "microsoft/$name" -p "*x86_64-linux*" `
        -O  $ROOT/temp/$name/$name.xz --clobber
    7z x $ROOT/temp/$name/$name.xz -o$ROOT/temp/$name
}
update-recipe -version $latest_version
build-pkg

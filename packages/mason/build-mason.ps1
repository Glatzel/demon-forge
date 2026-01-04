Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$version = get-current-version
Set-Location $ROOT/temp/$name
gh repo clone Glatzel/$name
Set-Location $name
git checkout tags/"v$version" -b "branch-$version"

    & ./scripts/build.ps1 -Release
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/bin/Mason/*" "$env:PREFIX/bin/$name" -Recurse

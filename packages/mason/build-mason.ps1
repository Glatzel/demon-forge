Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location $ROOT/temp/$name
gh repo clone Glatzel/$name
Set-Location $name
git checkout tags/"v$(get-current-version)" -b "branch-$(get-current-version)"
if ($env:DIST_BUILD) {
    & ./scripts/build.ps1 -Release
}
else {
    & ./scripts/build.ps1
}
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/bin/Mason/*" "$env:PREFIX/bin/$name" -Recurse

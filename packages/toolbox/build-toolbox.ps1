Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
Set-Location $ROOT/temp/$name
gh repo clone Glatzel/$name
Set-Location $name
git checkout tags/"v$latest_version" -b "$latest_version-branch"
pip install $ROOT/temp/$name/$name/python -v

$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$version = get-current-version
Set-Location .
gh repo clone Glatzel/$name
Set-Location $name
git checkout tags/"v$version" -b "branch-$version"
pip install ./$name/python -v

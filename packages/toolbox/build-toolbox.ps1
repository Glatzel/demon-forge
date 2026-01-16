

$version = $env:PKG_VERSION
Set-Location .
gh repo clone Glatzel/${env:PKG_NAME}
Set-Location ${env:PKG_NAME}
git checkout tags/"v$version" -b "branch-$version"
pip install ./${env:PKG_NAME}/python -v

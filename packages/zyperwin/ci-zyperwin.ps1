Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-github -repo "https://github.com/ZyperWave/ZyperWinOptimize"
update-recipe -version $latest_version

gh release download -R ZyperWave/ZyperWinOptimize -p "ZyperWin*.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
build-pkg

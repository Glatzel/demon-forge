Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

gh release download -R ZyperWave/ZyperWinOptimize -p "ZyperWin*.zip" `
    -O  $ROOT/temp/$name/$name.zip --clobber
7z x "$ROOT/temp/$name/$name.zip" "-o$ROOT/temp/$name/$name"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name/Release/*" "$env:PREFIX/bin" -Recurse

# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"

Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

gh release download -R "jqlang/$name" -p "$name-windows-amd64.exe" `
    -O  $ROOT/temp/$name/$name.exe --clobber
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "$ROOT/temp/$name/$name.exe" "$env:PREFIX/bin/$name.exe"

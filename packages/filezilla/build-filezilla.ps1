Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
python download.py
$zipfile = (Get-ChildItem "$ROOT/temp/$name/FileZilla*win64.zip")[0]
7z x "$zipfile" "-o$ROOT/temp/$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "$ROOT/temp/$name/FileZilla*/*" "$env:PREFIX/bin/$name/" -Recurse

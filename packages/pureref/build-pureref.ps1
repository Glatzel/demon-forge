$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1


python download.py
$zipfile=(Get-ChildItem "./*.zip")[0]
7z x "$zipfile" "-o."
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "./$name/Pureref*/*" "$env:PREFIX/bin/$name" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"

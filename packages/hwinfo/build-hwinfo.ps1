$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1


python download.py
$zipfile = (Get-ChildItem "./hwi_*.zip")[0]
7z x "$zipfile" "-o./$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "./$name/$name/*" "$env:PREFIX/bin/$name" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$name.json" "$env:PREFIX/Menu"

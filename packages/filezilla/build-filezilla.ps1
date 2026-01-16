$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

python download.py
$zipfile = (Get-ChildItem "./FileZilla*win64.zip")[0]
7z x "$zipfile" "-o."
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "./$name/FileZilla*/*" "$env:PREFIX/bin/$name/" -Recurse

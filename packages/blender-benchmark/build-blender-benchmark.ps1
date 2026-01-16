$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

&$env:BUILD_PREFIX/python download.py
$zipfile = (Get-ChildItem "./*.zip")[0]
7z x "$zipfile" "-o./$name"
New-Item $env:PREFIX/bin/$name -ItemType Directory
Copy-Item "./$name/$name*/*" "$env:PREFIX/bin/$name" -Recurse

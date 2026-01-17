$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
python $env:RECIPE_DIR/download.py
$zipfile = (Get-ChildItem "./*.zip")[0]
7z x "$zipfile" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item "./${env:PKG_NAME}*/benchmark-launcher-cli.exe" "$env:PREFIX/bin" -Recurse

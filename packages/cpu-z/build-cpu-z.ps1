& $env:BUILD_PREFIX/$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
python $env:RECIPE_DIR/download.py
$zipfile = (Get-ChildItem "./*.zip")[0]
7z x "$zipfile" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"

&$env:BUILD_PREFIX/python $env:RECIPE_DIR/download.py
$zipfile = (Get-ChildItem "./*.zip")[0]
7z x "$zipfile" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}*/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse

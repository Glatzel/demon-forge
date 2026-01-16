python download.py
$zipfile = (Get-ChildItem "./*.zip")[0]
7z x "$zipfile" "-o."
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/FurMark_win64/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"

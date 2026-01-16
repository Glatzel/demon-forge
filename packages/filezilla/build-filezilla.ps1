python $env:RECIPE_DIR/download.py
$zipfile = (Get-ChildItem "./FileZilla*win64.zip")[0]
7z x "$zipfile" "-o."
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/FileZilla*/*" "$env:PREFIX/bin/${env:PKG_NAME}/" -Recurse

$content=Get-Content $env:RECIPE_DIR/dnc-init.ps1
$content="`$version=`"$env:PKG_VERSION`"`n"+$content
new-item $env:PREFIX/etc/conda/activate.d -itemType Directory -Force -ErrorAction SilentlyContinue
Set-Content $env:PREFIX/etc/conda/activate.d/dnc-init.ps1 $content

$content = Get-Content $env:RECIPE_DIR/dnc-init.ps1
$content = $content -replace '$version', "`$version=`"$env:PKG_VERSION`""
Write-Output $content
new-item $env:PREFIX/scripts -itemType Directory -Force -ErrorAction SilentlyContinue
Set-Content $env:PREFIX/scripts/dnc-init.ps1 $content
new-item $env:PREFIX/etc/conda/activate.d -itemType Directory -Force -ErrorAction SilentlyContinue
Copy-Item $env:RECIPE_DIR/dnc-init.bat $env:PREFIX/etc/conda/activate.d/

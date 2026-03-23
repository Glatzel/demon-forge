Write-Output $content
new-item $env:PREFIX/scripts -itemType Directory -Force -ErrorAction SilentlyContinue
(Get-Content $env:RECIPE_DIR/dnc-init.ps1) -replace '$version', "`$version=`"$env:PKG_VERSION`"" | Set-Content $env:PREFIX/scripts/dnc-init.ps1
new-item $env:PREFIX/etc/conda/activate.d -itemType Directory -Force -ErrorAction SilentlyContinue
Copy-Item $env:RECIPE_DIR/dnc-init.bat $env:PREFIX/etc/conda/activate.d/

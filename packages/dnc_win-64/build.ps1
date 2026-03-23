new-item $env:PREFIX/scripts -itemType Directory -Force -ErrorAction SilentlyContinue
(Get-Content $env:RECIPE_DIR/install-dnc.ps1) -replace '\$template_version', "`$version=`"$env:PKG_VERSION`"" | Set-Content $env:PREFIX/scripts/install-dnc.ps1
Write-Output (Get-Content $env:PREFIX/scripts/install-dnc.ps1)
new-item $env:PREFIX/etc/conda/activate.d -itemType Directory -Force -ErrorAction SilentlyContinue
Copy-Item $env:RECIPE_DIR/dnc-activate.bat $env:PREFIX/etc/conda/activate.d/

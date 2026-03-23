new-item $env:PREFIX/Scripts -itemType Directory -Force -ErrorAction SilentlyContinue
(Get-Content $env:RECIPE_DIR/install-dnc.ps1) -replace '\$template_version', "`$version=`"$env:PKG_VERSION`"" | Set-Content $env:PREFIX/Scripts/install-dnc.ps1
Write-Output (Get-Content $env:PREFIX/Scripts/install-dnc.ps1)
new-item $env:PREFIX/etc/conda/activate.d -itemType Directory -Force -ErrorAction SilentlyContinue
Copy-Item $env:RECIPE_DIR/dnc-activate.bat $env:PREFIX/etc/conda/activate.d/
Copy-Item $env:RECIPE_DIR/dnc.bat $env:PREFIX/Scripts/

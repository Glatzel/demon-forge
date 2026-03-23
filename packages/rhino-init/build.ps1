new-item $env:PREFIX/Scripts -itemType Directory -Force -ErrorAction SilentlyContinue
(Get-Content $env:RECIPE_DIR/rhino-init.ps1) -replace '\$template_version', "`$version=`"$env:PKG_VERSION`"" | Set-Content $env:PREFIX/Scripts/rhino-init.ps1
Write-Output (Get-Content $env:PREFIX/Scripts/rhino-init.ps1)
Copy-Item $env:RECIPE_DIR/rhino-init.bat $env:PREFIX/Scripts/

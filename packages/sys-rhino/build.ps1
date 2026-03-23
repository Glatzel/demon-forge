new-item $env:PREFIX/Scripts -itemType Directory -Force -ErrorAction SilentlyContinue
(Get-Content $env:RECIPE_DIR/sys-install-rhino.ps1) -replace '\$template_version', "`$version=`"$env:PKG_VERSION`"" | Set-Content $env:PREFIX/Scripts/sys-install-rhino.ps1
Write-Output (Get-Content $env:PREFIX/Scripts/sys-install-rhino.ps1)

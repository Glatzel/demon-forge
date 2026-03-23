new-item $env:PREFIX/Scripts -itemType Directory -Force -ErrorAction SilentlyContinue
(Get-Content $env:RECIPE_DIR/sys-install-dnc.ps1) -replace '\$template_version', "`$version=`"$env:PKG_VERSION`"" | Set-Content $env:PREFIX/Scripts/sys-install-dnc.ps1
Write-Output (Get-Content $env:PREFIX/Scripts/sys-install-dnc.ps1)

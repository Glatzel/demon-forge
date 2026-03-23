new-item $env:PREFIX/Scripts -itemType Directory -Force -ErrorAction SilentlyContinue
Copy-Item $env:PREFIX/Scripts/sys-install.ps1 $env:PREFIX/Scripts/sys-install.ps1
Copy-Item $env:PREFIX/Scripts/sys-install.bat $env:PREFIX/Scripts/sys-install.bat

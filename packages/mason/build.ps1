& ./scripts/build.ps1 -Release
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./bin/Mason/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse

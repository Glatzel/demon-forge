$version = $env:PKG_VERSION
Set-Location .
gh repo clone Glatzel/${env:PKG_NAME}
Set-Location ${env:PKG_NAME}
git checkout tags/"v$version" -b "branch-$version"    & ./scripts/build.ps1 -Release
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/bin/Mason/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse

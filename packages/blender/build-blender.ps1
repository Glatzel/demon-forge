$version = [Version]"$env:PKG_VERSION"
$major = $version.Major
$minor = $version.Minor
aria2c -c -x16 -s16 -d ./ `
    https://download.blender.org/release/Blender${major}.${minor}/blender-${version}-windows-x64.zip `
    -o "${env:PKG_NAME}.zip"
7z x "${env:PKG_NAME}.zip" "-o./${env:PKG_NAME}"
New-Item $env:PREFIX/bin/${env:PKG_NAME} -ItemType Directory
Copy-Item "./${env:PKG_NAME}/${env:PKG_NAME}*/*" "$env:PREFIX/bin/${env:PKG_NAME}" -Recurse
# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "${env:RECIPE_DIR}/${env:PKG_NAME}.json" "$env:PREFIX/Menu"

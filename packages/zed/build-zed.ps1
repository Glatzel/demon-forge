Set-Location $PSScriptRootNew-Item $env:PREFIX/bin -ItemType DirectoryCopy-Item "$ROOT/temp/$env:PKG_NAME/$env:PKG_NAME/target/release/zed.exe" "$env:PREFIX/bin/zed.exe"
Copy-Item "$ROOT/temp/$env:PKG_NAME/$env:PKG_NAME/target/release/cli.exe" "$env:PREFIX/bin/zed-cli.exe"# shortcut
New-Item $env:PREFIX/Menu -ItemType Directory
Copy-Item "$env:RECIPE_DIR/$env:PKG_NAME.json" "$env:PREFIX/Menu"
if ($IsWindows) {
    Copy-Item "$ROOT/temp/$env:PKG_NAME/$env:PKG_NAME.ico" "$env:PREFIX/Menu"
}

$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
aria2c -c -x16 -s16 -d ./ `
    "https://download.blender.org/release/BlenderBenchmark2.0/launcher/benchmark-launcher-cli-${env:PKG_VERSION}-windows.zip" `
    -o "${env:PKG_NAME}.zip"

7z x "$zipfile" "-o$env:PREFIX/bin"

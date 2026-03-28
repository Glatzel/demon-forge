$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($env:TARGET_PLATFORM -eq 'linux-64') {
    $pattern = "linux-x86_64"
}
if ($env:TARGET_PLATFORM -eq 'linux-aarch64') {
    $pattern = "linux-aarch64"
}
if ($env:TARGET_PLATFORM -eq 'osx-arm64') {
    $pattern = "darwin-aarch64"
}
gh release download -R zerocore-ai/microsandbox `
    -p "microsandbox-$pattern.tar.gz" `
    -O microsandbox.tar.gz
7z x microsandbox.tar.gz -so | 7z x -si -ttar "-o$env:PREFIX/bin"
chmod +x "$env:PREFIX/bin/msb"
New-Item -Path $env:PREFIX/etc/conda/activate.d -ItemType Directory -Force -ErrorAction SilentlyContinue
Copy-Item -Path $env:RECIPE_DIR/microsandbox-kvm.sh -Destination $env:PREFIX/etc/conda/activate.d

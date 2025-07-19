Set-Location $PSScriptRoot
$env:EMBED_RESOURCE_FILES = "ON"
./vcpkg/vcpkg install --triplet arm64-linux-release --x-install-root ./installed

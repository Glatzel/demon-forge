Set-Location $PSScriptRoot
# install static dependency
Write-Output "::group::static"
./vcpkg/vcpkg install --triplet arm64-osx-release --x-install-root ./installed
Write-Output "::endgroup::"

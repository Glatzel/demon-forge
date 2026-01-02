Set-Location $PSScriptRoot

# use custom triplet
$triplet = Resolve-Path ./triplet

# install static dependency
Write-Output "::group::static"
if ($IsWindows) {
    &./vcpkg/vcpkg.exe install --overlay-triplets=$triplet --triplet x64-windows-static --x-install-root ./installed
}
if ($IsLinux) {
    ./vcpkg/vcpkg install --triplet x64-linux-release --x-install-root ./installed
}
if($IsMacOS){
    ./vcpkg/vcpkg install --triplet arm64-osx-release --x-install-root ./installed
}
Write-Output "::endgroup::"

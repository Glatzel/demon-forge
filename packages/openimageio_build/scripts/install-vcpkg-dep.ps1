Set-Location $PSScriptRoot
Set-Location ..
$triplet=Resolve-Path ./triplet

Write-Output "::group::install OpenColorIO vcpkg"
Set-Location ./ocio_dep
vcpkg install --overlay-triplets=$triplet
Set-Location ..
Write-Output "::endgroup::"

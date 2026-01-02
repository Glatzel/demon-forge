param($pkg)
Set-Location $PSScriptRoot
Set-Location ..

if (-not (Test-Path "./output/*/$pkg-*.conda" )) {
    throw "The specified path was not found: ./output/*/$pkg-*.conda"
}
foreach ($pkg_file in Get-ChildItem "./output/*/$pkg-*.conda") {
    Write-Output "::group:: upload $pkg"
    pixi run rattler-build upload prefix -s -c glatzel $pkg_file
    Write-Output "::endgroup::"
}

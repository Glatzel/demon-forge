param($pkg)
Set-Location $PSScriptRoot
Set-Location ..

if (-not (Test-Path "./output/$env:TARGET_PLATFORM/$pkg-*.conda" )) {
    throw "The specified path was not found: ./output/*/$pkg-*.conda"
}
foreach ($pkg_file in Get-ChildItem "./output/$env:TARGET_PLATFORM/$pkg-*.conda") {
    Write-Output "::group:: upload $pkg"
    pixi run rattler-build upload prefix -s -c glatzel $pkg_file
    Write-Output "::endgroup::"
}

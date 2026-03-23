param($pkg)
Set-Location $PSScriptRoot
Set-Location ..

if (-not (Test-Path "./output/$env:TARGET_PLATFORM/*.conda" )) {
    throw "The specified path was not found: ./output/$env:TARGET_PLATFORM/*.conda"
}
foreach ($pkg_file in Get-ChildItem "./output/$env:TARGET_PLATFORM/*.conda") {
    Write-Output "::group:: upload $pkg"
    pixi run rattler-build upload prefix -s -c glatzel --generate-attestation $pkg_file
    Write-Output "::endgroup::"
}

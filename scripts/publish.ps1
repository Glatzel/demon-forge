param($pkg)
Set-Location $PSScriptRoot
Set-Location ..

foreach ($pkg_file in Get-ChildItem "./packages/$pkg/output/win-64/*.conda" -Recurse -ErrorAction Continue) {
    Write-Output "::group:: upload $pkg"
    pixi run rattler-build upload prefix -s -c glatzel $pkg_file
    $LASTEXITCODE=0
    Write-Output "::endgroup::"
}

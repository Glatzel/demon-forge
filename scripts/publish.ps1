Set-Location $PSScriptRoot
Set-Location ..
$pkgs=("imagemagick", "jq")
foreach( $pkg in $pkgs){
    foreach ($pkg_file in Get-ChildItem "./dist/$pkg/*.conda" -Recurse -ErrorAction Continue) {
        Write-Output "::group:: upload $pkg"
        pixi run rattler-build upload prefix -c https://repo.prefix.dev/glatzel $pkg_file
        Write-Output "::endgroup::"
    }
}

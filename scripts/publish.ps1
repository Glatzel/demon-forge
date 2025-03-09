Set-Location $PSScriptRoot
Set-Location ..


    foreach ($pkg in Get-ChildItem "./*/output/win-64/*.conda") {
        Write-Output "::group:: upload $pkg"
        pixi run rattler-build upload prefix -c https://repo.prefix.dev/glatzel "$pkg"
        Write-Output "::endgroup::"
    }

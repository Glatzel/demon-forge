Set-Location $PSScriptRoot
Set-Location ..
. ./scripts/setup.ps1

if (Test-Path "./*/output/win-64/*.conda") {
    foreach ($pkg in Get-ChildItem "./*/output/win-64/*.conda") {
        $filename = Split-Path $pkg -Leaf
        try {
            $search_result=pixi search -c https://repo.prefix.dev/glatzel imagemagick
            if ($LASTEXITCODE -ne 0) {
                Write-Host "Caught an error: $_"
                $LASTEXITCODE=0
            }
        }
        catch {
            Write-Host "Caught an error: $_"
            $LASTEXITCODE=0
        }
        if (-not ("$search_result" -like "*$filename*")) {
            write-output "::group::publish $pkg"
            pixi run rattler-build upload prefix -c glatzel "$pkg"
            write-output "::endgroup::"
        }
        else { write-output "No new package." }
    }
}
else { write-output "No new package." }

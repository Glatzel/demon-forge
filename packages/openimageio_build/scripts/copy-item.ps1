Set-Location $PSScriptRoot
Set-Location ..

Remove-Item dist -Force -Recurse -ErrorAction SilentlyContinue

new-item dist -itemtype directory
copy-Item ./external/OpenImageIO/dist/bin/* ./dist
copy-Item ./.pixi/envs/oiio/Library/bin/*.dll ./dist

new-item temp -itemtype directory -ErrorAction SilentlyContinue
foreach ($dep in Get-ChildItem ./dist/*.dll) {
    $name = $dep.Name
    copy-Item $dep ./temp
    Remove-Item $dep
    ./dist/oiiotool.exe --help > $_
    if ($LASTEXITCODE -ne 0) {
        copy-Item "./temp/$name" ./dist
        Write-Host "It is a dependency: $name" -ForegroundColor Green
    }
    else{
        Write-Host "It is not a dependency: $name" -ForegroundColor Red
    }
}
$LASTEXITCODE=0

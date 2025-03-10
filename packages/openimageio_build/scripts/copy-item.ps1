Set-Location $PSScriptRoot
Set-Location ..

Remove-Item openimageio -Force -Recurse -ErrorAction SilentlyContinue

new-item openimageio -itemtype directory
copy-Item ./external/OpenImageIO/dist/bin/* ./openimageio
copy-Item ./.pixi/envs/oiio/Library/bin/*.dll ./openimageio

new-item temp -itemtype directory -ErrorAction SilentlyContinue
foreach ($dep in Get-ChildItem ./openimageio/*.dll) {
    $name = $dep.Name
    copy-Item $dep ./temp
    Remove-Item $dep
    ./openimageio/oiiotool.exe --help > $_
    if ($LASTEXITCODE -ne 0) {
        copy-Item "./temp/$name" ./openimageio
        Write-Host "It is a dependency: $name" -ForegroundColor Green
    }
    else{
        Write-Host "It is not a dependency: $name" -ForegroundColor Red
    }
}

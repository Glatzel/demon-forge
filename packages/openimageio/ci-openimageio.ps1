Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
# process version
$latest_version = get-version-github -repo "AcademySoftwareFoundation/OpenImageIO"
update-recipe -version $latest_version

#pre-build
Copy-Item $PSScriptRoot/build/* $ROOT/temp/$name/ -Recurse
& $ROOT/temp/$name/scripts/pixi-setup.ps1
& $ROOT/temp/$name/scripts/clone-repo.ps1
& $ROOT/temp/$name/scripts/vcpkg-setup.ps1
& $ROOT/temp/$name/scripts/vcpkg-install.ps1
& $ROOT/temp/$name/scripts/build-oiio.ps1
& $ROOT/temp/$name/scripts/copy-item.ps1

#rattler build
Set-Location $PSScriptRoot
build-pkg

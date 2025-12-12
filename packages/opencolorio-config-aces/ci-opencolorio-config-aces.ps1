Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "AcademySoftwareFoundation/OpenColorIO-Config-ACES"
update-recipe -version $latest_version

gh release download -R "AcademySoftwareFoundation/OpenColorIO-Config-ACES" -p "*.ocio" --dir "$ROOT/temp/$name" --clobber

build-pkg

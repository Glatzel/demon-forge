Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
gh release download -R "AcademySoftwareFoundation/OpenColorIO-Config-ACES" -p "*.ocio" --dir "$ROOT/temp/$name" --clobber
Get-ChildItem $ROOT/temp/$name | ForEach-Object {
    $name = $_.BaseName
    $ext = $_.Extension

    # Extract prefix before the first "-v"
    if ($name -match '^(.*?)-v') {
        $newName = "$($Matches[1])$ext"
        Rename-Item $_.FullName $newName
    }
}
New-Item $env:PREFIX/ocio -ItemType Directory
Copy-Item "$ROOT/temp/$name/*" "$env:PREFIX/ocio/" -Recurse

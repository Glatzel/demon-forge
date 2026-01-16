

gh release download -R "AcademySoftwareFoundation/OpenColorIO-Config-ACES" -p "*.ocio" --dir "." --clobber
Get-ChildItem . | ForEach-Object {
    $n = $_.BaseName
    $ext = $_.Extension

    # Extract prefix before the first "-v"
    if ($n -match '^(.*?)-v') {
        $newName = "$($Matches[1])$ext"
        Rename-Item $_.FullName $newName
    }
}
New-Item $env:PREFIX/ocio -ItemType Directory
Copy-Item "./${env:PKG_NAME}/*" "$env:PREFIX/ocio/" -Recurse

$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

7z x "crsdk.zip" "-osdk"
Remove-Item "./SourceCodeOfOpenSourceSoftware" -Recurse -Force
New-Item "$env:PREFIX/${env:PKG_NAME}" -ItemType Directory
Copy-Item "./sdk/*" "$env:PREFIX/${env:PKG_NAME}" -Recurse

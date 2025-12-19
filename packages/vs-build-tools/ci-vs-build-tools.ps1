Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-text -text $(winget show Microsoft.VisualStudio.BuildTools) -pattern ': (\d+\.\d+\.\d+)'
update-recipe -version $latest_version

aria2c -c -x16 -s16 -d "$ROOT/temp/$name/" `
    "https://aka.ms/vs/stable/vs_BuildTools.exe" `
    -o "vs_BuildTools.exe"
build-pkg

Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-url -url "https://www.cpuid.com/softwares/cpu-z.html" -pattern 'cpu-z_(\d+\.\d+)-en.zip'
update-recipe -version $latest_version


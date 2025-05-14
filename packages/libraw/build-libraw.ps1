Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
if ($IsMacOS) { $mac_suffix = "_mac" }

New-Item $env:PREFIX/$name -ItemType Directory
Copy-Item "$PSScriptRoot/../libraw_build$mac_suffix/installed/*" "$env:PREFIX/$name" -Recurse

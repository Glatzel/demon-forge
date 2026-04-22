Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
update-recipe $(get-version-winget "c/CodecGuide/K-LiteCodecPack/Full")

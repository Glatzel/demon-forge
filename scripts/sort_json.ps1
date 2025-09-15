Set-Location $PSScriptRoot/..
jq '. | {include: (.include | sort_by(.pkg, .machine))}' pkg_map.json | Set-Content -Path pkg_map.json
Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1

$latest_version = get-version-text $(gh api repos/Glatzel/toolbox/contents/python/pyproject.toml  --header "Accept: application/vnd.github.raw") 'version\s?=\s?"(\d+\.\d+\.\d+)"'
dispatch-workflow $latest_version

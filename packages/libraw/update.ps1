$latest_version = get-version-github -repo "LibRaw/LibRaw"
$latest_version = "$latest_version".Replace("b", "")
update-recipe $latest_version
Set-Location $PSScriptRoot

"| Package | Current Version | Latest Version | Status |" >> $env:GITHUB_STEP_SUMMARY
"|---|---|---|---|" >> $env:GITHUB_STEP_SUMMARY
# Input CSV
$csvFile = "$PSScriptRoot/../packages.csv"
# Output YAML
$yamlFile = "$PSScriptRoot/../packages.yaml"
Set-Content -Path $yamlFile -Value ""
# Read CSV
$csvData = Import-Csv $csvFile
ForEach ($Row in $csvData)
{
    $name=$Row.pkg
    Write-Output "::group::update $name"
    Set-Location "$PSScriptRoot/../packages/$name"
    ./update.ps1
    Write-Output "::endgroup::"
}

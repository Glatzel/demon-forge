# Input CSV
$csvFile = "$PSScriptRoot/../packages.csv"
# Output YAML
$yamlFile = "$PSScriptRoot/../packages.yaml"
Set-Content -Path $yamlFile -Value ""
# Read CSV
$csvData = Import-Csv $csvFile
ForEach ($Row in $csvData) {
    $Row.pkg>>$yamlFile
}

# Print the exact contents of the YAML file
Write-Output "::group::yaml"
Get-Content $yamlFile | ForEach-Object { Write-Host $_ }
Write-Output "::endgroup::"


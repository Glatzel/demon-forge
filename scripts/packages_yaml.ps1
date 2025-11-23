# Input CSV
$csvFile = "$PSScriptRoot/packages.csv"
# Output YAML
$yamlFile = "$PSScriptRoot/packages.yaml"

# Read CSV
$csvData = Import-Csv $csvFile

# Generate all YAML lines at once
$yamlLines = $csvData | ForEach-Object {
    @(
        "$($_.pkg):"
        "  - ./packages/$($_.pkg)/**"
    )
} | Select-Object -ExpandProperty *

# Write all lines to file at once
$yamlLines | Set-Content -Encoding UTF8 $yamlFile
Write-Host "Generated YAML file: $yamlFile"

# Print the exact contents of the YAML file
Write-Output "::group::yaml"
Get-Content $yamlFile | ForEach-Object { Write-Host $_ }
Write-Output "::endgroup::"

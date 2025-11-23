# Input CSV file
$csvFile = "packages.csv"
# Output JSON file
$jsonFile = "packages-matrix.json"

# Read CSV
$csvData = Import-Csv $csvFile

# Initialize JSON array
$matrix = @()

foreach ($row in $csvData) {
    $pkg = $row.pkg
    foreach ($machine in "windows-latest","macos-latest","ubuntu-latest","ubuntu-24.04-arm") {
        if ($row.$machine -eq "true") {
            $matrix += [PSCustomObject]@{
                pkg     = $pkg
                machine = $machine
            }
        }
    }
}

# Convert to minified JSON and save
$matrix | ConvertTo-Json -Depth 10 -Compress | Set-Content -Encoding UTF8 $jsonFile

Write-Host "Converted CSV to minified JSON for GitHub Actions: $jsonFile"

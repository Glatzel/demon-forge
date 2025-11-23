# Input CSV file
$csvFile = "$PSScriptRoot/../packages.csv"

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
$matrix=$matrix | ConvertTo-Json -Depth 10 -Compress | jq '{include: .}'

Write-Output "::group::json"
$matrix | jq .
Write-Output "::endgroup::"

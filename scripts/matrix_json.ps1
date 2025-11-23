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

$matrix=$matrix | ConvertTo-Json -Depth 10 -Compress | jq '{include: .}'
switch ($env:GITHUB_EVENT){
    "schedule","workflow_dispatch"{$matrix=$($matrix|jq -c --argjson pkgs "${env:CHANGED_KEYS}" '.include | map(select(.pkg as $p | $pkgs | index($p)))')}
}
"matrix=$matrix" >> $env:GITHUB_OUTPUT
Write-Output "::group::json"
$matrix | jq .
Write-Output "::endgroup::"

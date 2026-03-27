$csvData = Import-Csv "$PSScriptRoot/../packages.csv"
$matrix = @()

$platforms = "win-64", "osx-arm64", "linux-64", "linux-aarch64", "noarch"

foreach ($row in $csvData)
{
    $pkg = $row.pkg
    foreach ($platform in $platforms)
    {
        $value = $row.$platform
        if (-not $value)
        { continue
        }

        $entry = @{
            pkg             = $pkg
            target_platform = $platform
        }

        if ($value -like "*+*")
        {
            $machine, $container = $value -split '\+', 2
            $entry.machine = $machine
            $entry.container = 'ghcr.io/glatzel/' + $container
        } else
        {
            $entry.machine = $value
        }
        $matrix += $entry
    }
}
$matrix = $matrix |
    ConvertTo-Json -Depth 10 -Compress |
    jq '{include: .}'
# Clean CHANGED_KEYS
$env:CHANGED_KEYS = "${env:CHANGED_KEYS}".Replace("\", "")
$matrix = $matrix | jq -c --argjson pkgs "${env:CHANGED_KEYS}" '{include: .include | map(select(.pkg as $p | $pkgs | index($p)))}'
if ($($matrix | jq '.include | length == 0') -eq 'true')
{
    $matrix = $null
}
# Output matrix to GitHub Actions
"matrix=$matrix" >> $env:GITHUB_OUTPUT
$matrix | jq .

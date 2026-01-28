$csvData = Import-Csv "$PSScriptRoot/../packages.csv"
$matrix = @()

foreach ($row in $csvData) {
    $pkg = $row.pkg
    foreach ($target_platform in "win-64", "osx-arm64", "linux-64", "linux-aarch64") {
        if ($row.$target_platform) {
            if (
                (($env:GITHUB_EVENT_NAME -eq "pull_request") -or ($env:GITHUB_EVENT_NAME -eq "push")) `
                    -and
                $row.$target_platform -like "**+**"
            ) {
                $parts = $row.$target_platform -split '\+'
                $matrix += @{
                    pkg             = $pkg
                    machine         = $parts[0]
                    container       = $parts[1]
                    target_platform = $target_platform
                }
            }
            else {
                $matrix += @{
                    pkg             = $pkg
                    machine         = $row.$target_platform
                    target_platform = $target_platform
                }

            }
        }
    }
}

$matrix = $matrix |
ConvertTo-Json -Depth 10 -Compress |
jq '{include: .}'
# Clean CHANGED_KEYS
$env:CHANGED_KEYS = "${env:CHANGED_KEYS}".Replace("\", "")

switch ($env:GITHUB_EVENT_NAME) {
    "push" {
        $matrix = $matrix | jq -c --argjson pkgs "${env:CHANGED_KEYS}" '{include: .include | map(select(.pkg as $p | $pkgs | index($p)))}'
    }
    "pull_request" {
        $matrix = $matrix | jq -c --argjson pkgs "${env:CHANGED_KEYS}" '{include: .include | map(select(.pkg as $p | $pkgs | index($p)))}'
    }
    default {
        $matrix = $matrix | jq -c '{include: .include | map(.machine = "ubuntu-slim") | group_by(.pkg) | map(.[0])}'
    }
}

# Output matrix to GitHub Actions
"matrix=$matrix" >> $env:GITHUB_OUTPUT
$matrix | jq .

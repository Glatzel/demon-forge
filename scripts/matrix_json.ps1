$csvData = Import-Csv "$PSScriptRoot/../packages.csv"
$matrix = @()

foreach ($row in $csvData) {
    $pkg = $row.pkg
    foreach ($machine in "windows-latest", "macos-latest", "ubuntu-latest", "ubuntu-24.04-arm") {
        if ($row.$machine -eq "true") {
            $matrix += [PSCustomObject]@{
                pkg     = $pkg
                machine = $machine
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
        $matrix = $matrix |
        jq -c --argjson pkgs "${env:CHANGED_KEYS}" @"
                {include: .include | map(select(.pkg as $p | $pkgs | index($p)))}
            "
    }
    "pull_request" {
        $matrix = $matrix |
        jq -c --argjson pkgs "${env:CHANGED_KEYS}" @"
                {include: .include | map(select(.pkg as $p | $pkgs | index($p)))}
            "
    }
    default {
        $rule = @"
{include: .include | group_by(.pkg) | map(sort_by(
    if .machine == "ubuntu-latest" then 0
    elif .machine == "macos-latest" then 1
    elif .machine == "windows-latest" then 2
    elif .machine == "ubuntu-24.04-arm" then 3
    else 4
    end
) | .[0])}
"@
        $matrix = $matrix | jq -c "$rule"
    }
}

# Output matrix to GitHub Actions
"matrix=$matrix" >> $env:GITHUB_OUTPUT

Write-Output "::group::json"
$matrix | jq .
Write-Output "::endgroup::"

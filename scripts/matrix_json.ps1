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

$matrix = $matrix | ConvertTo-Json -Depth 10 -Compress | jq '{include: .}'
$env:CHANGED_KEYS = "${env:CHANGED_KEYS}".Replace("\", "")
switch ($env:GITHUB_EVENT_NAME) {
    "push" { $matrix = $matrix | jq -c --argjson pkgs "${env:CHANGED_KEYS}" '{include:.include | map(select(.pkg as $p | $pkgs | index($p)))}' }
    "pull_request" { $matrix = $matrix | jq -c --argjson pkgs "${env:CHANGED_KEYS}" '{include:.include | map(select(.pkg as $p | $pkgs | index($p)))}' }
    "schedule" { $matrix = $matrix | jq -c . }
    "workflow_dispatch" { $matrix = $matrix | jq -c . }
    default { $matrix = $matrix | jq -c . }
}
"matrix=$matrix">> $env:GITHUB_OUTPUT
Write-Output "::group::json"
$matrix | jq .
Write-Output "::endgroup::"

Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
function Get-PreviousMinorLatestTag {
    param(
        [string]$RepoUrl = "https://github.com/mcneel/rhino.inside-revit"
    )

    $versions = git ls-remote --tags $RepoUrl |
    ForEach-Object { ($_ -split "`t")[1] } |
    Where-Object { $_ -match '^refs/tags/v\d+\.\d+\.\d+\.\d+$' } |
    ForEach-Object {
        $tag = $_ -replace 'refs/tags/', ''
        $nums = ($tag -replace '^v', '') -split '\.' | ForEach-Object { [int]$_ }

        [PSCustomObject]@{
            Tag   = $tag
            Major = $nums[0]
            Minor = $nums[1]
            Build = $nums[2]
            Rev   = $nums[3]
        }
    }

    if (-not $versions) {
        throw "No valid tags found"
    }

    # find highest major.minor
    $latest = $versions |
    Sort-Object Major, Minor -Descending |
    Select-Object -First 1

    $targetMajor = $latest.Major
    $targetMinor = $latest.Minor - 1

    # get latest tag from previous minor
    $result = $versions |
    Where-Object {
        $_.Major -eq $targetMajor -and
        $_.Minor -eq $targetMinor
    } |
    Sort-Object Build, Rev -Descending |
    Select-Object -First 1

    return "$result.Tag".Replace("v", "")
}
dispatch-workflow Get-PreviousMinorLatestTag

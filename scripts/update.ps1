function get-current-version
{
    $matched = Select-String -Path "./recipe.yaml" -Pattern '^  version: (\S+)'
    $v = $matched.Matches[0].Groups[1]
    $v = "$v".Replace("""", "")
    Write-Output $v
}

# Function: Get the latest release tag from a GitHub repository
function get-version-github
{
    param($repo)
    for ($i = 0; $i -lt 5; $i++)
    {
        $latest = gh release view -R $repo --json tagName -q .tagName
        $latest = "$latest".Replace("v", "")
        if ($latest)
        {
            return $latest
        }
    }
}
function get-version-conda-forge
{
    param($pkg)
    for ($i = 0; $i -lt 5; $i++)
    {
        $latest = curl -s "https://api.anaconda.org/package/conda-forge/$pkg" | jq -r '.latest_version'
        if ($latest)
        {
            return $latest
        }
    }
}
function get-version-crateio
{
    param($name)
    for ($i = 0; $i -lt 5; $i++)
    {
        $latest = curl -s -H "User-Agent: gh-actions-ci" https://crates.io/api/v1/crates/$name | jq -r '.crate.max_version'
        if ($latest)
        {
            return $latest
        }
    }
}
function get-version-winget
{
    param($name)
    gh api repos/microsoft/winget-pkgs/contents/manifests/$name | jq -r '[.[].name| select(test("^[0-9]+(\\.[0-9]+)*$"))]| sort_by(split(".") | map(tonumber))| last'
}
function get-version-url
{
    param($url, $pattern)
    for ($i = 0; $i -lt 5; $i++)
    {
        $html = curl -sL $url
        $versions = [regex]::Matches($html, $pattern) | `
                ForEach-Object { $_.Groups[1].Value }
        $latest = $versions | `
                Sort-Object { [version]$_ } -Descending | `
                Select-Object -First 1
        if ($latest)
        {
            return $latest
        }
    }
}
function get-version-text
{
    param($text, $pattern)

    $versions = [regex]::Matches($text, $pattern) | `
            ForEach-Object { $_.Groups[1].Value }
    $latest = $versions | `
            Sort-Object { [version]$_ } -Descending | `
            Select-Object -First 1
    return $latest
}

"| Package | Current Version | Latest Version | Status |" >> $env:GITHUB_STEP_SUMMARY
"|---|---|---|---|" >> $env:GITHUB_STEP_SUMMARY
# Input CSV
$csvFile = "$PSScriptRoot/../packages.csv"
# Output YAML
$yamlFile = "$PSScriptRoot/../packages.yaml"
Set-Content -Path $yamlFile -Value ""
# Read CSV
$csvData = Import-Csv $csvFile
ForEach ($Row in $csvData)
{
    $name=$Row.pkg
    Write-Output "::group::update $name"
    Set-Location "$PSScriptRoot/../packages/$name"
    $code = & yq -r '.extra.update' recipe.yaml
    $code = $code -replace "`r?`n", "`n"
    $latest_version = & ([ScriptBlock]::Create(($code -join "`n")))
    update-recipe $latest_version
    Write-Output "::endgroup::"
}

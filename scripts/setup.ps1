function get-current-version {
    $matched=Select-String -Path "./recipe.yaml" -Pattern '^  version: (\S+)'
    Write-Output $matched.Matches[0].Groups[1]
}
function get_latest_version {
    param($repo)
    gh release view -R $repo --json tagName -q .tagName
}
function update-recipe {
    param($version)
    Write-Output "::group::update recipe"
    (Get-Content -Path "./recipe.yaml") -replace '^  version: .*', "  version: $version" | Set-Content -Path "./recipe.yaml"
    Write-Output "::endgroup::"
}
function reset-build-code {
    (Get-Content -Path "./recipe.yaml") -replace '^  number: .*', "  number: 0" | Set-Content -Path "./recipe.yaml"
}

function build_pkg {
    Write-Output "::group::build"
    pixi run rattler-build build
    Write-Output "::endgroup::"
}

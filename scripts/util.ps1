function get-current-version {
    $matched = Select-String -Path "./recipe.yaml" -Pattern '^  version: (\S+)'
    Write-Output $matched.Matches[0].Groups[1]
}
function get-name {
    $matched = Select-String -Path "./recipe.yaml" -Pattern '^  name: (\w+\S+)'
    Write-Output $matched.Matches[0].Groups[1]
}

function get-latest-version {
    param($repo)
    gh release view -R $repo --json tagName -q .tagName
}
function update-recipe {

    param($cversion, $lversion)
    Write-Output "current version: $cversion"
    Write-Output "latest version: $lversion"
    if (($cversion -ne $lversion) -and ($lversion -ne '')) {
        Write-Output "::group::update recipe"
        (Get-Content -Path "./recipe.yaml") -replace '^  version: .*', "  version: $version" | Set-Content -Path "./recipe.yaml"
        (Get-Content -Path "./recipe.yaml") -replace '^  number: .*', "  number: 0" | Set-Content -Path "./recipe.yaml"
        if($env:CI){
            "update=true" >> $env:GITHUB_OUTPUT
            "latest-version=$lversion" >> $env:GITHUB_OUTPUT
        }
        Write-Output "::endgroup::"
    }
    
}
function reset-build-code {
    (Get-Content -Path "./recipe.yaml") -replace '^  number: .*', "  number: 0" | Set-Content -Path "./recipe.yaml"
}

function build-pkg {
    Write-Output "::group::build"
    pixi run rattler-build build
    Write-Output "::endgroup::"
}

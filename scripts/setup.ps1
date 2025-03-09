$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
if($env:CI){
    Install-Module powershell-yaml -AcceptLicense
}
Import-Module powershell-yaml

function get-current-version {
    # Define the path to the YAML file
    $yamlFilePath = "recipe.yaml"

    # Read the YAML content
    $yamlContent = Get-Content -Path $yamlFilePath -Raw

    # Convert the YAML content to a PowerShell object
    $yamlObject = $yamlContent | ConvertFrom-Yaml

    # Get the current version from the context
    $currentVersion = $yamlObject.context.version
    Write-Output "$currentVersion"
}
function get_latest_version {
    param($repo)
    gh release view -R $repo --json tagName -q .tagName
}
function update-recipe {
    param($version)
    Write-Output "::group::update recipe"
    # Define the path to the YAML file
    $yamlFilePath = "recipe.yaml"

    # Read the YAML content
    $yamlContent = Get-Content -Path $yamlFilePath -Raw

    # Convert the YAML content to a PowerShell object
    $yamlObject = $yamlContent | ConvertFrom-Yaml

    # Get the current version from the context
    $yamlObject.context.version = $version
    # Convert the updated object back to YAML
    $updatedYamlContent = $yamlObject | ConvertTo-Yaml

    # Write the updated YAML content back to the file
    Set-Content -Path "recipe.yaml" -Value $updatedYamlContent
    Write-Output "::endgroup::"
}
function build_pkg {
    Write-Output "::group::build"
    pixi run rattler-build build
    Write-Output "::endgroup::"
}
function test_pkg {
    Write-Output "::group::test"
    if ($IsWindows) {
        foreach ($conda_file in Get-ChildItem "./output/win-64/*.conda") {
            
            
            pixi run rattler-build test --package-file $conda_file
            
        }
    }
    Write-Output "::endgroup::"
}

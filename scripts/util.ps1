# Get the root directory of the current Git repository
$ROOT = git rev-parse --show-toplevel
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true
Remove-Item Alias:curl -ErrorAction SilentlyContinue

# avoid build error by long path
if ($IsWindows)
{
    # avoid build error by long path
    if ($env:CI)
    {
        $env:CARGO_TARGET_DIR = "c:/t"
        $env:CARGO_HOME = "c:/c"
        $env:PYTHONPATH="$(resolve-path $PSScriptRoot/..);$env:PYTHONPATH"
    }
}

function Get-Cargo-Arg
{
    $cargo_arg = @(
        '--root', "$env:PREFIX"
        '--locked'
        '--force'
        '--config', 'profile.release.debug=false'
        '--config', 'profile.release.codegen-units=1'
        '--config', 'profile.release.lto="fat"'
        '--config', 'profile.release.opt-level=3'
        '--config', 'profile.release.strip=true'
        '--config', 'rustflags=["target-cpu=x86-64-v3"]'
    )

    return $cargo_arg
}
function debug-recipe
{
    pixi run rattler-build debug setup --variant-config "$ROOT/conda_build_config.yaml"
}
function build-recipe
{
    if ($env:CI -and ($env:GITHUB_EVENT_NAME -eq "push"))
    { "action_publish=true" >> $env:GITHUB_OUTPUT
    }
    Write-Output "::group:: build $pkg"
    $rattler_build_args = @(
        "--config-file", "$ROOT/rattler-config.toml"
        "--color", "always"
        "build", "--output-dir", "$ROOT/output"
        "--variant-config", "$ROOT/conda_build_config.yaml"
        "--env-isolation", "none"
    )
    if ($env:CI -and ($env:TARGET_PLATFORM -ne "noarch"))
    {
        $rattler_build_args += ("--target-platform", "$env:TARGET_PLATFORM")
    }
    if (($env:GITHUB_EVENT_NAME -eq "push") -or ($env:GITHUB_EVENT_NAME -eq "workflow_dispatch"))
    {
        $rattler_build_args += ("--package-format", "conda:22")
    } else
    {
        $rattler_build_args += ("--package-format", "conda:-7")
    }
    pixi run rattler-build $rattler_build_args
    Write-Output "::endgroup::"
    foreach ($pkg_file in Get-ChildItem "$ROOT/output/$env:TARGET_PLATFORM/*.conda")
    {
        Write-Output "::group:: inspect $pkg"
        pixi run rattler-build package inspect --all $pkg_file
        Write-Output "::endgroup::"
    }
}

Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github "EdJoPaTo/$name"
update-recipe -version $latest_version

cargo install --git "https://github.com/EdJoPaTo/mqttui.git" --tag "v$latest_version" --root $ROOT/temp/$name --force

build-pkg

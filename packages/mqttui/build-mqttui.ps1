Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
build-cargo-package-github $name "https://github.com/EdJoPaTo/mqttui.git" "v$(get-current-version)"

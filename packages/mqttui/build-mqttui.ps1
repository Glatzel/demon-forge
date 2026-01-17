$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
build-cargo-package-github "https://github.com/EdJoPaTo/mqttui.git" "v${env:PKG_VERSION}"

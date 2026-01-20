$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
copy-item $PSScriptRoot/build/* ./ -recurse
get-content ./index.scss >> ./html/src/style/index.scss

# Download and install fonts
& ./download-font.ps1

# Handle npm and yarn tasks for front-end
$env:NPM_CONFIG_PREFIX = "$env:BUILD_PREFIX"
Set-Location ./html
npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate
yarn install
yarn run check
yarn run build
Set-Location ..
$cmakeArgs = @(
    "-G"
    "Ninja"
    "-DVERBOSE=ON"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=$env:PREFIX"
)
cmake -S . -B build @cmakeArgs
cmake --build build --config Release --target install

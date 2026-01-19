$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
copy-item $PSScriptRoot/build/* ./ -recurse
get-content ./index.scss >> ./html/src/style/index.scss

# Common CMake options
$cmakeArgs = @(
    "-G"
    "Ninja"
    "-DVERBOSE=ON"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=$env:PREFIX"
)

if ($IsWindows) {
    $env:NPM_CONFIG_PREFIX = "$env:BUILD_PREFIX"
  }  

# Download and install fonts
& ./download-font.ps1

# Handle npm and yarn tasks for front-end
Set-Location ./html
npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate
yarn install
yarn run check
yarn run build
Set-Location ..

if($IsWindows){& "C:\msys64\msys2_shell.cmd" -here -no-start -defterm -mingw64 -c "bash ./scripts/mingw-build.sh"}
else{
cmake -S . -B build @cmakeArgs
cmake --build build --config Release --target install
}

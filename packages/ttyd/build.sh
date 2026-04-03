ROOT=$(git rev-parse --show-toplevel)
source "$ROOT/scripts/util.sh"
cp -r "$RECIPE_DIR/../build/." ./
cat ./index.scss >> ./html/src/style/index.scss

# Download and install fonts
bash ./download-font.sh

# Handle npm and yarn tasks for front-end
export NPM_CONFIG_PREFIX="$BUILD_PREFIX"
cd ./html
npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate
yarn install
yarn run check
yarn run build
cd ..

cmake_args=(
    "-G" "Ninja"
    "-DVERBOSE=ON"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_INSTALL_PREFIX=$PREFIX"
)

if [ "$TARGET_PLATFORM" = "win-64" ]; then
    export BUILD_TARGET="win32"
    export CMAKE_C_FLAGS="-Wno-error"
    bash ./scripts/cross-build.sh
    mkdir -p "$PREFIX/bin"
    cp "./build/$PKG_NAME.exe" "$PREFIX/bin/$PKG_NAME.exe"
else
    cmake -S . -B build "${cmake_args[@]}"
    cmake --build build --config Release --target install
fi

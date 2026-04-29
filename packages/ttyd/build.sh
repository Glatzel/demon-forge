cat "${RECIPE_DIR}/index.scss" >> ./html/src/style/index.scss

# fonts
mkdir ./html/src/style/webfont
cp "${BUILD_PREFIX}/fonts/"* ./html/src/style/webfont/

# Handle npm and yarn tasks for front-end
cd ./html
# npm install -g corepack
# corepack enable
npx corepack prepare yarn@stable --activate
yarn install
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

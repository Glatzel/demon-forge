cat "${RECIPE_DIR}/index.scss" >> ./html/src/style/index.scss

# fonts
mkdir ./html/src/style/webfont
ls "${BUILD_PREFIX}/fonts"
cp "${BUILD_PREFIX}/fonts/*" ./html/src/style/webfont/

# Handle npm and yarn tasks for front-end
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

cmake -S . -B build "${cmake_args[@]}"
cmake --build build --config Release --target install

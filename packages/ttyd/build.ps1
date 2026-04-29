# Append SCSS
Get-Content "$env:RECIPE_DIR/index.scss" | Add-Content "./html/src/style/index.scss"

# fonts
New-Item -ItemType Directory -Force -Path "./html/src/style/webfont" | Out-Null

# Copy fonts (PowerShell handles globbing differently)
Copy-Item "$env:BUILD_PREFIX/fonts/*" -Destination "./html/src/style/webfont/" -ErrorAction Stop

# Frontend build
Set-Location ./html
Get-ChildItem -Path . -Recurse -File -Include *.js,*.ts,*.tsx,*.json,*.css,*.html |
    ForEach-Object {
        $path = $_.FullName
        $content = Get-Content $path -Raw

        # Normalize line endings
        $normalized = $content -replace "`r`n", "`n"

        # Only write if something changed (avoids touching timestamps unnecessarily)
        if ($normalized -ne $content)
        {
            Set-Content -Path $path -Value $normalized -NoNewline -Encoding utf8
        }
    }
$env:NPM_CONFIG_PREFIX="$env:BUILD_PREFIX"
npm install -g corepack
corepack enable
corepack prepare yarn@stable --activate

yarn install
yarn run check
yarn run build

Pop-Location

# CMake args
$cmake_args = @(
    "-G", "Ninja",
    "-DVERBOSE=ON",
    "-DCMAKE_BUILD_TYPE=Release",
    "-DCMAKE_INSTALL_PREFIX=$env:PREFIX"
)

cmake -S . -B build @cmake_args
cmake --build build --config Release --target install

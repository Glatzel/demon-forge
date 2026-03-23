new-item $env:PREFIX/etc/conda/activate.d -itemType Directory -Force -ErrorAction SilentlyContinue
copy-item $env:RECIPE_DIR/dnc-init.ps1 $env:PREFIX/etc/conda/activate.d/

tree
cp -r ./* "${PREFIX}/bin/codex"
cp -r "$RECIPE_DIR/unix/etc" "$PREFIX/"
mkdir "$PREFIX/codex-path/"
ln -sf ../bin/rg "$PREFIX/codex-path/rg"
# Pixi: prevent CONDA_PREFIX from leaking into sandboxed processes
mkdir -p "${PREFIX}/etc/pixi/codex"
touch "${PREFIX}/etc/pixi/codex/global-ignore-conda-prefix"

export CARGO_BUILD_JOBS=1
export CODEX_REPO_ROOT=$(pwd)
python scripts/build_codex_package.py \
    --target "$target" \
    --variant codex \
    --cargo-profile release \
    --package-dir "$PREFIX" \
    --force \
    --strip all \
    --strip-tool strip
cp -r "$RECIPE_DIR/unix/etc" "$PREFIX/"

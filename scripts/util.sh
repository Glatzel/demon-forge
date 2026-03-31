ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
export PYTHONPATH="$ROOT:$PYTHONPATH"
get_name() {
    if [ -n "$PKG_NAME" ]; then
        printf '%s\n' "$PKG_NAME"
    else
        sed -n 's/^  name: \(.*\)/\1/p' ./recipe.yaml | head -n 1
    fi
}
get_cargo_arg() {
    printf '%s\n' \
        --root "$PREFIX" \
        --locked \
        --force \
        --config profile.release.debug=false \
        --config profile.release.codegen-units=1 \
        --config 'profile.release.lto="fat"' \
        --config profile.release.opt-level=3 \
        --config profile.release.strip=true
}

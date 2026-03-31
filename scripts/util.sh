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

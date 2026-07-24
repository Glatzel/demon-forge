case "$(uname -s)-$(uname -m)" in
    Darwin-arm64)
        # Apple Silicon
        RUSTC_EXTRA_ARGS=(-- -C target-cpu=apple-m1)
        ;;

    Linux-x86_64)
        # Modern Linux x64 servers/desktops
        RUSTC_EXTRA_ARGS=(-- -C target-cpu=x86-64-v3)
        ;;

    *)
        RUSTC_EXTRA_ARGS=()
        ;;
esac

get_cargo_arg() {
    printf '%s\n' \
        --root "$PREFIX" \
        --locked \
        --force \
        --config profile.release.debug=false \
        --config profile.release.codegen-units=1 \
        --config 'profile.release.lto="fat"' \
        --config profile.release.opt-level=3 \
        --config profile.release.strip=true \
        "${RUSTC_EXTRA_ARGS[@]}"
}
build_recipe() {
    if [ -n "$CI" ] && [ "$GITHUB_EVENT_NAME" = "push" ]; then
        echo "action_publish=true" >> "$GITHUB_OUTPUT"
    fi
    ROOT=$(git rev-parse --show-toplevel)
    echo "::group:: build $pkg"
    set -- \
        --config-file "$ROOT/rattler-config.toml" \
        --color always \
        build --output-dir "$ROOT/output" \
        --variant-config "$ROOT/conda_build_config.yaml" \
        --env-isolation none

    if [ -n "$CI" ] && [ "$TARGET_PLATFORM" != "noarch" ]; then
        set -- "$@" --target-platform "$TARGET_PLATFORM"
    fi

    if [ "$GITHUB_EVENT_NAME" = "push" ] || [ "$GITHUB_EVENT_NAME" = "workflow_dispatch" ] ; then
        set -- "$@" --package-format conda:22
    else
        set -- "$@" --package-format conda:-7
    fi

    pixi run rattler-build "$@"

    echo "::endgroup::"

    for pkg_file in "$ROOT/output/$TARGET_PLATFORM/"*.conda; do
        [ -e "$pkg_file" ] || continue

        echo "::group:: inspect $pkg"
        pixi run rattler-build package inspect --all "$pkg_file"
        echo "::endgroup::"
    done
}

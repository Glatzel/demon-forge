pkg="$1"

cd "$(dirname "$0")"
cd ..

if ! ls "./output/$TARGET_PLATFORM/"*.conda >/dev/null 2>&1; then
    echo "The specified path was not found: ./output/$TARGET_PLATFORM/*.conda" >&2
    exit 1
fi

for pkg_file in "./output/$TARGET_PLATFORM/"*.conda; do
    echo "::group:: upload $pkg"
    pixi run rattler-build upload prefix -s -c glatzel --generate-attestation "$pkg_file"
    echo "::endgroup::"
done

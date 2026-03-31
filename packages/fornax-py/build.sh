set -e
export LIBRAW_ROOT="$BUILD_PREFIX"
cd crates/fornax-py
pixi run maturin build --out dist --profile release
for whl in dist/*.whl; do
    pip install "$whl" -v
done

cd python
pixi run maturin build --out ./dist --profile release
for whl in dist/*.whl; do
    pip install "$whl" -v
done

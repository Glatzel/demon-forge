mkdir -f "$PREFIX/csharpier"
dotnet tool install csharpier --tool-path "$PREFIX/csharpier"

tee ${PREFIX}/bin/csharpier << EOF
#!/bin/sh
exec \${DOTNET_ROOT}/dotnet exec \${CONDA_PREFIX}/csharpier/CSharpier.dll "\$@"
EOF
chmod +x ${PREFIX}/bin/csharpier
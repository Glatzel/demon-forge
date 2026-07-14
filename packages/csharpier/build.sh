rm -rf global.json
rm -rf .config/dotnet-tools.json
framework_version="$(dotnet --version | sed -e 's/\..*//g').0"
dotnet publish --no-self-contained Src/CSharpier.Cli/CSharpier.Cli.csproj --output ${PREFIX}/${PKG_NAME} \
    --framework net${framework_version} -p:TreatWarningAsErrors=false
rm ${PREFIX}/${PKG_NAME}/CSharpier

tee ${PREFIX}/bin/csharpier << EOF
#!/bin/sh
exec \${DOTNET_ROOT}/dotnet exec \${CONDA_PREFIX}/csharpier/CSharpier.dll "\$@"
EOF
chmod +x ${PREFIX}/bin/csharpier

tee ${PREFIX}/bin/dotnet-csharpier.cmd << EOF
call %DOTNET_ROOT%\dotnet exec %CONDA_PREFIX\csharpier\CSharpier.dll %*
EOF
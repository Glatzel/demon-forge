New-Item $env:PREFIX/csharpier -ItemType Directory
dotnet tool install csharpier --tool-path $env:PREFIX/csharpier
New-Item $env:PREFIX/bin -ItemType Directory
'call %DOTNET_ROOT%\dotnet exec %CONDA_PREFIX\csharpier\CSharpier.dll %*/' > $env:PREFIX/bin/csharpier.bat

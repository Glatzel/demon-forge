New-Item $env:PREFIX/bin -ItemType Directory
Copy-Item ./duckdb.exe $env:PREFIX/bin

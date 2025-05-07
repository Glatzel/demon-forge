Set-Location $PSScriptRoot/..
ruff format --exit-non-zero-on-format
ruff check --fix --show-fixes --exit-non-zero-on-fix

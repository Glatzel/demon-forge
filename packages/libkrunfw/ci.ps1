Set-Location $PSScriptRoot
$ROOT = git rev-parse --show-toplevel
. $ROOT/scripts/util.ps1
$latest_version = get-version-github -repo "containers/libkrunfw"
gh repo clone containers/libkrunfw
cd libkrunfw
sudo apt-get update
sudo apt-get install -y make gcc bc bison flex elfutils python3-pyelftools curl patch libelf-dev
make
make install

# dispatch-workflow $latest_version

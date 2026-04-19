ROOT=$(git rev-parse --show-toplevel)
. "$ROOT/scripts/util.sh"
OS="$(uname -s)"

if [ "$OS" = "Linux" ]; then
    sudo dnf update -y
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --set-enabled powertools
    sudo dnf makecache
    sudo dnf install -y libsmbclient-devel
    export PKG_CONFIG_PATH="/usr/share/pkgconfig:/usr/lib/pkgconfig:/usr/lib64/pkgconfig:${PKG_CONFIG_PATH}"
fi

if [ "$OS" = "Darwin" ]; then
    brew install samba
    brewPrefix="$(brew --prefix)"
    export PKG_CONFIG_PATH="$brewPrefix/share/pkgconfig:$brewPrefix/lib/pkgconfig:${PKG_CONFIG_PATH}"
fi

set -- $(get_cargo_arg)
cargo install "$PKG_NAME" "$@"

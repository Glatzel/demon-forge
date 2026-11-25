#!/usr/bin/env bash
set -euo pipefail

DOWNLOAD_BASE_URL="https://antigravity-cli-auto-updater-974169037036.us-central1.run.app"

case "${TARGET_PLATFORM:-}" in
    linux-64)
        PLATFORM="linux_amd64"
        ;;
    linux-aarch64)
        PLATFORM="linux_arm64"
        ;;
    *)
        echo "Unsupported platform: ${TARGET_PLATFORM:-unknown}" >&2
        exit 1
        ;;
esac

MANIFEST_URL="${DOWNLOAD_BASE_URL}/manifests/${PLATFORM}.json"
MANIFEST_JSON="$(curl -fsSL "${MANIFEST_URL}")"

URL="$(printf '%s' "${MANIFEST_JSON}" | jq -r '.url')"
SHA512="$(printf '%s' "${MANIFEST_JSON}" | jq -r '.sha512')"

if [ -z "${URL}" ] || [ "${URL}" = "null" ] || [ -z "${SHA512}" ] || [ "${SHA512}" = "null" ]; then
    echo "Failed to parse manifest from ${MANIFEST_URL}" >&2
    exit 1
fi

mkdir -p "${PREFIX}/bin"

case "${URL}" in
    *.tar.gz*)
        curl -fsSL "${URL}" -o "./agy.tar.gz"
        echo "${SHA512}  ./agy.tar.gz" | sha512sum -c -
        tar -xzf "./agy.tar.gz" -C "." antigravity
        install -m 755 "./antigravity" "${PREFIX}/bin/agy"
        ;;
    *)
        curl -fsSL "${URL}" -o "./agy"
        echo "${SHA512}  ./agy" | sha512sum -c -
        install -m 755 "./agy" "${PREFIX}/bin/agy"
        ;;
esac

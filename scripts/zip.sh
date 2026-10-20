#!/bin/sh
# Builds the upload ZIP for one platform folder: scripts/zip.sh chatgpt
# Output: dist/lipi-<platform>-plugin.zip, files at the ZIP root as the portals expect.
set -eu

platform="${1:?usage: scripts/zip.sh <platform>}"
root="$(cd "$(dirname "$0")/.." && pwd)"
src="$root/$platform"
out="$root/dist/lipi-$platform-plugin.zip"

[ -d "$src" ] || { echo "No folder $platform/" >&2; exit 1; }
[ -f "$src/plugin.json" ] && python3 -m json.tool "$src/plugin.json" >/dev/null

mkdir -p "$root/dist"
rm -f "$out"
(cd "$src" && zip -qrX "$out" . -x '.*' -x '*/.*')
echo "$out"

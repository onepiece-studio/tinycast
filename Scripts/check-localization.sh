#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
if [ "${1:-}" != "--sources" ]; then
    exec ./Scripts/run-tests.sh localization-test
fi
shift
node Scripts/check-localization.js
node --test Tests/localization-sync-test.js
scratch=$(mktemp -d "${TMPDIR:-/tmp}/tinycast-localization.XXXXXX")
trap 'rm -rf "$scratch"' EXIT
app="$scratch/Localization.app/Contents"
mkdir -p "$app/Resources" "$app/MacOS"
for catalog in Tinycast/Resources/*.xcstrings Tinycast/Features/Extensions/Resources/*.xcstrings; do
    xcrun xcstringstool compile "$catalog" --output-directory "$app/Resources"
done
cp Tinycast/Info.plist "$app/Info.plist"
plutil -replace CFBundleExecutable -string localization-test "$app/Info.plist"
plutil -replace CFBundleIdentifier -string com.tinycast.localization-test "$app/Info.plist"
swiftc -swift-version 6 "$@" Tests/localization-test.swift -o "$app/MacOS/localization-test"
"$app/MacOS/localization-test" -AppleLanguages '(en)'
"$app/MacOS/localization-test" -AppleLanguages '(zh-Hans)' zh-Hans
"$app/MacOS/localization-test" -AppleLanguages '(ja)'

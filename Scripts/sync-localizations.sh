#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
if [ "$#" -ne 1 ]; then
    echo 'Usage: ./Scripts/sync-localizations.sh <DerivedData directory from a Debug build>' >&2
    exit 2
fi
strings_data="$1/Build/Intermediates.noindex/Tinycast.build/Debug/Tinycast.build"
files=()
while IFS= read -r file; do files+=("$file"); done < <(find "$strings_data" -name '*.stringsdata' -type f)
if [ "${#files[@]}" -eq 0 ]; then
    echo 'Build Tinycast in Debug with SWIFT_EMIT_LOC_STRINGS=YES first.' >&2
    exit 1
fi
xcrun xcstringstool sync Tinycast/Resources/Localizable.xcstrings \
    Tinycast/Features/Extensions/Resources/Extensions.xcstrings \
    --stringsdata "${files[@]}"

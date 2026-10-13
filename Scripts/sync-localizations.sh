#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
check=0
if [ "${1:-}" = "--check" ]; then
    check=1
    shift
fi
if [ "$#" -ne 1 ]; then
    echo 'Usage: ./Scripts/sync-localizations.sh [--check] <DerivedData directory from a fresh Debug build>' >&2
    exit 2
fi
strings_data="$1/Build/Intermediates.noindex/Tinycast.build/Debug/Tinycast.build"
if [ ! -d "$strings_data" ]; then
    echo 'Build Tinycast in Debug with SWIFT_EMIT_LOC_STRINGS=YES first.' >&2
    exit 1
fi
files=()
while IFS= read -r file; do files+=("$file"); done < <(find "$strings_data" -name '*.stringsdata' -type f)
if [ "${#files[@]}" -eq 0 ]; then
    echo 'Build Tinycast in Debug with SWIFT_EMIT_LOC_STRINGS=YES first.' >&2
    exit 1
fi
catalogs=(Tinycast/Resources/Localizable.xcstrings Tinycast/Features/Extensions/Resources/Extensions.xcstrings)
if [ "$check" -eq 0 ]; then
    xcrun xcstringstool sync "${catalogs[@]}" --stringsdata "${files[@]}"
    exit 0
fi

scratch=$(mktemp -d "${TMPDIR:-/tmp}/tinycast-catalog-sync.XXXXXX")
trap 'rm -rf "$scratch"' EXIT
copies=()
for catalog in "${catalogs[@]}"; do
    copy="$scratch/$(basename "$catalog")"
    cp "$catalog" "$copy"
    copies+=("$copy")
done
xcrun xcstringstool sync "${copies[@]}" --stringsdata "${files[@]}"
node - "${catalogs[0]}" "${copies[0]}" "${catalogs[1]}" "${copies[1]}" <<'JS'
const fs = require("node:fs");
function canonical(value) {
  if (Array.isArray(value)) return value.map(canonical);
  if (value && typeof value === "object") {
    return Object.fromEntries(Object.keys(value).sort().map((key) => [key, canonical(value[key])]));
  }
  return value;
}
const files = process.argv.slice(2);
let changed = false;
for (let index = 0; index < files.length; index += 2) {
  const [original, synchronized] = files.slice(index, index + 2);
  const before = JSON.parse(fs.readFileSync(original, "utf8"));
  const after = JSON.parse(fs.readFileSync(synchronized, "utf8"));
  if (JSON.stringify(canonical(before)) === JSON.stringify(canonical(after))) continue;
  changed = true;
  for (const key of new Set([...Object.keys(before.strings), ...Object.keys(after.strings)])) {
    if (JSON.stringify(canonical(before.strings[key])) === JSON.stringify(canonical(after.strings[key]))) continue;
    const reason = !before.strings[key] ? "new" : !after.strings[key] ? "removed"
      : after.strings[key].extractionState === "stale" ? "stale" : "changed";
    console.error(`${original}: ${reason} entry: ${key}`);
  }
}
if (changed) {
  console.error("Catalogs differ from compiler extraction. Synchronize and review translations before committing.");
  process.exit(1);
}
console.log("Localization catalogs match compiler extraction.");
JS

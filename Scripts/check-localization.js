#!/usr/bin/env node
"use strict";

const fs = require("node:fs");
const path = require("node:path");
const root = path.join(__dirname, "..");
const catalogs = [
  "Tinycast/Resources/Localizable.xcstrings",
  "Tinycast/Resources/InfoPlist.xcstrings",
  "Tinycast/Features/Extensions/Resources/Extensions.xcstrings",
];
const problems = [];
function argumentsIn(value) {
  let next = 1;
  return [...value.matchAll(/%%|%(?:(\d+)\$)?[-+#0 ]*(?:\d+)?(?:\.\d+)?(lld|llu|ld|lu|zd|zu|@|d|u|f|g|s)/g)]
    .filter((match) => match[0] !== "%%")
    .map((match) => `${match[1] || next++}:${match[2]}`).sort().join(",");
}
function units(value) {
  if (!value || typeof value !== "object") return [];
  if (value.stringUnit) return [value.stringUnit];
  return Object.values(value).flatMap(units);
}
let count = 0;
for (const file of catalogs) {
  const catalog = JSON.parse(fs.readFileSync(path.join(root, file), "utf8"));
  if (catalog.sourceLanguage !== "en") problems.push(`${file}: source language must be en`);
  for (const [key, entry] of Object.entries(catalog.strings)) {
    if (entry.extractionState === "stale") problems.push(`${file}: stale key ${key}`);
    if (entry.shouldTranslate === false) continue;
    const translated = units(entry.localizations?.["zh-Hans"]);
    const source = entry.localizations?.en?.stringUnit?.value ?? key;
    if (!translated.length) problems.push(`${file}: missing Chinese: ${key}`);
    for (const unit of translated) {
      if (unit.state !== "translated" || !unit.value) problems.push(`${file}: unfinished Chinese: ${key}`);
      if (argumentsIn(source) !== argumentsIn(unit.value)) problems.push(`${file}: format arguments differ: ${key}`);
    }
    if (entry.localizations?.en?.variations?.plural) {
      const plural = entry.localizations.en.variations.plural;
      if (!plural.one || !plural.other) problems.push(`${file}: English plurals need one and other: ${key}`);
    }
    count++;
  }
}
const plist = fs.readFileSync(path.join(root, "Tinycast/Info.plist"), "utf8");
const info = JSON.parse(fs.readFileSync(path.join(root, catalogs[1]), "utf8"));
for (const [, key] of plist.matchAll(/<key>(\w+UsageDescription)<\/key>/g)) {
  if (!info.strings[key]?.localizations?.["zh-Hans"]) problems.push(`Missing permission translation: ${key}`);
}
if (problems.length) {
  console.error(problems.join("\n"));
  process.exit(1);
}
console.log(`Localization: ${count} translated entries across ${catalogs.length} catalogs.`);

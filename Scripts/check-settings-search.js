#!/usr/bin/env node
"use strict";

const fs = require("node:fs");
const path = require("node:path");
const root = path.join(__dirname, "..");
const read = (name) => fs.readFileSync(path.join(root, name), "utf8");
function sources(folder) {
  return fs.readdirSync(folder, { withFileTypes: true }).flatMap((entry) => {
    const file = path.join(folder, entry.name);
    return entry.isDirectory() ? sources(file) : file.endsWith(".swift") ? [file] : [];
  });
}
const source = sources(path.join(root, "Tinycast"))
  .filter((file) => !file.endsWith("SettingsSearchCatalog.swift"))
  .map((file) => fs.readFileSync(file, "utf8")).join("\n");
const catalog = read("Tinycast/Features/Settings/SettingsSearchCatalog.swift");
const rows = read("Tinycast/Features/Settings/SettingsRowID.swift");
const problems = [];
const declared = new Set([...rows.matchAll(/^    case (\w+)$/gm)].map((match) => match[1]));
for (const [, row] of catalog.matchAll(/\.init\(\s*\.(\w+)/g)) {
  if (!declared.has(row)) problems.push(`Unknown row: ${row}`);
  if (!source.includes(`SettingsRowTitle(.${row})`) &&
      !new RegExp(`row: \\.${row}\\b`).test(source) &&
      !new RegExp(`(?:case \\.\\w+|default): \\.${row}\\b`).test(source)) {
    problems.push(`No view marks row: ${row}`);
  }
}
for (const [, anchor] of catalog.matchAll(/\.init\(\s*group: \.(\w+)/g)) {
  if (!source.includes(`SettingsSectionHeader(.${anchor})`) &&
      !source.includes(`SettingsSectionHeader(anchor: .${anchor})`) &&
      !source.includes(`settingsAnchor(.${anchor})`) &&
      !source.includes(`anchor: .${anchor}`)) {
    problems.push(`No section marks anchor: ${anchor}`);
  }
}
if (problems.length) {
  console.error(problems.join("\n"));
  process.exit(1);
}

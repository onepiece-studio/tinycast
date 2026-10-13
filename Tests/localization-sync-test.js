const assert = require("node:assert/strict");
const fs = require("node:fs");
const os = require("node:os");
const path = require("node:path");
const { spawnSync } = require("node:child_process");
const { test } = require("node:test");

const project = path.resolve(__dirname, "..");

test("catalog freshness checks reject drift without rewriting translations", () => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "tinycast-localization-sync-"));
  try {
    fs.mkdirSync(path.join(root, "Scripts"), { recursive: true });
    const script = path.join(root, "Scripts/sync-localizations.sh");
    fs.copyFileSync(path.join(project, "Scripts/sync-localizations.sh"), script);
    const catalogs = ["Tinycast/Resources/Localizable.xcstrings", "Tinycast/Features/Extensions/Resources/Extensions.xcstrings"];
    for (const [index, file] of catalogs.entries()) {
      fs.mkdirSync(path.dirname(path.join(root, file)), { recursive: true });
      fs.writeFileSync(path.join(root, file), JSON.stringify({
        sourceLanguage: "en", version: "1.0", strings: index ? {} : {
          Existing: { localizations: { "zh-Hans": { stringUnit: { state: "translated", value: "已有文案" } } } },
        },
      }));
    }
    const derived = path.join(root, "DerivedData");
    const dataDir = path.join(derived, "Build/Intermediates.noindex/Tinycast.build/Debug/Tinycast.build/Objects-normal/arm64");
    fs.mkdirSync(dataDir, { recursive: true });
    const extracted = { version: 1, source: path.join(root, "Example.swift"), tables: {
      Localizable: [{ key: "Existing", comment: "", location: { startingLine: 1, startingColumn: 1 } }],
    } };
    const writeExtraction = () => fs.writeFileSync(path.join(dataDir, "Example.stringsdata"), JSON.stringify(extracted));
    const run = (...args) => spawnSync("/bin/bash", [script, ...args, derived], { encoding: "utf8" });
    const snapshot = () => catalogs.map((file) => fs.readFileSync(path.join(root, file), "utf8"));
    writeExtraction();
    const synced = run();
    assert.equal(synced.status, 0, synced.stderr);
    const before = snapshot();
    const clean = run("--check");
    assert.equal(clean.status, 0, clean.stderr);
    assert.deepEqual(snapshot(), before);

    extracted.tables.Localizable.push({ key: "New upstream label", comment: "", location: { startingLine: 1, startingColumn: 20 } });
    writeExtraction();
    const added = run("--check");
    assert.equal(added.status, 1);
    assert.match(added.stderr, /new entry: New upstream label/);
    assert.deepEqual(snapshot(), before);

    extracted.tables.Localizable = [];
    writeExtraction();
    const stale = run("--check");
    assert.equal(stale.status, 1);
    assert.match(stale.stderr, /stale entry: Existing/);
    assert.deepEqual(snapshot(), before);

    extracted.tables.Localizable = [{ key: "Existing", value: "Updated English", comment: "" }];
    writeExtraction();
    const updated = run("--check");
    assert.equal(updated.status, 1);
    assert.match(updated.stderr, /changed entry: Existing/);
    assert.deepEqual(snapshot(), before);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

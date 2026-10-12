# Localization

English (`en`) is the source language. Simplified Chinese (`zh-Hans`) is the first translation.
macOS selects the app language from its language preferences, including the per-app override in
System Settings. Quit and reopen Tinycast after changing that override. If macOS cannot match a
preferred language to a supported localization, it falls back to English. There is no Tinycast
language preference or runtime language manager.

## Invariants

- Localization changes presentation, never command IDs, enum raw values, settings keys, backup
  formats, search aliases, calculator syntax, or user-authored content.
- `Model/` never resolves a translation. Display-only properties and `LocalizedError` conformances
  live in feature-owned presentation extensions under `Service/`. Pure messages that cross the
  boundary, such as calculator failures, use Foundation's `String.LocalizationValue` and resolve
  where they are displayed.
- Built-in launcher commands display localized names and retain English search aliases. Application
  names still use `BundleLocalization`; that scanner does not translate Tinycast's own interface.
- Settings identities are `SettingsTab`, `SettingsAnchor`, and `SettingsRowID`. Search, scroll targets
  and highlights share those values. Neither English nor translated titles identify a row.
- External strings remain literal: user names, clipboard and note content, extension-provided text,
  provider error details, paths, and protocol values. Extensions' host-owned strings use their own
  table; passing extension text into a generic translation lookup is forbidden.
- Language and region are independent. Number formatting, dates, input parsing, transcription and
  translation targets retain their existing preferences.

## Resources and APIs

| Catalog | Owns |
| --- | --- |
| `Tinycast/Resources/Localizable.xcstrings` | Tinycast interface and shared presentation |
| `Tinycast/Resources/InfoPlist.xcstrings` | System permission explanations |
| `Tinycast/Features/Extensions/Resources/Extensions.xcstrings` | Extension host presentation |

Use SwiftUI's literal initializers (`Text("Settings")`, `Button("Save")`). Use
`String(localized:)` for AppKit and values handed to String-based custom views. A `String` variable
passed to `Text` is already display text; it does not become a localization key automatically.
`LocalizedStringResource` carries delayed labels such as Settings titles. Keep complete sentences
and their interpolated values together; catalogs own plural forms. For an ambiguous English word,
use a contextual key with an English default and a translator comment.

Calculator messages carry localization values without consulting a bundle in the parser. The
calculator's presentation maps its controlled badge vocabulary and currency names; formatted dates
and unrecognized technical labels remain literal. Expression and copy text are untouched.

Brands, protocol examples, and purely symbolic formats may use `shouldTranslate: false`. Permission
keys have manual extraction state because Swift compiler output does not include Info.plist.
Xcode also extracts bundle metadata during builds: bundle names and copyright stay nontranslatable,
while the backup document type has its own translation.
Generated source files and resource packs remain owned by their existing generators.

## Updating translations

1. Add or change English text at the call site and build Debug with the project settings.
2. In Xcode, inspect the String Catalog updates; with command-line builds, synchronize explicitly:

   ```sh
   xcodebuild -project Tinycast.xcodeproj -scheme Tinycast -configuration Debug \
     -derivedDataPath /tmp/tinycast-localization-build CODE_SIGNING_ALLOWED=NO build
   ./Scripts/sync-localizations.sh /tmp/tinycast-localization-build
   ```

3. Translate new entries, review changed text, remove stale entries after checking their callers,
   and review English `one`/`other` variants for counts. Keep format argument types and positions.
4. Run `./Scripts/check-localization.sh`. It compiles the catalogs into an isolated temporary app
   and launches its harness in English, Simplified Chinese and an unsupported language. It checks
   bundle selection, fallback, permissions, search identity, bilingual search and plural formatting.
5. Run the full suite, lint and Debug build. Inspect real screens in both languages, both appearances
   and each interface size, especially the shortcut recorder, dialogs and menu-bar surfaces.

The localization harness is part of `run-tests.sh`; the catalog checker is part of `lint.sh`.
Harnesses that include a model also include its matching `Service/*Presentation.swift`, if present,
so tests of existing labels and errors still compile the shipped implementation.

The initial Chinese translation was reconciled from the sibling `tinycast-cn` project against this
checkout's extracted English keys. That checkout is not a build, test or runtime dependency.

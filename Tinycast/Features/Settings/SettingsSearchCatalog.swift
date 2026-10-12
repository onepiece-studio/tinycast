import Foundation

/// One searchable place in Settings: a pane, or a row inside one of its `Form` sections.
struct SettingsSearchEntry: Identifiable, Hashable, Sendable {
    let tab: SettingsTab
    /// Where picking this result lands; nil for the pane itself, which is its own result.
    let target: SettingsTarget?
    let title: String
    /// Words a user might type that the visible title doesn't contain.
    let keywords: [String]

    let englishTitle: String

    init(_ row: SettingsRowID, keywords: [String] = []) {
        self.tab = row.anchor.tab
        self.target = .row(row)
        self.title = row.title
        self.englishTitle = row.titleResource.key
        self.keywords = keywords
    }

    init(group anchor: SettingsAnchor, _ title: LocalizedStringResource, keywords: [String] = []) {
        self.tab = anchor.tab
        self.target = .section(anchor)
        self.title = String(localized: title)
        self.englishTitle = title.key
        self.keywords = keywords
    }

    init(pane: SettingsTab, keywords: [String] = []) {
        self.tab = pane
        self.target = nil
        self.title = pane.title
        self.englishTitle = pane.titleResource.key
        self.keywords = keywords
    }

    var anchor: SettingsAnchor? { target?.anchor }

    var id: String {
        switch target {
        case .row(let row): "row/\(row.rawValue)"
        case .item(let anchor, let id): "item/\(anchor.rawValue)/\(id)"
        case .section(let anchor): "section/\(anchor.rawValue)"
        case nil: "pane/\(tab.rawValue)"
        }
    }

    var breadcrumb: String {
        guard let anchor, anchor.title != tab.title else { return tab.title }
        return "\(tab.title) › \(anchor.title)"
    }

    var englishBreadcrumb: String {
        guard let anchor else { return tab.titleResource.key }
        return "\(tab.titleResource.key) › \(anchor.titleResource.key)"
    }
}

/// What Settings offers to search. Hand-written: a `Form` can't be asked what rows it holds, so a
/// new row is searchable only once it is listed here.
enum SettingsSearchCatalog {
    struct Query: Sendable {
        let terms: [FuzzyMatch.Query]

        init(_ raw: String) {
            terms = raw.split(whereSeparator: \Character.isWhitespace).map {
                FuzzyMatch.Query(String($0))
            }
        }

        var isEmpty: Bool { terms.isEmpty }
    }

    static func results(for raw: String, limit: Int = 50) -> [SettingsSearchEntry] {
        let query = Query(raw)
        guard !query.isEmpty else { return [] }
        // Catalog order is the tie-break, so results don't reshuffle between equal-scoring rows.
        return
            entries
            .enumerated()
            .compactMap { item -> (entry: SettingsSearchEntry, score: Int, rank: Int)? in
                guard let score = score(query, item.element) else { return nil }
                return (item.element, score, item.offset)
            }
            .sorted { $0.score != $1.score ? $0.score > $1.score : $0.rank < $1.rank }
            .prefix(limit)
            .map(\.entry)
    }

    /// Every term must land somewhere; a term matched in the title outranks one found off it.
    private static func score(_ query: Query, _ entry: SettingsSearchEntry) -> Int? {
        var titleScore = 0
        var titleMatches = 0
        for term in query.terms {
            if let match = [entry.title, entry.englishTitle]
                .compactMap({ FuzzyMatch.match(term, candidate: $0) })
                .max(by: { $0.score < $1.score })
            {
                titleMatches += 1
                titleScore += match.score
                continue
            }
            guard
                entry.keywords.contains(where: { FuzzyMatch.match(term, candidate: $0) != nil })
                    || FuzzyMatch.match(term, candidate: entry.breadcrumb) != nil
                    || FuzzyMatch.match(term, candidate: entry.englishBreadcrumb) != nil
            else { return nil }
        }

        let band: Int
        if titleMatches == query.terms.count {
            band = 2_000_000
        } else if titleMatches > 0 {
            band = 1_000_000
        } else {
            band = 0
        }
        // A pane outranks its own rows, so a bare "clipboard" lands on the pane rather than a row.
        return band + titleScore + (entry.anchor == nil ? 500_000 : 0)
    }

    // MARK: - The index
    // Pane order, then section order within a pane, so this reads as a table of contents.

    static let entries: [SettingsSearchEntry] =
        general + applications + systemSettings + systemActions + commands + quicklinks
        + appleShortcuts + fallbacks + clipboard + snippets + fileSearch + windowManagement
        + navigation + notes + calendar + emoji + ai + quickActions + dictation + extensions + permissions
        + backup + about

    private static let general: [SettingsSearchEntry] = [
        .init(pane: .general, keywords: ["preferences", "settings"]),
        .init(
            .generalGlobalShortcutsAppLauncher,
            keywords: ["hotkey", "shortcut", "summon", "palette"]),
        .init(
            .generalGeneralLaunchAtLogin,
            keywords: ["startup", "login item", "start", "boot", "开机", "自启动"]),
        .init(
            .generalGeneralShowInMenuBar,
            keywords: ["menubar", "status item", "icon", "hide"]),
        .init(
            .generalGeneralAutomaticallyCheckForUpdates,
            keywords: ["software", "update", "automatic", "disable", "popup"]),
        .init(
            .generalGeneralPopToRootSearch,
            keywords: ["reset", "timeout", "back"]),
        .init(
            .generalGeneralEscapeKeyBehavior,
            keywords: ["escape", "esc", "back", "close", "navigate"]),
        .init(
            .generalGeneralAutoSwitchInputSource,
            keywords: ["keyboard", "layout", "language", "abc"]),
        .init(
            .generalAppearanceTheme,
            keywords: ["dark", "light", "mode", "appearance"]),
        .init(
            .generalAppearanceInterfaceSize,
            keywords: ["text size", "font size", "scale", "zoom", "bigger", "larger", "legible"]),
        .init(
            .generalAppearanceWindowMode,
            keywords: ["compact", "expanded", "slim", "search bar", "small"]),
        .init(
            .generalAppearanceShowFavoritesInCompactMode,
            keywords: ["pinned", "apps", "compact"]),
        .init(
            .generalAppearanceFollowTheCursorAcrossDisplays,
            keywords: ["monitor", "screen", "pointer", "multi display"]),
        .init(
            .generalAppearanceDragToReposition,
            keywords: ["move", "position", "window"]),
        .init(
            .generalHyperKeyHyperKey,
            keywords: ["modifier", "remap", "caps lock", "capslock"]),
        .init(
            .generalHyperKeyQuickPress,
            keywords: ["tap", "escape", "single press"]),
        .init(
            .generalHyperKeyIncludeShift,
            keywords: ["modifier", "chord"]),
        .init(
            .generalHyperKeySecureInputCompatibility,
            keywords: ["password", "secure input", "right control"]),
        .init(
            .generalCalculatorNumberFormat,
            keywords: ["decimal", "comma", "separator", "locale", "region", "thousands"]),
        .init(
            .generalSearchShowSuggestions,
            keywords: ["frequent", "recent", "recommended", "empty", "root search"]),
        .init(
            .generalSearchSearchSensitivity,
            keywords: ["fuzzy", "strict", "loose", "matching", "typo", "root search"]),
        .init(
            .generalSearchLearnedRanking,
            keywords: ["reset", "history", "order", "privacy"])
    ]

    private static let applications: [SettingsSearchEntry] = [
        .init(pane: .applications, keywords: ["apps", "index", "launcher"]),
        .init(
            .applicationsApplicationsEnableApplications,
            keywords: ["hide apps", "visibility"]),
        .init(
            group: .applicationsSearchScopes, "Search Scopes",
            keywords: ["folders", "indexed", "locations", "add folder"]),
        .init(
            group: .applicationsApplications, "Aliases and shortcuts",
            keywords: ["alias", "hotkey", "per app", "hide"])
    ]

    private static let systemSettings: [SettingsSearchEntry] = [
        .init(
            pane: .systemSettings,
            keywords: ["panes", "preferences", "macos"]),
        .init(
            .systemSettingsSystemSettingsEnableSystemSettings,
            keywords: ["hide panes", "visibility"])
    ]

    private static let systemActions: [SettingsSearchEntry] = [
        .init(
            pane: .systemActions,
            keywords: ["sleep", "lock", "restart", "shut down", "empty trash"]),
        .init(
            .systemActionsSystemActionsEnableSystemActions,
            keywords: ["hide", "visibility"])
    ]

    private static let commands: [SettingsSearchEntry] = [
        .init(
            pane: .commands,
            keywords: ["custom", "script", "shell", "terminal"]),
        .init(
            .commandsCommandsEnableCommands,
            keywords: ["hide", "visibility"]),
        .init(
            .commandsCustomCommandsEnableCustomCommands,
            keywords: ["script", "shell"]),
        .init(
            .commandsCustomCommandsAddCustomCommand,
            keywords: ["new", "script", "shell", "shortcut"]),
        .init(
            .commandsCustomCommandsImportRaycastScripts,
            keywords: ["raycast", "script", "folder", "directory", "migrate"])
    ]

    private static let quicklinks: [SettingsSearchEntry] = [
        .init(pane: .quicklinks, keywords: ["url", "bookmark", "link"]),
        .init(
            .quicklinksQuicklinksEnableQuicklinks,
            keywords: ["url", "bookmark"]),
        .init(
            .quicklinksQuicklinksAddQuicklink,
            keywords: ["new", "url", "bookmark", "alias"]),
        .init(
            group: .quicklinksCommands, "Quicklink commands",
            keywords: ["shortcut", "launcher", "search", "import", "export"]),
        .init(
            .quicklinksBehaviourOpenInANewWindow,
            keywords: ["browser", "tab"]),
        .init(
            .quicklinksBehaviourPassSelectedTextAsArgument,
            keywords: ["selection", "hotkey", "shortcut", "argument"]),
        .init(
            .quicklinksBehaviourConfirmBeforeDeleting,
            keywords: ["ask", "delete", "prompt"]),
        .init(
            .quicklinksImportExportImportQuicklinks,
            keywords: ["json", "restore"]),
        .init(
            .quicklinksImportExportExportQuicklinks,
            keywords: ["json", "backup"])
    ]

    private static let appleShortcuts: [SettingsSearchEntry] = [
        .init(pane: .appleShortcuts, keywords: ["shortcuts app", "automation", "workflow"]),
        .init(
            .appleShortcutsAppleShortcutsEnableAppleShortcuts,
            keywords: ["shortcuts app", "automation", "workflow"]),
        .init(
            group: .appleShortcutsShortcuts, "Aliases and shortcuts",
            keywords: ["alias", "hotkey", "hide"])
    ]

    private static let fallbacks: [SettingsSearchEntry] = [
        .init(
            pane: .fallbacks,
            keywords: ["no results", "empty", "search web", "order"])
    ]

    private static let ai: [SettingsSearchEntry] = [
        .init(
            pane: .ai, keywords: ["chat", "quick ai", "llm", "model", "openai", "anthropic"]),
        .init(.aiAIEnableAI, keywords: ["chat", "llm"]),
        .init(
            .aiProvidersProviders,
            keywords: [
                "sign in", "connect", "codex", "claude", "grok", "xai", "opencode", "cursor", "agent",
                "api key", "connection", "base url", "openai", "anthropic", "ollama", "models",
                "hide models"
            ]),
        .init(.aiDefaultDefaultModel, keywords: ["llm", "gpt", "claude", "grok"]),
        .init(.aiDefaultReasoningEffort, keywords: ["thinking", "effort", "deepseek"]),
        .init(.aiChatWebSearch, keywords: ["browse", "internet"]),
        .init(.aiChatToolCallRounds, keywords: ["mcp", "tools", "limit", "loop", "agent", "unlimited"]),
        .init(
            .aiConversationsQuickAIOpensTo,
            keywords: ["new chat", "last", "summon", "resume"]),
        .init(
            .aiConversationsStartANewConversationAfter,
            keywords: ["idle", "timeout", "fresh"]),
        .init(
            .aiConversationsKeepConversations,
            keywords: ["retention", "delete", "history", "privacy"]),
        .init(
            .aiSystemPromptSendASystemPrompt,
            keywords: ["instructions", "persona"]),
        .init(
            .aiMCPServersEnableMCPServers,
            keywords: ["tools", "model context protocol"]),
        .init(
            .aiMCPServersAddMCPServer,
            keywords: ["tools", "model context protocol", "stdio"]),
        .init(
            group: .aiCommands, "AI commands",
            keywords: ["shortcut", "launcher", "chat"])
    ]

    private static let quickActions: [SettingsSearchEntry] = [
        .init(
            pane: .quickActions,
            keywords: ["selected text", "rewrite", "translate", "summarize"]),
        .init(
            .quickActionsQuickActionsEnableQuickActions,
            keywords: ["selected text", "accessibility"]),
        .init(
            group: .quickActionsActions, "Actions",
            keywords: ["shortcut", "replace", "preview", "customize"]),
        .init(
            .quickActionsActionsAddQuickAction,
            keywords: ["new", "custom", "prompt", "instructions", "alias"]),
        .init(
            .quickActionsModelModel,
            keywords: ["llm", "ai", "default"]),
        .init(
            .quickActionsTranslateTranslateTo,
            keywords: ["language", "locale"])
    ]

    private static let dictation: [SettingsSearchEntry] = [
        .init(pane: .dictation, keywords: ["speech", "voice", "transcription", "microphone"]),
        .init(.dictationDictationEnableDictation),
        .init(.dictationCommandsShortcutBehavior),
        .init(.dictationCommandsShortcut),
        .init(.dictationModelModel),
        .init(.dictationModelEngine, keywords: ["parakeet", "redux", "ultra", "qwen"]),
        .init(.dictationModelLanguage),
        .init(.dictationMemoryReleaseModelFromMemory),
        .init(.dictationOutputMicrophone),
        .init(.dictationOutputWhenFinished),
        .init(.dictationOutputAdaptCapitalization, keywords: ["uppercase", "lowercase", "sentence"])
    ]

    private static let fileSearch: [SettingsSearchEntry] = [
        .init(
            pane: .fileSearch,
            keywords: ["spotlight", "files", "folders", "find"]),
        .init(
            .fileSearchFileSearchEnableFileSearch,
            keywords: ["spotlight", "index"]),
        .init(
            group: .fileSearchCommands, "File search commands",
            keywords: ["shortcut", "launcher"]),
        .init(
            group: .fileSearchSearchScopes, "Search Scopes",
            keywords: ["folders", "locations", "home", "add folder"]),
        .init(
            group: .fileSearchIgnorePatterns, "Ignore Patterns",
            keywords: ["exclude", "glob", "node_modules", "skip"])
    ]

    private static let notes: [SettingsSearchEntry] = [
        .init(pane: .notes, keywords: ["markdown", "scratchpad", "floating"]),
        .init(
            .notesNotesEnableNotes,
            keywords: ["markdown", "scratchpad"]),
        .init(
            .notesOptionsRenderMarkdown,
            keywords: ["markdown", "formatting", "preview", "raw", "source"]),
        .init(
            .notesOptionsShowFormattingBar,
            keywords: ["toolbar", "format bar", "buttons", "bold", "heading", "markdown"]),
        .init(
            .notesOptionsNotesFolder,
            keywords: ["location", "path", "dotfiles", "files", "markdown"]),
        .init(
            group: .notesCommands, "Notes commands",
            keywords: ["shortcut", "new note", "search notes"])
    ]

    private static let snippets: [SettingsSearchEntry] = [
        .init(
            pane: .snippets,
            keywords: ["expansion", "keyword", "text replacement", "template"]),
        .init(
            .snippetsSnippetsEnableSnippets,
            keywords: ["expansion", "keystrokes", "accessibility"]),
        .init(
            group: .snippetsCommands, "Snippet commands",
            keywords: ["shortcut", "hotkey", "launcher", "browser"]),
        .init(
            .snippetsLibraryNewSnippet,
            keywords: ["add", "keyword", "expansion"]),
        .init(
            .snippetsLibrarySnippetsFolder,
            keywords: ["reveal", "finder", "markdown", "files", "location", "path", "dotfiles"])
    ]

    private static let navigation: [SettingsSearchEntry] = [
        .init(
            pane: .navigation,
            keywords: ["window", "switch", "menu bar", "focus", "raise"]),
        .init(
            .navigationNavigationEnableNavigation,
            keywords: ["window switcher", "menu bar", "accessibility"]),
        .init(
            group: .navigationCommands, "Navigation commands",
            keywords: ["shortcut", "hotkey", "alias", "launcher"]),
        .init(
            .navigationMenuSearchShowAppleMenuItems,
            keywords: ["apple menu", "about this mac", "recent items", "sleep", "logo"]),
        .init(
            .navigationMenuSearchDisabledApplications,
            keywords: ["exclude", "password manager", "ignore", "privacy", "menu bar"])
    ]

    private static let windowManagement: [SettingsSearchEntry] = [
        .init(
            pane: .windowManagement,
            keywords: ["tile", "halves", "thirds", "maximize", "snap", "layouts", "arrangement"]),
        .init(
            .windowManagementWindowManagementEnableWindowManagement,
            keywords: ["tile", "accessibility"]),
        .init(
            .windowManagementOptionsCycling,
            keywords: ["repeat", "thirds", "halves", "displays", "monitor", "screens"]),
        .init(
            .windowManagementOptionsGapBetweenWindows,
            keywords: ["padding", "spacing", "margin", "points"]),
        .init(
            .windowManagementOptionsShortcutPreset,
            keywords: ["rectangle", "magnet", "spectacle", "defaults", "import", "shortcuts"]),
        .init(
            group: .windowManagementOptions, "Window commands",
            keywords: ["shortcut", "alias", "left half", "maximize", "center"]),
        .init(
            group: .windowManagementLayoutCommands, "Layout and room commands",
            keywords: [
                "shortcut", "launcher", "create layout", "capture", "switch room", "create room"
            ]),
        .init(
            group: .windowManagementLayouts, "Window Layouts",
            keywords: [
                "layout", "arrangement", "workspace", "preset", "restore windows",
                "multi display", "monitor", "alias"
            ]),
        .init(
            .windowManagementLayoutsShowLayoutsInLauncher,
            keywords: ["hide", "visibility", "search"]),
        .init(
            .windowManagementLayoutsNewLayout,
            keywords: ["add", "create", "arrangement", "preset"]),
        .init(
            .windowManagementLayoutsCreateLayoutFromCurrentWindows,
            keywords: ["capture", "snapshot", "current", "save arrangement"]),
        .init(
            group: .windowManagementRooms, "Rooms",
            keywords: [
                "room", "project", "workspace", "tile", "focus", "columns", "grid", "stack",
                "hide other apps", "switch project", "alias"
            ]),
        .init(
            .windowManagementRoomsShowRoomsInLauncher,
            keywords: ["hide", "visibility", "search"]),
        .init(
            .windowManagementRoomsNewRoom,
            keywords: ["add", "create", "project", "windows"]),
        .init(
            group: .windowManagementCustomSizes, "Custom Sizes",
            keywords: ["custom", "size", "resize", "dimensions", "pixels", "points", "percent", "alias"]),
        .init(
            .windowManagementCustomSizesNewCustomSize,
            keywords: ["add", "create", "resize", "window size"])
    ]

    private static let clipboard: [SettingsSearchEntry] = [
        .init(
            pane: .clipboard,
            keywords: ["paste", "history", "copy", "pasteboard"]),
        .init(
            .clipboardClipboardEnableClipboardHistory,
            keywords: ["disable", "turn off", "monitor", "record", "privacy"]),
        .init(
            group: .clipboardCommands, "Clipboard commands",
            keywords: ["shortcut", "hotkey", "launcher", "paste", "browser"]),
        .init(
            .clipboardHistoryKeepHistoryFor,
            keywords: ["retention", "delete", "privacy", "expire", "保留", "清理", "隐私"]),
        .init(
            .clipboardHistorySearchTextInImagesAndPDFs,
            keywords: ["OCR", "recognize", "scan", "screenshot", "background", "idle"]),
        .init(
            .clipboardHistoryDefaultAction,
            keywords: ["enter", "return", "paste", "copy", "primary"]),
        .init(
            group: .clipboardDisabledApplications, "Disabled Applications",
            keywords: ["exclude", "password manager", "ignore", "privacy"]),
        .init(
            .clipboardDisabledApplicationsClearHistory,
            keywords: ["delete", "erase", "wipe"])
    ]

    private static let emoji: [SettingsSearchEntry] = [
        .init(
            pane: .emoji,
            keywords: ["picker", "character", "unicode", "smiley"]),
        .init(
            group: .emojiCommands, "Emoji commands",
            keywords: ["shortcut", "hotkey", "launcher", "picker"]),
        .init(
            .emojiAppearanceEmojiSkinTone,
            keywords: ["colour", "color", "fitzpatrick", "default"]),
        .init(
            .emojiAppearanceColumnCount,
            keywords: ["columns", "density", "zoom", "six", "eight", "ten"])
    ]

    private static let calendar: [SettingsSearchEntry] = [
        .init(
            pane: .calendar,
            keywords: ["meetings", "events", "zoom", "join", "schedule"]),
        .init(
            .calendarCalendarJoinMeetingsFromTinycast,
            keywords: ["zoom", "meet", "teams", "permission"]),
        .init(
            .calendarCalendarUpcomingMeetingsInLauncher,
            keywords: ["count", "limit", "events"]),
        .init(
            .calendarJoiningShowTheJoinCard,
            keywords: ["hud", "timing", "early", "reminder"]),
        .init(
            .calendarJoiningAutoJoinMeetings,
            keywords: ["automatic", "start"]),
        .init(
            .calendarJoiningOnlyJoinKnownMeetingServices,
            keywords: ["zoom", "meet", "teams", "links", "placeholder", "skip"]),
        .init(
            .calendarJoiningConfirmBeforeJoining,
            keywords: ["ask", "prompt"]),
        .init(
            .calendarJoiningCameraPreview,
            keywords: ["webcam", "mirror", "video", "check"]),
        .init(
            .calendarJoiningOpenMeetingLinksIn,
            keywords: ["browser", "chrome", "safari", "firefox", "meet", "web"]),
        .init(
            .calendarMenuBarCalendarInMenuBar,
            keywords: ["status item", "menubar", "date"]),
        .init(
            .calendarMenuBarDaysToShow,
            keywords: ["tomorrow", "week", "next 7 days", "range", "agenda", "schedule"]),
        .init(
            .calendarMenuBarShowUpcomingEvents,
            keywords: ["menubar", "next event", "title"]),
        .init(
            .calendarMenuBarOnlyShowEventsWithMeetings,
            keywords: ["links", "filter", "menubar"]),
        .init(
            .calendarMenuBarHideWhenThereAreNoUpcomingEvents,
            keywords: ["empty", "idle", "menubar", "space"]),
        .init(
            .calendarMenuBarHideCurrentEvent,
            keywords: ["started", "time left", "menubar"]),
        .init(
            group: .calendarCommands, "Calendar commands",
            keywords: ["shortcut", "launcher", "join", "schedule", "create event"]),
        .init(
            group: .calendarCalendars, "Calendars",
            keywords: ["accounts", "sources", "choose", "icloud", "google"])
    ]

    private static let extensions: [SettingsSearchEntry] = [
        .init(
            pane: .extensions,
            keywords: ["raycast", "plugins", "store", "javascript"]),
        .init(
            .extensionsExtensionsEnableExtensions,
            keywords: ["raycast", "third party", "javascript"]),
        .init(
            .extensionsInstallSearchExtensions,
            keywords: ["store", "browse", "install"]),
        .init(
            .extensionsInstallInstallFromGitHub,
            keywords: ["source", "build", "repository", "package manager", "pnpm", "npm", "yarn", "bun"]),
        .init(
            .extensionsInstallImportFromRaycast,
            keywords: ["migrate", "existing"]),
        .init(
            .extensionsInstallAddFromFolder,
            keywords: ["local", "develop", "sideload"]),
        .init(
            group: .extensionsInstalled, "Installed extensions",
            keywords: [
                "library", "uninstall", "update", "preferences", "appearance", "alias", "shortcut"
            ]),
        .init(
            group: .extensionsCompatibility, "Compatibility",
            keywords: ["supported", "unsupported", "raycast api"]),
        .init(
            .extensionsStorageLeftoverFiles,
            keywords: ["clean up", "disk", "reclaim", "cache"])
    ]

    private static let permissions: [SettingsSearchEntry] = [
        .init(
            pane: .permissions,
            keywords: ["privacy", "tcc", "access", "grant"]),
        .init(
            .permissionsAccessibilityAccessibility,
            keywords: ["paste", "keystrokes", "privacy", "grant"]),
        .init(
            .permissionsCalendarsCalendars,
            keywords: ["events", "privacy", "grant", "eventkit"]),
        .init(
            .permissionsMicrophoneMicrophone,
            keywords: ["dictation", "recording", "privacy", "grant"])
    ]

    private static let backup: [SettingsSearchEntry] = [
        .init(
            pane: .backup,
            keywords: ["export", "import", "restore", "migrate", "raycast"]),
        .init(
            .backupExportExportBackup,
            keywords: ["save", "tinycast file", "archive"]),
        .init(
            .backupImportBackupFile,
            keywords: ["restore", "choose", "tinycast file"]),
        .init(
            .backupImportFromRaycastRaycastExport,
            keywords: ["migrate", "rayconfig", "passphrase"]),
        .init(
            .backupSettingsFileSyncSettingsFile,
            keywords: ["settings.json", "config", "json", "dotfiles", ".config", "edit"])
    ]

    private static let about: [SettingsSearchEntry] = [
        .init(
            pane: .about,
            keywords: ["version", "licence", "license", "credits"]),
        .init(
            .aboutAboutCheckForUpdates,
            keywords: ["version", "upgrade", "release"]),
        .init(
            group: .aboutLinks, "Links",
            keywords: ["github", "source", "issues", "website"]),
        .init(
            .aboutLinksSupport,
            keywords: ["donate", "sponsor", "funding"])
    ]
}

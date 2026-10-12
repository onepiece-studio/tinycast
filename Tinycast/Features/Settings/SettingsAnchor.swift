import Foundation

enum SettingsAnchor: String, CaseIterable, Sendable {
    case generalGlobalShortcuts
    case generalSearch
    case generalHyperKey
    case generalAppearance
    case generalCalculator
    case generalGeneral
    case applicationsSearchScopes
    case applicationsApplications
    case systemSettingsSystemSettings
    case systemActionsSystemActions
    case commandsCommands
    case commandsCustomCommands
    case quicklinksQuicklinks
    case quicklinksCommands
    case quicklinksBehaviour
    case quicklinksImportExport
    case appleShortcutsAppleShortcuts
    case appleShortcutsShortcuts
    case fallbacksFallbacks
    case aiAI
    case aiProviders
    case aiDefault
    case aiChat
    case aiConversations
    case aiSystemPrompt
    case aiMCPServers
    case aiCommands
    case quickActionsQuickActions
    case quickActionsActions
    case quickActionsModel
    case quickActionsTranslate
    case dictationDictation
    case dictationCommands
    case dictationModel
    case dictationMemory
    case dictationOutput
    case fileSearchFileSearch
    case fileSearchCommands
    case fileSearchSearchScopes
    case fileSearchIgnorePatterns
    case notesNotes
    case notesOptions
    case notesCommands
    case snippetsSnippets
    case snippetsCommands
    case snippetsLibrary
    case navigationNavigation
    case navigationCommands
    case navigationMenuSearch
    case windowManagementWindowManagement
    case windowManagementLayouts
    case windowManagementRooms
    case windowManagementLayoutCommands
    case windowManagementOptions
    case windowManagementCustomSizes
    case clipboardClipboard
    case clipboardCommands
    case clipboardHistory
    case clipboardDisabledApplications
    case emojiCommands
    case emojiAppearance
    case calendarCalendar
    case calendarCommands
    case calendarJoining
    case calendarMenuBar
    case calendarCalendars
    case extensionsExtensions
    case extensionsCompatibility
    case extensionsInstalled
    case extensionsInstall
    case extensionsStorage
    case permissionsAccessibility
    case permissionsCalendars
    case permissionsMicrophone
    case backupExport
    case backupImport
    case backupImportFromRaycast
    case backupSettingsFile
    case aboutAbout
    case aboutLinks

    var tab: SettingsTab {
        switch self {
        case .generalGlobalShortcuts: .general
        case .generalSearch: .general
        case .generalHyperKey: .general
        case .generalAppearance: .general
        case .generalCalculator: .general
        case .generalGeneral: .general
        case .applicationsSearchScopes: .applications
        case .applicationsApplications: .applications
        case .systemSettingsSystemSettings: .systemSettings
        case .systemActionsSystemActions: .systemActions
        case .commandsCommands: .commands
        case .commandsCustomCommands: .commands
        case .quicklinksQuicklinks: .quicklinks
        case .quicklinksCommands: .quicklinks
        case .quicklinksBehaviour: .quicklinks
        case .quicklinksImportExport: .quicklinks
        case .appleShortcutsAppleShortcuts: .appleShortcuts
        case .appleShortcutsShortcuts: .appleShortcuts
        case .fallbacksFallbacks: .fallbacks
        case .aiAI: .ai
        case .aiProviders: .ai
        case .aiDefault: .ai
        case .aiChat: .ai
        case .aiConversations: .ai
        case .aiSystemPrompt: .ai
        case .aiMCPServers: .ai
        case .aiCommands: .ai
        case .quickActionsQuickActions: .quickActions
        case .quickActionsActions: .quickActions
        case .quickActionsModel: .quickActions
        case .quickActionsTranslate: .quickActions
        case .dictationDictation: .dictation
        case .dictationCommands: .dictation
        case .dictationModel: .dictation
        case .dictationMemory: .dictation
        case .dictationOutput: .dictation
        case .fileSearchFileSearch: .fileSearch
        case .fileSearchCommands: .fileSearch
        case .fileSearchSearchScopes: .fileSearch
        case .fileSearchIgnorePatterns: .fileSearch
        case .notesNotes: .notes
        case .notesOptions: .notes
        case .notesCommands: .notes
        case .snippetsSnippets: .snippets
        case .snippetsCommands: .snippets
        case .snippetsLibrary: .snippets
        case .navigationNavigation: .navigation
        case .navigationCommands: .navigation
        case .navigationMenuSearch: .navigation
        case .windowManagementWindowManagement: .windowManagement
        case .windowManagementLayouts: .windowManagement
        case .windowManagementRooms: .windowManagement
        case .windowManagementLayoutCommands: .windowManagement
        case .windowManagementOptions: .windowManagement
        case .windowManagementCustomSizes: .windowManagement
        case .clipboardClipboard: .clipboard
        case .clipboardCommands: .clipboard
        case .clipboardHistory: .clipboard
        case .clipboardDisabledApplications: .clipboard
        case .emojiCommands: .emoji
        case .emojiAppearance: .emoji
        case .calendarCalendar: .calendar
        case .calendarCommands: .calendar
        case .calendarJoining: .calendar
        case .calendarMenuBar: .calendar
        case .calendarCalendars: .calendar
        case .extensionsExtensions: .extensions
        case .extensionsCompatibility: .extensions
        case .extensionsInstalled: .extensions
        case .extensionsInstall: .extensions
        case .extensionsStorage: .extensions
        case .permissionsAccessibility: .permissions
        case .permissionsCalendars: .permissions
        case .permissionsMicrophone: .permissions
        case .backupExport: .backup
        case .backupImport: .backup
        case .backupImportFromRaycast: .backup
        case .backupSettingsFile: .backup
        case .aboutAbout: .about
        case .aboutLinks: .about
        }
    }

    var titleResource: LocalizedStringResource {
        switch self {
        case .generalGlobalShortcuts: "Global Shortcuts"
        case .generalSearch: "Search"
        case .generalHyperKey: "Hyper Key"
        case .generalAppearance: "Appearance"
        case .generalCalculator: "Calculator"
        case .generalGeneral: "General"
        case .applicationsSearchScopes: "Search Scopes"
        case .applicationsApplications: "Applications"
        case .systemSettingsSystemSettings: "System Settings"
        case .systemActionsSystemActions: "System Actions"
        case .commandsCommands: "Commands"
        case .commandsCustomCommands: "Custom Commands"
        case .quicklinksQuicklinks: "Quicklinks"
        case .quicklinksCommands: "Commands"
        case .quicklinksBehaviour: "Behaviour"
        case .quicklinksImportExport: "Import & Export"
        case .appleShortcutsAppleShortcuts: "Apple Shortcuts"
        case .appleShortcutsShortcuts: "Shortcuts"
        case .fallbacksFallbacks: "Fallbacks"
        case .aiAI: "AI"
        case .aiProviders: "Providers"
        case .aiDefault: "Default"
        case .aiChat: "Chat"
        case .aiConversations: "Conversations"
        case .aiSystemPrompt: "System prompt"
        case .aiMCPServers: "MCP Servers"
        case .aiCommands: "Commands"
        case .quickActionsQuickActions: "Quick Actions"
        case .quickActionsActions: "Actions"
        case .quickActionsModel: "Model"
        case .quickActionsTranslate: "Translate"
        case .dictationDictation: "Dictation"
        case .dictationCommands: "Commands"
        case .dictationModel: "Model"
        case .dictationMemory: "Memory"
        case .dictationOutput: "Output"
        case .fileSearchFileSearch: "File Search"
        case .fileSearchCommands: "Commands"
        case .fileSearchSearchScopes: "Search Scopes"
        case .fileSearchIgnorePatterns: "Ignore Patterns"
        case .notesNotes: "Notes"
        case .notesOptions: "Options"
        case .notesCommands: "Commands"
        case .snippetsSnippets: "Snippets"
        case .snippetsCommands: "Commands"
        case .snippetsLibrary: "Library"
        case .navigationNavigation: "Navigation"
        case .navigationCommands: "Commands"
        case .navigationMenuSearch: "Search Menu Bar Items"
        case .windowManagementWindowManagement: "Window Management"
        case .windowManagementLayouts: "Window Layouts"
        case .windowManagementRooms: "Rooms"
        case .windowManagementLayoutCommands: "Layout and Room Commands"
        case .windowManagementOptions: "Options"
        case .windowManagementCustomSizes: "Custom Sizes"
        case .clipboardClipboard: "Clipboard"
        case .clipboardCommands: "Commands"
        case .clipboardHistory: "History"
        case .clipboardDisabledApplications: "Disabled Applications"
        case .emojiCommands: "Commands"
        case .emojiAppearance: "Appearance"
        case .calendarCalendar: "Calendar"
        case .calendarCommands: "Commands"
        case .calendarJoining: "Joining"
        case .calendarMenuBar: "Menu Bar"
        case .calendarCalendars: "Calendars"
        case .extensionsExtensions: "Extensions"
        case .extensionsCompatibility: "Compatibility"
        case .extensionsInstalled: "Installed"
        case .extensionsInstall: "Install"
        case .extensionsStorage: "Storage"
        case .permissionsAccessibility: "Accessibility"
        case .permissionsCalendars: "Calendars"
        case .permissionsMicrophone: "Microphone"
        case .backupExport: "Export"
        case .backupImport: "Import"
        case .backupImportFromRaycast: "Import from Raycast"
        case .backupSettingsFile: "Settings File"
        case .aboutAbout: "About"
        case .aboutLinks: "Links"
        }
    }

    var title: String { String(localized: titleResource) }
}

enum SettingsTarget: Hashable, Sendable {
    case section(SettingsAnchor)
    case row(SettingsRowID)
    case item(SettingsAnchor, String)

    var anchor: SettingsAnchor {
        switch self {
        case .section(let anchor), .item(let anchor, _): return anchor
        case .row(let row): return row.anchor
        }
    }

    var tab: SettingsTab { anchor.tab }
}

/// One jump asked for by a search result. The token is what makes picking the same result twice
/// scroll and pulse again, rather than comparing equal and doing nothing.
struct SettingsScrollRequest: Equatable, Sendable {
    let target: SettingsTarget
    let token: Int
}

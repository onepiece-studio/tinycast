import Foundation

enum SettingsRowID: String, CaseIterable, Sendable {
    case generalGlobalShortcutsAppLauncher
    case generalGeneralLaunchAtLogin
    case generalGeneralShowInMenuBar
    case generalGeneralAutomaticallyCheckForUpdates
    case generalGeneralPopToRootSearch
    case generalGeneralEscapeKeyBehavior
    case generalGeneralAutoSwitchInputSource
    case generalAppearanceTheme
    case generalAppearanceInterfaceSize
    case generalAppearanceWindowMode
    case generalAppearanceShowFavoritesInCompactMode
    case generalAppearanceFollowTheCursorAcrossDisplays
    case generalAppearanceDragToReposition
    case generalHyperKeyHyperKey
    case generalHyperKeyQuickPress
    case generalHyperKeyIncludeShift
    case generalHyperKeySecureInputCompatibility
    case generalCalculatorNumberFormat
    case generalSearchShowSuggestions
    case generalSearchSearchSensitivity
    case generalSearchLearnedRanking
    case applicationsApplicationsEnableApplications
    case systemSettingsSystemSettingsEnableSystemSettings
    case systemActionsSystemActionsEnableSystemActions
    case commandsCommandsEnableCommands
    case commandsCustomCommandsEnableCustomCommands
    case commandsCustomCommandsAddCustomCommand
    case commandsCustomCommandsImportRaycastScripts
    case quicklinksQuicklinksEnableQuicklinks
    case quicklinksQuicklinksAddQuicklink
    case quicklinksBehaviourOpenInANewWindow
    case quicklinksBehaviourPassSelectedTextAsArgument
    case quicklinksBehaviourConfirmBeforeDeleting
    case quicklinksImportExportImportQuicklinks
    case quicklinksImportExportExportQuicklinks
    case appleShortcutsAppleShortcutsEnableAppleShortcuts
    case aiAIEnableAI
    case aiProvidersProviders
    case aiDefaultDefaultModel
    case aiDefaultReasoningEffort
    case aiChatWebSearch
    case aiChatToolCallRounds
    case aiConversationsQuickAIOpensTo
    case aiConversationsStartANewConversationAfter
    case aiConversationsKeepConversations
    case aiSystemPromptSendASystemPrompt
    case aiMCPServersEnableMCPServers
    case aiMCPServersAddMCPServer
    case quickActionsQuickActionsEnableQuickActions
    case quickActionsActionsAddQuickAction
    case quickActionsModelModel
    case quickActionsTranslateTranslateTo
    case dictationDictationEnableDictation
    case dictationCommandsShortcutBehavior
    case dictationCommandsShortcut
    case dictationModelModel
    case dictationModelEngine
    case dictationModelLanguage
    case dictationMemoryReleaseModelFromMemory
    case dictationOutputMicrophone
    case dictationOutputWhenFinished
    case dictationOutputAdaptCapitalization
    case fileSearchFileSearchEnableFileSearch
    case fileSearchFullDiskAccessPermission
    case fileSearchIndexIndexedItems
    case notesNotesEnableNotes
    case notesOptionsRenderMarkdown
    case notesOptionsShowFormattingBar
    case notesOptionsNotesFolder
    case snippetsSnippetsEnableSnippets
    case snippetsLibraryNewSnippet
    case snippetsLibrarySnippetsFolder
    case navigationNavigationEnableNavigation
    case navigationMenuSearchShowAppleMenuItems
    case navigationMenuSearchDisabledApplications
    case windowManagementWindowManagementEnableWindowManagement
    case windowManagementOptionsCycling
    case windowManagementOptionsGapBetweenWindows
    case windowManagementOptionsShortcutPreset
    case windowManagementLayoutsShowLayoutsInLauncher
    case windowManagementLayoutsNewLayout
    case windowManagementLayoutsCreateLayoutFromCurrentWindows
    case windowManagementRoomsShowRoomsInLauncher
    case windowManagementRoomsNewRoom
    case windowManagementCustomSizesNewCustomSize
    case clipboardClipboardEnableClipboardHistory
    case clipboardHistoryKeepHistoryFor
    case clipboardHistorySearchTextInImagesAndPDFs
    case clipboardHistoryDefaultAction
    case clipboardDisabledApplicationsClearHistory
    case emojiAppearanceEmojiSkinTone
    case emojiAppearanceColumnCount
    case calendarCalendarJoinMeetingsFromTinycast
    case calendarCalendarUpcomingMeetingsInLauncher
    case calendarJoiningShowTheJoinCard
    case calendarJoiningAutoJoinMeetings
    case calendarJoiningOnlyJoinKnownMeetingServices
    case calendarJoiningConfirmBeforeJoining
    case calendarJoiningCameraPreview
    case calendarJoiningOpenMeetingLinksIn
    case calendarMenuBarCalendarInMenuBar
    case calendarMenuBarDaysToShow
    case calendarMenuBarShowUpcomingEvents
    case calendarMenuBarOnlyShowEventsWithMeetings
    case calendarMenuBarHideWhenThereAreNoUpcomingEvents
    case calendarMenuBarHideCurrentEvent
    case extensionsExtensionsEnableExtensions
    case extensionsInstallSearchExtensions
    case extensionsInstallInstallFromGitHub
    case extensionsInstallImportFromRaycast
    case extensionsInstallAddFromFolder
    case extensionsStorageLeftoverFiles
    case permissionsAccessibilityAccessibility
    case permissionsCalendarsCalendars
    case permissionsMicrophoneMicrophone
    case backupExportExportBackup
    case backupImportBackupFile
    case backupImportFromRaycastRaycastExport
    case backupSettingsFileSyncSettingsFile
    case aboutAboutCheckForUpdates
    case aboutLinksSupport

    case quickActionsModelReasoningEffort

    var anchor: SettingsAnchor {
        switch self {
        case .quickActionsModelReasoningEffort: .quickActionsModel
        case .generalGlobalShortcutsAppLauncher: .generalGlobalShortcuts
        case .generalGeneralLaunchAtLogin: .generalGeneral
        case .generalGeneralShowInMenuBar: .generalGeneral
        case .generalGeneralAutomaticallyCheckForUpdates: .generalGeneral
        case .generalGeneralPopToRootSearch: .generalGeneral
        case .generalGeneralEscapeKeyBehavior: .generalGeneral
        case .generalGeneralAutoSwitchInputSource: .generalGeneral
        case .generalAppearanceTheme: .generalAppearance
        case .generalAppearanceInterfaceSize: .generalAppearance
        case .generalAppearanceWindowMode: .generalAppearance
        case .generalAppearanceShowFavoritesInCompactMode: .generalAppearance
        case .generalAppearanceFollowTheCursorAcrossDisplays: .generalAppearance
        case .generalAppearanceDragToReposition: .generalAppearance
        case .generalHyperKeyHyperKey: .generalHyperKey
        case .generalHyperKeyQuickPress: .generalHyperKey
        case .generalHyperKeyIncludeShift: .generalHyperKey
        case .generalHyperKeySecureInputCompatibility: .generalHyperKey
        case .generalCalculatorNumberFormat: .generalCalculator
        case .generalSearchShowSuggestions: .generalSearch
        case .generalSearchSearchSensitivity: .generalSearch
        case .generalSearchLearnedRanking: .generalSearch
        case .applicationsApplicationsEnableApplications: .applicationsApplications
        case .systemSettingsSystemSettingsEnableSystemSettings: .systemSettingsSystemSettings
        case .systemActionsSystemActionsEnableSystemActions: .systemActionsSystemActions
        case .commandsCommandsEnableCommands: .commandsCommands
        case .commandsCustomCommandsEnableCustomCommands: .commandsCustomCommands
        case .commandsCustomCommandsAddCustomCommand: .commandsCustomCommands
        case .commandsCustomCommandsImportRaycastScripts: .commandsCustomCommands
        case .quicklinksQuicklinksEnableQuicklinks: .quicklinksQuicklinks
        case .quicklinksQuicklinksAddQuicklink: .quicklinksQuicklinks
        case .quicklinksBehaviourOpenInANewWindow: .quicklinksBehaviour
        case .quicklinksBehaviourPassSelectedTextAsArgument: .quicklinksBehaviour
        case .quicklinksBehaviourConfirmBeforeDeleting: .quicklinksBehaviour
        case .quicklinksImportExportImportQuicklinks: .quicklinksImportExport
        case .quicklinksImportExportExportQuicklinks: .quicklinksImportExport
        case .appleShortcutsAppleShortcutsEnableAppleShortcuts: .appleShortcutsAppleShortcuts
        case .aiAIEnableAI: .aiAI
        case .aiProvidersProviders: .aiProviders
        case .aiDefaultDefaultModel: .aiDefault
        case .aiDefaultReasoningEffort: .aiDefault
        case .aiChatWebSearch: .aiChat
        case .aiChatToolCallRounds: .aiChat
        case .aiConversationsQuickAIOpensTo: .aiConversations
        case .aiConversationsStartANewConversationAfter: .aiConversations
        case .aiConversationsKeepConversations: .aiConversations
        case .aiSystemPromptSendASystemPrompt: .aiSystemPrompt
        case .aiMCPServersEnableMCPServers: .aiMCPServers
        case .aiMCPServersAddMCPServer: .aiMCPServers
        case .quickActionsQuickActionsEnableQuickActions: .quickActionsQuickActions
        case .quickActionsActionsAddQuickAction: .quickActionsActions
        case .quickActionsModelModel: .quickActionsModel
        case .quickActionsTranslateTranslateTo: .quickActionsTranslate
        case .dictationDictationEnableDictation: .dictationDictation
        case .dictationCommandsShortcutBehavior: .dictationCommands
        case .dictationCommandsShortcut: .dictationCommands
        case .dictationModelModel: .dictationModel
        case .dictationModelEngine: .dictationModel
        case .dictationModelLanguage: .dictationModel
        case .dictationMemoryReleaseModelFromMemory: .dictationMemory
        case .dictationOutputMicrophone: .dictationOutput
        case .dictationOutputWhenFinished: .dictationOutput
        case .dictationOutputAdaptCapitalization: .dictationOutput
        case .fileSearchFileSearchEnableFileSearch: .fileSearchFileSearch
        case .fileSearchFullDiskAccessPermission: .fileSearchFullDiskAccess
        case .fileSearchIndexIndexedItems: .fileSearchIndex
        case .notesNotesEnableNotes: .notesNotes
        case .notesOptionsRenderMarkdown: .notesOptions
        case .notesOptionsShowFormattingBar: .notesOptions
        case .notesOptionsNotesFolder: .notesOptions
        case .snippetsSnippetsEnableSnippets: .snippetsSnippets
        case .snippetsLibraryNewSnippet: .snippetsLibrary
        case .snippetsLibrarySnippetsFolder: .snippetsLibrary
        case .navigationNavigationEnableNavigation: .navigationNavigation
        case .navigationMenuSearchShowAppleMenuItems: .navigationMenuSearch
        case .navigationMenuSearchDisabledApplications: .navigationMenuSearch
        case .windowManagementWindowManagementEnableWindowManagement: .windowManagementWindowManagement
        case .windowManagementOptionsCycling: .windowManagementOptions
        case .windowManagementOptionsGapBetweenWindows: .windowManagementOptions
        case .windowManagementOptionsShortcutPreset: .windowManagementOptions
        case .windowManagementLayoutsShowLayoutsInLauncher: .windowManagementLayouts
        case .windowManagementLayoutsNewLayout: .windowManagementLayouts
        case .windowManagementLayoutsCreateLayoutFromCurrentWindows: .windowManagementLayouts
        case .windowManagementRoomsShowRoomsInLauncher: .windowManagementRooms
        case .windowManagementRoomsNewRoom: .windowManagementRooms
        case .windowManagementCustomSizesNewCustomSize: .windowManagementCustomSizes
        case .clipboardClipboardEnableClipboardHistory: .clipboardClipboard
        case .clipboardHistoryKeepHistoryFor: .clipboardHistory
        case .clipboardHistorySearchTextInImagesAndPDFs: .clipboardHistory
        case .clipboardHistoryDefaultAction: .clipboardHistory
        case .clipboardDisabledApplicationsClearHistory: .clipboardDisabledApplications
        case .emojiAppearanceEmojiSkinTone: .emojiAppearance
        case .emojiAppearanceColumnCount: .emojiAppearance
        case .calendarCalendarJoinMeetingsFromTinycast: .calendarCalendar
        case .calendarCalendarUpcomingMeetingsInLauncher: .calendarCalendar
        case .calendarJoiningShowTheJoinCard: .calendarJoining
        case .calendarJoiningAutoJoinMeetings: .calendarJoining
        case .calendarJoiningOnlyJoinKnownMeetingServices: .calendarJoining
        case .calendarJoiningConfirmBeforeJoining: .calendarJoining
        case .calendarJoiningCameraPreview: .calendarJoining
        case .calendarJoiningOpenMeetingLinksIn: .calendarJoining
        case .calendarMenuBarCalendarInMenuBar: .calendarMenuBar
        case .calendarMenuBarDaysToShow: .calendarMenuBar
        case .calendarMenuBarShowUpcomingEvents: .calendarMenuBar
        case .calendarMenuBarOnlyShowEventsWithMeetings: .calendarMenuBar
        case .calendarMenuBarHideWhenThereAreNoUpcomingEvents: .calendarMenuBar
        case .calendarMenuBarHideCurrentEvent: .calendarMenuBar
        case .extensionsExtensionsEnableExtensions: .extensionsExtensions
        case .extensionsInstallSearchExtensions: .extensionsInstall
        case .extensionsInstallInstallFromGitHub: .extensionsInstall
        case .extensionsInstallImportFromRaycast: .extensionsInstall
        case .extensionsInstallAddFromFolder: .extensionsInstall
        case .extensionsStorageLeftoverFiles: .extensionsStorage
        case .permissionsAccessibilityAccessibility: .permissionsAccessibility
        case .permissionsCalendarsCalendars: .permissionsCalendars
        case .permissionsMicrophoneMicrophone: .permissionsMicrophone
        case .backupExportExportBackup: .backupExport
        case .backupImportBackupFile: .backupImport
        case .backupImportFromRaycastRaycastExport: .backupImportFromRaycast
        case .backupSettingsFileSyncSettingsFile: .backupSettingsFile
        case .aboutAboutCheckForUpdates: .aboutAbout
        case .aboutLinksSupport: .aboutLinks
        }
    }

    var titleResource: LocalizedStringResource {
        switch self {
        case .quickActionsModelReasoningEffort: "Reasoning effort"
        case .generalGlobalShortcutsAppLauncher: "App Launcher"
        case .generalGeneralLaunchAtLogin: "Launch at login"
        case .generalGeneralShowInMenuBar: "Show in menu bar"
        case .generalGeneralAutomaticallyCheckForUpdates: "Automatically check for updates"
        case .generalGeneralPopToRootSearch: "Pop to Root Search"
        case .generalGeneralEscapeKeyBehavior: "Escape Key Behavior"
        case .generalGeneralAutoSwitchInputSource: "Auto-switch input source"
        case .generalAppearanceTheme: "Theme"
        case .generalAppearanceInterfaceSize: "Interface size"
        case .generalAppearanceWindowMode: "Window mode"
        case .generalAppearanceShowFavoritesInCompactMode: "Show favorites in compact mode"
        case .generalAppearanceFollowTheCursorAcrossDisplays: "Follow the cursor across displays"
        case .generalAppearanceDragToReposition: "Drag to reposition"
        case .generalHyperKeyHyperKey: "Hyper Key"
        case .generalHyperKeyQuickPress: "Quick Press"
        case .generalHyperKeyIncludeShift: "Include Shift (⇧)"
        case .generalHyperKeySecureInputCompatibility: "Secure Input Compatibility"
        case .generalCalculatorNumberFormat: "Number format"
        case .generalSearchShowSuggestions: "Show suggestions"
        case .generalSearchSearchSensitivity: "Search sensitivity"
        case .generalSearchLearnedRanking: "Learned ranking"
        case .applicationsApplicationsEnableApplications: "Enable Applications"
        case .systemSettingsSystemSettingsEnableSystemSettings: "Enable System Settings"
        case .systemActionsSystemActionsEnableSystemActions: "Enable System Actions"
        case .commandsCommandsEnableCommands: "Enable Commands"
        case .commandsCustomCommandsEnableCustomCommands: "Enable custom commands"
        case .commandsCustomCommandsAddCustomCommand: "Add Custom Command"
        case .commandsCustomCommandsImportRaycastScripts: "Import Raycast Scripts"
        case .quicklinksQuicklinksEnableQuicklinks: "Enable quicklinks"
        case .quicklinksQuicklinksAddQuicklink: "Add Quicklink"
        case .quicklinksBehaviourOpenInANewWindow: "Open in a new window"
        case .quicklinksBehaviourPassSelectedTextAsArgument: "Pass selected text as argument"
        case .quicklinksBehaviourConfirmBeforeDeleting: "Confirm before deleting"
        case .quicklinksImportExportImportQuicklinks: "Import quicklinks"
        case .quicklinksImportExportExportQuicklinks: "Export quicklinks"
        case .appleShortcutsAppleShortcutsEnableAppleShortcuts: "Enable Apple Shortcuts"
        case .aiAIEnableAI: "Enable AI"
        case .aiProvidersProviders: "Providers"
        case .aiDefaultDefaultModel: "Default model"
        case .aiDefaultReasoningEffort: "Reasoning effort"
        case .aiChatWebSearch: "Web search"
        case .aiChatToolCallRounds: "Tool call rounds"
        case .aiConversationsQuickAIOpensTo: "Quick AI opens to"
        case .aiConversationsStartANewConversationAfter: "Start a new conversation after"
        case .aiConversationsKeepConversations: "Keep conversations"
        case .aiSystemPromptSendASystemPrompt: "Send a system prompt"
        case .aiMCPServersEnableMCPServers: "Enable MCP servers"
        case .aiMCPServersAddMCPServer: "Add MCP Server"
        case .quickActionsQuickActionsEnableQuickActions: "Enable Quick Actions"
        case .quickActionsActionsAddQuickAction: "Add Quick Action"
        case .quickActionsModelModel: "Model"
        case .quickActionsTranslateTranslateTo: "Translate to"
        case .dictationDictationEnableDictation: "Enable Dictation"
        case .dictationCommandsShortcutBehavior: "Shortcut behavior"
        case .dictationCommandsShortcut: "Shortcut"
        case .dictationModelModel: "Model"
        case .dictationModelEngine: "Engine"
        case .dictationModelLanguage: "Language"
        case .dictationMemoryReleaseModelFromMemory: "Release model from memory"
        case .dictationOutputMicrophone: "Microphone"
        case .dictationOutputWhenFinished: "When finished"
        case .dictationOutputAdaptCapitalization: "Adapt capitalization"
        case .fileSearchFileSearchEnableFileSearch: "Enable File Search"
        case .fileSearchFullDiskAccessPermission: "Full Disk Access"
        case .fileSearchIndexIndexedItems: "Indexed Items"
        case .notesNotesEnableNotes: "Enable Notes"
        case .notesOptionsRenderMarkdown: "Render Markdown"
        case .notesOptionsShowFormattingBar: "Show Formatting Bar"
        case .notesOptionsNotesFolder: "Notes Folder"
        case .snippetsSnippetsEnableSnippets: "Enable snippets"
        case .snippetsLibraryNewSnippet: "New Snippet"
        case .snippetsLibrarySnippetsFolder: "Snippets Folder"
        case .navigationNavigationEnableNavigation: "Enable navigation"
        case .navigationMenuSearchShowAppleMenuItems: "Show Apple menu items"
        case .navigationMenuSearchDisabledApplications: "Disabled Applications"
        case .windowManagementWindowManagementEnableWindowManagement: "Enable window management"
        case .windowManagementOptionsCycling: "Cycling"
        case .windowManagementOptionsGapBetweenWindows: "Gap between windows"
        case .windowManagementOptionsShortcutPreset: "Shortcut preset"
        case .windowManagementLayoutsShowLayoutsInLauncher: "Show layouts in launcher"
        case .windowManagementLayoutsNewLayout: "New Layout"
        case .windowManagementLayoutsCreateLayoutFromCurrentWindows: "Create Layout from Current Windows"
        case .windowManagementRoomsShowRoomsInLauncher: "Show rooms in launcher"
        case .windowManagementRoomsNewRoom: "New Room"
        case .windowManagementCustomSizesNewCustomSize: "New Custom Size"
        case .clipboardClipboardEnableClipboardHistory: "Enable Clipboard History"
        case .clipboardHistoryKeepHistoryFor: "Keep history for"
        case .clipboardHistorySearchTextInImagesAndPDFs: "Search text in images and PDFs"
        case .clipboardHistoryDefaultAction: "Default action"
        case .clipboardDisabledApplicationsClearHistory: "Clear history"
        case .emojiAppearanceEmojiSkinTone: "Emoji Skin Tone"
        case .emojiAppearanceColumnCount: "Column Count"
        case .calendarCalendarJoinMeetingsFromTinycast: "Join meetings from Tinycast"
        case .calendarCalendarUpcomingMeetingsInLauncher: "Upcoming meetings in launcher"
        case .calendarJoiningShowTheJoinCard: "Show the join card"
        case .calendarJoiningAutoJoinMeetings: "Auto Join Meetings"
        case .calendarJoiningOnlyJoinKnownMeetingServices: "Only join known meeting services"
        case .calendarJoiningConfirmBeforeJoining: "Confirm before joining"
        case .calendarJoiningCameraPreview: "Camera Preview"
        case .calendarJoiningOpenMeetingLinksIn: "Open Meeting Links In"
        case .calendarMenuBarCalendarInMenuBar: "Calendar in Menu Bar"
        case .calendarMenuBarDaysToShow: "Days to Show"
        case .calendarMenuBarShowUpcomingEvents: "Show Upcoming Events"
        case .calendarMenuBarOnlyShowEventsWithMeetings: "Only show events with meetings"
        case .calendarMenuBarHideWhenThereAreNoUpcomingEvents: "Hide when there are no upcoming events"
        case .calendarMenuBarHideCurrentEvent: "Hide Current Event"
        case .extensionsExtensionsEnableExtensions: "Enable extensions"
        case .extensionsInstallSearchExtensions: "Search extensions"
        case .extensionsInstallInstallFromGitHub: "Install from GitHub"
        case .extensionsInstallImportFromRaycast: "Import from Raycast"
        case .extensionsInstallAddFromFolder: "Add from folder"
        case .extensionsStorageLeftoverFiles: "Leftover files"
        case .permissionsAccessibilityAccessibility: "Accessibility"
        case .permissionsCalendarsCalendars: "Calendars"
        case .permissionsMicrophoneMicrophone: "Microphone"
        case .backupExportExportBackup: "Export Backup"
        case .backupImportBackupFile: "Backup File"
        case .backupImportFromRaycastRaycastExport: "Raycast Export"
        case .backupSettingsFileSyncSettingsFile: "Sync settings file"
        case .aboutAboutCheckForUpdates: "Check for Updates"
        case .aboutLinksSupport: "Support"
        }
    }

    var title: String { String(localized: titleResource) }
}

import Foundation

extension UpdateReadiness.Blocker {
    var message: String {
        switch self {
        case .expandingSnippet: return String(localized: "Waiting for a snippet to finish expanding.")
        case .runningExtension: return String(localized: "Waiting for a running extension command to finish.")
        case .uninstalling: return String(localized: "Waiting for the uninstaller to finish.")
        case .recordingHotKey: return String(localized: "Finish recording the shortcut first.")
        case .dialogOpen: return String(localized: "Close the open dialog first.")
        case .paletteOpen: return String(localized: "Close Tinycast's window first.")
        }
    }
}

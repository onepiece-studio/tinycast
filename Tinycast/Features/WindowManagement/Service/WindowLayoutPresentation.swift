import Foundation

extension WindowLayoutValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyName: return String(localized: "Enter a name for the layout.")
        case .duplicateName: return String(localized: "A window layout with this name already exists.")
        case .noEntries: return String(localized: "Add at least one app to the layout.")
        case .invalidCharacter: return String(localized: "Names cannot contain null characters.")
        }
    }
}

extension WindowLayout {
    var summary: String {
        let displays = Set(entries.map(\.display.uuid)).count
        let windows =
            entries.count == 1 ? String(localized: "1 window") : String(localized: "\(entries.count) windows")
        return displays > 1 ? String(localized: "\(windows) · \(displays) displays") : windows
    }
}

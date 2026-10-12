import Foundation

extension UninstallEvidence {
    var label: String? {
        switch self {
        case .displayName: return String(localized: "matched by name")
        case .binSymlink: return String(localized: "command-line tool")
        case .bundle, .bundleID, .groupContainer: return nil
        }
    }
}

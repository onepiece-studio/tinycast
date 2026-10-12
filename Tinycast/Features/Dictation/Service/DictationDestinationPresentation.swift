import Foundation

extension DictationDestination {
    var title: String {
        switch self {
        case .paste: String(localized: "Paste in active app")
        case .copy: String(localized: "Copy to clipboard")
        case .both: String(localized: "Paste and copy")
        }
    }
}

import Foundation

extension WindowShortcutPreset {
    var title: String {
        switch self {
        case .rectangle: String(localized: "Rectangle / Magnet")
        case .spectacle: String(localized: "Spectacle")
        }
    }
}

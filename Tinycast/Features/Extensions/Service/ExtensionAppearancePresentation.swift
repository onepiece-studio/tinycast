import Foundation

extension ExtensionTint {
    var title: String {
        switch self {
        case .tan: return String(localized: "Light Brown", table: "Extensions")
        case .maroon: return String(localized: "Maroon", table: "Extensions")
        case .slate: return String(localized: "Slate", table: "Extensions")
        default: return rawValue.capitalized
        }
    }
}

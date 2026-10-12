import Foundation

extension CustomWindowSizeValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyName: return String(localized: "Enter a name for the size.")
        case .duplicateName: return String(localized: "A custom size with this name already exists.")
        case .invalidCharacter: return String(localized: "Names cannot contain null characters.")
        }
    }
}

extension CustomWindowSize {
    var summary: String {
        let base = String(localized: "\(width.label) × \(height.label) · \(anchor.title)")
        return offset == .zero ? base : String(localized: "\(base) · Offset \(offset.x), \(offset.y) pt")
    }
}

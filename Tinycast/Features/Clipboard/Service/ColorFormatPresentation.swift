import Foundation

extension ColorFormat {
    var title: String {
        switch self {
        case .hex: return String(localized: "Hex")
        case .hexWithAlpha: return String(localized: "Hex with Alpha")
        case .rgba: return String(localized: "RGBA")
        case .hsl: return String(localized: "HSL")
        case .hslWithAlpha: return String(localized: "HSL with Alpha")
        case .oklch: return String(localized: "Oklch")
        }
    }
}

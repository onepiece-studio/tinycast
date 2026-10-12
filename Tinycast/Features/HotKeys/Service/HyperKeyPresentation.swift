import Foundation

extension HyperKeyPhysicalKey {
    var title: String {
        switch self {
        case .none: return String(localized: "None")
        case .capsLock: return String(localized: "Caps Lock (⇪)")
        case .leftControl: return String(localized: "Left Control (⌃)")
        case .leftShift: return String(localized: "Left Shift (⇧)")
        case .leftOption: return String(localized: "Left Option (⌥)")
        case .leftCommand: return String(localized: "Left Command (⌘)")
        case .rightControl: return String(localized: "Right Control (⌃)")
        case .rightShift: return String(localized: "Right Shift (⇧)")
        case .rightOption: return String(localized: "Right Option (⌥)")
        case .rightCommand: return String(localized: "Right Command (⌘)")
        }
    }
}

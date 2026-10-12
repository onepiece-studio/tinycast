import Foundation

extension RoomLayoutKind {
    var title: String {
        switch self {
        case .auto: String(localized: "Auto")
        case .focus: String(localized: "Focus")
        case .stack: String(localized: "Stack")
        case .columns: String(localized: "Columns")
        case .grid: String(localized: "Grid")
        case .custom: String(localized: "Custom")
        case .saved: String(localized: "As Arranged")
        }
    }
}

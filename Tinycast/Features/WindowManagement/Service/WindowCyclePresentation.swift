import Foundation

extension WindowCycle {
    var title: String {
        switch self {
        case .off: String(localized: "None")
        case .sizes: String(localized: "Cycle ½, ⅓ and ⅔")
        case .displays: String(localized: "Cycle displays")
        }
    }

    var detail: String {
        switch self {
        case .off: String(localized: "Repeating a half keeps the same frame.")
        case .sizes: String(localized: "Repeating a half steps through ⅓ and ⅔.")
        case .displays: String(localized: "Repeating a half moves it across your displays.")
        }
    }
}

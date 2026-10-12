import Foundation

extension CalcNumberStyle {
    var title: String {
        switch self {
        case .system: String(localized: "System")
        case .english: String(localized: "English")
        }
    }
}

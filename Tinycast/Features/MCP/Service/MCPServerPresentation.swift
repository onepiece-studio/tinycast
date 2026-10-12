import Foundation

extension MCPTrust {
    var title: String {
        switch self {
        case .ask: return String(localized: "Ask Each Chat")
        case .always: return String(localized: "Always Allow")
        case .never: return String(localized: "Never Allow")
        }
    }
}

import Foundation

extension ChatGPTSubscription.Effort {
    var title: String {
        switch id {
        case "xhigh": return String(localized: "Extra high")
        case "minimal": return String(localized: "Minimal")
        case "low": return String(localized: "Low")
        case "medium": return String(localized: "Medium")
        case "high": return String(localized: "High")
        default: return id.prefix(1).uppercased() + id.dropFirst()
        }
    }
}

import Foundation

extension AINewChatAfter {
    var title: String {
        self == .never ? String(localized: "Never") : String(localized: "\(rawValue) Minutes")
    }
}

extension AIOpensTo {
    var title: String {
        switch self {
        case .recent: return String(localized: "Recent Conversation")
        case .newConversation: return String(localized: "A New Conversation")
        }
    }
}

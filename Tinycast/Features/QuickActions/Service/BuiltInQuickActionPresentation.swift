import Foundation

extension BuiltInQuickAction {
    var localizedTitle: String {
        switch self {
        case .fixGrammar: return String(localized: "Fix Grammar")
        case .rewrite: return String(localized: "Rewrite")
        case .translate: return String(localized: "Translate")
        case .summarize: return String(localized: "Summarize")
        }
    }

    var localizedProgressTitle: String {
        switch self {
        case .fixGrammar: return String(localized: "Fixing Grammar…")
        case .rewrite: return String(localized: "Rewriting…")
        case .translate: return String(localized: "Translating…")
        case .summarize: return String(localized: "Summarizing…")
        }
    }
}

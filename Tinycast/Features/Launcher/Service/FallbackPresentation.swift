import Foundation

extension Fallback {
    var openVerb: String {
        switch self {
        case .builtin(.quickAI): return String(localized: "Ask Quick AI")
        case .builtin(.searchFiles): return String(localized: "Search Files")
        case .builtin(.runShellCommand): return String(localized: "Run Shell Command")
        case .builtin(.define): return String(localized: "Define Word")
        case .quicklink: return String(localized: "Open Quicklink")
        }
    }
}

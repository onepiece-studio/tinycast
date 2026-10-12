import Foundation

/// Mirrors the FoundationModels enum, which lives in `Service/` so this stays Foundation-only.
enum AppleIntelligenceStatus: Equatable, Sendable {
    case available
    case deviceNotEligible
    case notEnabled
    case modelNotReady

    var isAvailable: Bool { self == .available }
}

enum AppleIntelligence {
    /// Ours rather than a vendor's: this route names no remote model to borrow an id from.
    static let modelID = "apple-intelligence"
    static let title = "Apple Intelligence"

    /// The on-device window holds prompt and reply together, so each leaves room for the other.
    static let contextBudget = 6_000
    static let maxOutputTokens = 1_024
}

/// FoundationModels reports the whole answer so far; every other transport speaks in deltas.
struct AppleIntelligenceDelta {
    private var emitted = ""

    /// The whole snapshot when the model revised what it wrote, since no prefix survives to drop.
    mutating func delta(from snapshot: String) -> String {
        defer { emitted = snapshot }
        guard snapshot.hasPrefix(emitted) else { return snapshot }
        return String(snapshot.dropFirst(emitted.count))
    }
}

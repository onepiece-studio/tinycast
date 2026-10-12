import Foundation

extension AppleIntelligenceStatus {
    var message: String? {
        switch self {
        case .available:
            return nil
        case .deviceNotEligible:
            return String(localized: "This Mac does not support Apple Intelligence.")
        case .notEnabled:
            return String(localized: "Turn on Apple Intelligence in System Settings to chat on device.")
        case .modelNotReady:
            return String(localized: "Apple Intelligence is still downloading its model. Try again shortly.")
        }
    }
}

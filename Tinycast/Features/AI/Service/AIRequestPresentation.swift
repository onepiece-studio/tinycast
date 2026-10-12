import Foundation

extension AIProviderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unavailable(let message), .responseFailed(let message): return message
        case .malformedResponse: return String(localized: "The provider returned malformed streaming data.")
        }
    }
}

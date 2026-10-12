import Foundation

extension DictationIdleRelease {
    var title: String {
        switch self {
        case .never: String(localized: "Never")
        case .oneMinute: String(localized: "1 minute")
        case .oneHour: String(localized: "1 hour")
        default: String(localized: "\(rawValue) minutes")
        }
    }
}

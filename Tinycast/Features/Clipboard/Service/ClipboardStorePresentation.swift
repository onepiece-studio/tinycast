import Foundation

extension ClipboardDefaultAction {
    var title: String {
        switch self {
        case .paste: return String(localized: "Paste")
        case .copy: return String(localized: "Copy to Clipboard")
        case .pastePlainText: return String(localized: "Paste as Plain Text")
        }
    }
}

extension ClipboardRetention {
    var title: String {
        switch self {
        case .day: return String(localized: "1 Day")
        case .week: return String(localized: "1 Week")
        case .month: return String(localized: "1 Month")
        case .threeMonths: return String(localized: "3 Months")
        case .sixMonths: return String(localized: "6 Months")
        case .year: return String(localized: "1 Year")
        case .forever: return String(localized: "Forever")
        }
    }
}

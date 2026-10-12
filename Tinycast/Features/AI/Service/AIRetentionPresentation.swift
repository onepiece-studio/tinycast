import Foundation

extension AIRetention {
    var title: String {
        switch self {
        case .week: return String(localized: "7 Days")
        case .month: return String(localized: "30 Days")
        case .threeMonths: return String(localized: "3 Months")
        case .forever: return String(localized: "Forever")
        }
    }
}

import Foundation

extension QuickAction {
    var localizedTitle: String {
        switch self {
        case .builtIn(let action): action.localizedTitle
        case .custom(let action): action.name
        }
    }

    var localizedProgressTitle: String {
        switch self {
        case .builtIn(let action): action.localizedProgressTitle
        case .custom(let action): String(localized: "\(action.name)…")
        }
    }
}

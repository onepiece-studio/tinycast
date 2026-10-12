import Foundation

extension WindowLayoutAnchor {
    var title: String {
        switch self {
        case .topLeft: return String(localized: "Top Left")
        case .top: return String(localized: "Top")
        case .topRight: return String(localized: "Top Right")
        case .left: return String(localized: "Left")
        case .center: return String(localized: "Center")
        case .right: return String(localized: "Right")
        case .bottomLeft: return String(localized: "Bottom Left")
        case .bottom: return String(localized: "Bottom")
        case .bottomRight: return String(localized: "Bottom Right")
        }
    }
}

import Foundation

extension WindowCommand {
    var localizedName: String {
        switch id {
        case .leftHalf: return String(localized: "Left Half")
        case .rightHalf: return String(localized: "Right Half")
        case .topHalf: return String(localized: "Top Half")
        case .bottomHalf: return String(localized: "Bottom Half")
        case .topLeftQuarter: return String(localized: "Top Left Quarter")
        case .topRightQuarter: return String(localized: "Top Right Quarter")
        case .bottomLeftQuarter: return String(localized: "Bottom Left Quarter")
        case .bottomRightQuarter: return String(localized: "Bottom Right Quarter")
        case .firstThreeFourths: return String(localized: "First Three Fourths")
        case .lastThreeFourths: return String(localized: "Last Three Fourths")
        case .firstThird: return String(localized: "First Third")
        case .centerThird: return String(localized: "Center Third")
        case .lastThird: return String(localized: "Last Third")
        case .firstTwoThirds: return String(localized: "First Two Thirds")
        case .lastTwoThirds: return String(localized: "Last Two Thirds")
        case .maximize: return String(localized: "Maximize")
        case .almostMaximize: return String(localized: "Almost Maximize")
        case .reasonableSize: return String(localized: "Reasonable Size")
        case .maximizeHeight: return String(localized: "Maximize Height")
        case .maximizeWidth: return String(localized: "Maximize Width")
        case .center: return String(localized: "Center")
        case .centerHalf: return String(localized: "Center Half")
        case .centerTwoThirds: return String(localized: "Center Two Thirds")
        case .makeLarger: return String(localized: "Make Larger")
        case .makeSmaller: return String(localized: "Make Smaller")
        case .restore: return String(localized: "Restore Window")
        case .moveLeft: return String(localized: "Move Left")
        case .moveRight: return String(localized: "Move Right")
        case .moveUp: return String(localized: "Move Up")
        case .moveDown: return String(localized: "Move Down")
        case .nextDisplay: return String(localized: "Move to Next Display")
        case .previousDisplay: return String(localized: "Move to Previous Display")
        case .toggleFullscreen: return String(localized: "Toggle Fullscreen")
        case .previousSpace: return String(localized: "Switch to Previous Space")
        case .nextSpace: return String(localized: "Switch to Next Space")
        }
    }
}

extension WindowCommand.Group {
    var title: String {
        switch self {
        case .halves: return String(localized: "Halves")
        case .quarters: return String(localized: "Quarters")
        case .fourths: return String(localized: "Fourths")
        case .thirds: return String(localized: "Thirds")
        case .sizing: return String(localized: "Sizing")
        case .moving: return String(localized: "Moving")
        case .fullscreen: return String(localized: "Fullscreen")
        case .spaces: return String(localized: "Spaces")
        }
    }
}

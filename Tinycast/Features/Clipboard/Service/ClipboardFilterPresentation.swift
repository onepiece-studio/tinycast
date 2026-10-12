import Foundation

extension ClipboardFilter {
    var title: String {
        switch self {
        case .all: return String(localized: "All Types")
        case .text: return String(localized: "Text Only")
        case .image: return String(localized: "Images Only")
        case .file: return String(localized: "Files Only")
        case .color: return String(localized: "Colors Only")
        case .link: return String(localized: "Links Only")
        case .email: return String(localized: "Emails Only")
        }
    }

    var emptyMessage: String {
        switch self {
        case .all: return String(localized: "Clipboard history is empty")
        case .text: return String(localized: "No text in clipboard history")
        case .image: return String(localized: "No images in clipboard history")
        case .file: return String(localized: "No files in clipboard history")
        case .color: return String(localized: "No colors in clipboard history")
        case .link: return String(localized: "No links in clipboard history")
        case .email: return String(localized: "No email addresses in clipboard history")
        }
    }
}

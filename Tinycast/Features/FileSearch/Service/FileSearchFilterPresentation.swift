import Foundation

extension FileSearchFilter {
    var title: String {
        switch self {
        case .all: return String(localized: "All Types")
        case .folders: return String(localized: "Folders")
        case .documents: return String(localized: "Documents")
        case .images: return String(localized: "Images")
        case .audio: return String(localized: "Audio")
        case .video: return String(localized: "Videos")
        case .archives: return String(localized: "Archives")
        }
    }

    var emptyMessage: String {
        switch self {
        case .all: return String(localized: "No files found")
        case .folders: return String(localized: "No folders found")
        case .documents: return String(localized: "No documents found")
        case .images: return String(localized: "No images found")
        case .audio: return String(localized: "No audio found")
        case .video: return String(localized: "No videos found")
        case .archives: return String(localized: "No archives found")
        }
    }
}

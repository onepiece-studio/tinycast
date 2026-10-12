import Foundation

extension ClipboardFileKind {
    var title: String {
        switch self {
        case .image: return String(localized: "Image")
        case .movie: return String(localized: "Movie")
        case .audio: return String(localized: "Audio")
        case .pdf: return String(localized: "PDF")
        case .folder: return String(localized: "Folder")
        case .other: return String(localized: "File")
        }
    }
}

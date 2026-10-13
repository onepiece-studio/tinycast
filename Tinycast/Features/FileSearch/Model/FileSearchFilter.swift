import Foundation
import UniformTypeIdentifiers

/// The Search Files header filter. See docs/features/file-search.md#type-filter.
enum FileSearchFilter: CaseIterable, Sendable {
    case all
    case folders
    case documents
    case images
    case audio
    case video
    case archives

    /// Also the header button's glyph, so it states the active filter without opening the menu.
    var systemImage: String {
        switch self {
        case .all: return "list.bullet"
        case .folders: return "folder"
        case .documents: return "doc.text"
        case .images: return "photo"
        case .audio: return "waveform"
        case .video: return "film"
        case .archives: return "archivebox"
        }
    }

    /// The types a case admits; `all` names none, which is what keeps an unfiltered search free.
    var contentTypes: [UTType] {
        switch self {
        case .all: return []
        case .folders: return [.folder]
        case .documents: return [.text, .compositeContent, .spreadsheet, .presentation, .pdf]
        case .images: return [.image]
        case .audio: return [.audio]
        case .video: return [.movie]
        case .archives: return [.archive]
        }
    }

    func accepts(contentType: UTType?, isDirectory: Bool) -> Bool {
        guard self != .all else { return true }
        // An unresolved type is only ever a plain directory: everything else carries one.
        guard let contentType else { return self == .folders && isDirectory }
        return contentTypes.contains { contentType.conforms(to: $0) }
    }

    /// The index records no type, and a stat per row would cost more than the extension.
    static func contentType(extension pathExtension: String, isDirectory: Bool) -> UTType? {
        guard !pathExtension.isEmpty else { return isDirectory ? .folder : nil }
        guard isDirectory else { return UTType(filenameExtension: pathExtension) }
        // A folder named `v1.2` is still a folder; only a declared package is a document.
        let package = UTType(filenameExtension: pathExtension, conformingTo: .package)
        return package.flatMap { $0.isDeclared ? $0 : nil } ?? .folder
    }
}

import Foundation

extension SnippetMarkdownSerializer.ParseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidFrontmatter(let fileURL, let line, let reason):
            return String(localized: "\(fileURL.path):\(line): \(reason)")
        }
    }
}

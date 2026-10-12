import Foundation

extension ExtensionGitHubSource {
    var summary: String {
        let location = [owner, repository, path].filter { !$0.isEmpty }.joined(separator: "/")
        return ref == Self.defaultRef
            ? String(localized: "\(location) on its default branch", table: "Extensions")
            : String(localized: "\(location) at \(ref)", table: "Extensions")
    }
}

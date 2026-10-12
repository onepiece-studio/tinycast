import Foundation

extension BackupCategory {
    var title: String {
        switch self {
        case .configuration: String(localized: "Settings & Shortcuts")
        case .clipboard: String(localized: "Clipboard History")
        case .snippets: String(localized: "Snippets")
        case .notes: String(localized: "Notes")
        case .learning: String(localized: "Launcher Learning")
        }
    }

    func countLabel(_ count: Int) -> String? {
        switch self {
        case .configuration: nil
        case .clipboard: String(localized: "\(count) clips")
        case .snippets: String(localized: "\(count) snippets")
        case .notes: String(localized: "\(count) notes")
        case .learning: String(localized: "\(count) records")
        }
    }
}

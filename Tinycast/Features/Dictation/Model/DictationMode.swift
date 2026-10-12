import Foundation

enum DictationMode: String, CaseIterable, Identifiable, Sendable {
    case pushToTalk
    case toggle

    var id: Self { self }
}

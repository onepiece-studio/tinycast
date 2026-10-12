import Foundation

enum DictationDestination: String, CaseIterable, Identifiable, Sendable {
    case paste
    case copy
    case both

    var id: Self { self }

    var pastes: Bool { self != .copy }
    var copies: Bool { self != .paste }
}

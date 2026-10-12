import Foundation

/// What a repeat press of a half does. docs/features/window-management.md#cycling-and-restore
enum WindowCycle: String, CaseIterable, Identifiable, Sendable {
    /// Re-apply the same half — the shortcut is idempotent.
    case off
    /// Step the half through ⅓ and ⅔ before it returns to ½.
    case sizes
    /// Walk the half one slot along the strip of half-slots every display contributes.
    case displays

    var id: String { rawValue }
}

import Foundation

extension UninstallProtection {
    var lockReason: String? {
        switch self {
        case .removable:
            return nil
        case .systemProtected:
            return String(localized: "Part of macOS and protected by the system.")
        case .userLocked:
            return String(localized: "Locked in Finder. Unlock it in Get Info, then try again.")
        case .notOwned:
            return String(
                localized: "Owned by another user, in a folder that only lets owners remove things.")
        case .needsFullDiskAccess:
            return String(
                localized:
                    "Needs Full Disk Access, which Tinycast doesn’t request. Grant it in System Settings › Privacy & Security to include this item."
            )
        case .parentNotWritable:
            return String(
                localized:
                    "Its enclosing folder isn’t writable by you, and Tinycast never asks for an administrator password."
            )
        case .missing:
            return String(localized: "No longer on disk.")
        }
    }
}

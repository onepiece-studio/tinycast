import Foundation

extension ExtensionPackageManager {
    var title: String {
        switch self {
        case .automatic: return String(localized: "Automatic", table: "Extensions")
        case .pnpm: return String(localized: "pnpm", table: "Extensions")
        case .npm: return String(localized: "npm", table: "Extensions")
        case .yarn: return String(localized: "Yarn", table: "Extensions")
        case .bun: return String(localized: "Bun", table: "Extensions")
        }
    }
}

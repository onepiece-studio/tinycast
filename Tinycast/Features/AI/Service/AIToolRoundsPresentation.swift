import Foundation

extension AIToolRounds {
    var title: String { limit.map { "\($0)" } ?? String(localized: "Unlimited") }
}

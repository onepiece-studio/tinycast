import Foundation

extension DictationModel {
    var title: String { String(localized: "\(family.rawValue) · \(variantTitle)") }

    var summary: String {
        switch self {
        case .redux: String(localized: "Lightweight and efficient.")
        case .ultra: String(localized: "Higher accuracy, larger download.")
        case .qwenSmall: String(localized: "Smaller and faster.")
        case .qwenLarge: String(localized: "Higher accuracy, more memory.")
        }
    }

    var coverage: String {
        switch self {
        case .ultra, .redux: String(localized: "25 languages")
        case .qwenSmall, .qwenLarge: String(localized: "30 languages and 22 Chinese dialects")
        }
    }
}

extension DictationModel.Family {
    var summary: String {
        self == .parakeet
            ? String(localized: "Fast and memory-efficient") : String(localized: "More languages, but slower")
    }
}

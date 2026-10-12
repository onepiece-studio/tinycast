import Foundation

extension EmojiSkinTone {
    var title: String {
        switch self {
        case .none: return String(localized: "Default")
        case .light:
            return String(
                localized: "emoji.skinTone.light", defaultValue: "Light", comment: "Emoji skin tone")
        case .mediumLight:
            return String(
                localized: "emoji.skinTone.mediumLight", defaultValue: "Medium Light",
                comment: "Emoji skin tone")
        case .medium:
            return String(
                localized: "emoji.skinTone.medium", defaultValue: "Medium", comment: "Emoji skin tone")
        case .mediumDark:
            return String(
                localized: "emoji.skinTone.mediumDark", defaultValue: "Medium Dark",
                comment: "Emoji skin tone")
        case .dark:
            return String(localized: "emoji.skinTone.dark", defaultValue: "Dark", comment: "Emoji skin tone")
        }
    }
}

extension EmojiGridColumns {
    var title: String { String(localized: "\(rawValue) columns") }
}

extension EmojiCategoryFilter {
    var title: String {
        switch self {
        case .all: String(localized: "All Categories")
        case .pinned: String(localized: "Pinned")
        case .frequentlyUsed: String(localized: "Frequently Used")
        case .category(let category): category.title
        }
    }
}

extension EmojiCategory {
    var title: String {
        switch self {
        case .smileysAndPeople: return String(localized: "Smileys & People")
        case .animalsAndNature: return String(localized: "Animals & Nature")
        case .foodAndDrink: return String(localized: "Food & Drink")
        case .activity: return String(localized: "Activity")
        case .travelAndPlaces: return String(localized: "Travel & Places")
        case .objects: return String(localized: "Objects")
        case .symbols: return String(localized: "Symbols")
        case .flags: return String(localized: "Flags")
        case .arrows: return String(localized: "Arrows")
        case .currency: return String(localized: "Currency")
        case .math: return String(localized: "Math")
        case .shapesAndPunctuation: return String(localized: "Shapes & Punctuation")
        case .cjk: return String(localized: "CJK Symbols")
        case .keysAndTechnical: return String(localized: "Keys & Technical")
        }
    }
}

import Foundation

extension DictationLanguage {
    var title: String {
        switch self {
        case .arabic: String(localized: "Arabic")
        case .cantonese: String(localized: "Cantonese")
        case .chinese: String(localized: "Chinese")
        case .czech: String(localized: "Czech")
        case .danish: String(localized: "Danish")
        case .dutch: String(localized: "Dutch")
        case .english: String(localized: "English")
        case .filipino: String(localized: "Filipino")
        case .finnish: String(localized: "Finnish")
        case .french: String(localized: "French")
        case .german: String(localized: "German")
        case .greek: String(localized: "Greek")
        case .hindi: String(localized: "Hindi")
        case .hungarian: String(localized: "Hungarian")
        case .indonesian: String(localized: "Indonesian")
        case .italian: String(localized: "Italian")
        case .japanese: String(localized: "Japanese")
        case .korean: String(localized: "Korean")
        case .macedonian: String(localized: "Macedonian")
        case .malay: String(localized: "Malay")
        case .persian: String(localized: "Persian")
        case .polish: String(localized: "Polish")
        case .portuguese: String(localized: "Portuguese")
        case .romanian: String(localized: "Romanian")
        case .russian: String(localized: "Russian")
        case .spanish: String(localized: "Spanish")
        case .swedish: String(localized: "Swedish")
        case .thai: String(localized: "Thai")
        case .turkish: String(localized: "Turkish")
        case .vietnamese: String(localized: "Vietnamese")
        }
    }
}

import Foundation

extension DictationMode {
    var title: String {
        self == .pushToTalk ? String(localized: "Hold to talk") : String(localized: "Press to start or stop")
    }
}

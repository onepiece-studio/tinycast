import Foundation

extension MeetingLink.Provider {
    var title: String {
        switch self {
        case .zoom: return String(localized: "Zoom")
        case .googleMeet: return String(localized: "Google Meet")
        case .teams: return String(localized: "Microsoft Teams")
        case .webex: return String(localized: "Webex")
        case .jitsi: return String(localized: "Jitsi")
        case .whereby: return String(localized: "Whereby")
        case .chime: return String(localized: "Amazon Chime")
        case .gotoMeeting: return String(localized: "GoTo Meeting")
        case .blueJeans: return String(localized: "BlueJeans")
        case .skype: return String(localized: "Skype")
        case .generic: return String(localized: "Meeting Link")
        }
    }
}

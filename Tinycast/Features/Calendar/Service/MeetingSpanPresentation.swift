import Foundation

extension MeetingSpan {
    var title: String {
        switch self {
        case .today: return String(localized: "Today")
        case .todayAndTomorrow: return String(localized: "Today and Tomorrow")
        case .nextSevenDays: return String(localized: "Next 7 Days")
        }
    }

    var settingsSubtitle: String {
        switch self {
        case .today: String(localized: "Reads today's events for join links. Nothing leaves this Mac.")
        case .todayAndTomorrow:
            String(localized: "Reads today's and tomorrow's events for join links. Nothing leaves this Mac.")
        case .nextSevenDays:
            String(localized: "Reads the next 7 days' events for join links. Nothing leaves this Mac.")
        }
    }

    var permissionMessage: String {
        switch self {
        case .today:
            String(localized: "Tinycast reads today's events to find join links. Nothing leaves this Mac.")
        case .todayAndTomorrow:
            String(
                localized:
                    "Tinycast reads today's and tomorrow's events to find join links. Nothing leaves this Mac."
            )
        case .nextSevenDays:
            String(
                localized:
                    "Tinycast reads the next 7 days' events to find join links. Nothing leaves this Mac.")
        }
    }

    var emptyScheduleMessage: String {
        switch self {
        case .today: String(localized: "Nothing scheduled today")
        case .todayAndTomorrow: String(localized: "Nothing scheduled today or tomorrow")
        case .nextSevenDays: String(localized: "Nothing scheduled in the next 7 days")
        }
    }
}

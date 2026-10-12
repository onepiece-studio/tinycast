import Foundation

extension SystemAction {
    var localizedName: String {
        switch id {
        case .lockScreen: return String(localized: "Lock Screen")
        case .sleep: return String(localized: "Sleep")
        case .sleepDisplays: return String(localized: "Sleep Displays")
        case .restart: return String(localized: "Restart")
        case .shutDown: return String(localized: "Shut Down")
        case .logOut: return String(localized: "Log Out")
        case .showScreenSaver: return String(localized: "Show Screen Saver")
        case .playPause: return String(localized: "Play / Pause")
        case .nextTrack: return String(localized: "Next Track")
        case .previousTrack: return String(localized: "Previous Track")
        case .toggleMute: return String(localized: "Toggle Mute")
        case .toggleMicrophoneMute: return String(localized: "Toggle Microphone Mute")
        case .volumeUp: return String(localized: "Turn Volume Up")
        case .volumeDown: return String(localized: "Turn Volume Down")
        case .setVolume: return String(localized: "Set Volume…")
        case .volume0: return String(localized: "Set Volume to 0%")
        case .volume25: return String(localized: "Set Volume to 25%")
        case .volume50: return String(localized: "Set Volume to 50%")
        case .volume75: return String(localized: "Set Volume to 75%")
        case .volume100: return String(localized: "Set Volume to 100%")
        case .showDesktop: return String(localized: "Show Desktop")
        case .toggleAppearance: return String(localized: "Toggle System Appearance")
        case .toggleStageManager: return String(localized: "Toggle Stage Manager")
        case .openTrash: return String(localized: "Open Trash")
        case .emptyTrash: return String(localized: "Empty Trash")
        case .ejectAllDisks: return String(localized: "Eject All Disks")
        case .toggleHiddenFiles: return String(localized: "Toggle Hidden Files")
        case .hideOtherApps: return String(localized: "Hide All Apps Except Frontmost")
        case .unhideAllApps: return String(localized: "Unhide All Hidden Apps")
        case .quitAllApps: return String(localized: "Quit All Applications")
        case .dismissNotifications: return String(localized: "Dismiss Notifications")
        case .toggleBluetooth: return String(localized: "Toggle Bluetooth")
        }
    }

    var localizedConfirmation: Confirmation {
        let message = String(localized: "Applications with unsaved changes may ask you to save.")
        switch id {
        case .restart: return .required(title: String(localized: "Restart your Mac?"), message: message)
        case .shutDown: return .required(title: String(localized: "Shut down your Mac?"), message: message)
        case .logOut: return .required(title: String(localized: "Log out now?"), message: message)
        case .emptyTrash:
            return .followsFinder(
                title: String(localized: "Empty Trash?"),
                message: String(localized: "The items in the Trash will be permanently deleted."))
        case .quitAllApps: return .computed
        default: return .none
        }
    }
}

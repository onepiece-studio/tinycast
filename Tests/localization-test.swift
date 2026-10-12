import Foundation

@main
struct LocalizationTests {
    static func main() {
        let chinese = CommandLine.arguments.contains("zh-Hans")
        var failures = 0
        func expect(_ condition: Bool, _ message: String) {
            if !condition {
                failures += 1
                print("FAIL: \(message)")
            }
        }
        expect(
            SettingsTab.general.title == (chinese ? "通用" : "General"),
            "the main bundle selects the app language")
        expect(
            CommandID.clipboardHistory.rawValue == "command:clipboard-history",
            "command identity is language independent")
        expect(CommandID.clipboardHistory.name == "Clipboard History", "English names remain search aliases")
        expect(
            CommandID.clipboardHistory.localizedName == (chinese ? "剪贴板历史" : "Clipboard History"),
            "command names localize")
        let row = SettingsSearchEntry(.generalGeneralLaunchAtLogin)
        expect(row.id == "row/generalGeneralLaunchAtLogin", "row identity is independent of its title")
        expect(row.target == .row(.generalGeneralLaunchAtLogin), "search and scrolling share one target")
        expect(
            SettingsSearchCatalog.results(for: "Clipboard History").contains { $0.tab == .clipboard },
            "English search works")
        if chinese {
            expect(SettingsSearchCatalog.results(for: "剪贴板").first?.tab == .clipboard, "Chinese search works")
            expect(
                SettingsSearchCatalog.results(for: "开机").contains { $0.tab == .general },
                "Chinese setting search works")
        }
        expect(
            Set(SettingsSearchCatalog.entries.map(\.id)).count == SettingsSearchCatalog.entries.count,
            "search identities are unique")
        let extensionTitle = String(localized: "Checkbox", table: "Extensions")
        expect(extensionTitle == (chinese ? "复选框" : "Checkbox"), "extension host uses its own table")
        let count = 1
        expect(
            String(localized: "\(count) models") == (chinese ? "1 个模型" : "1 model"),
            "English singular and Chinese count format")
        let many = 3
        expect(String(localized: "\(many) models") == (chinese ? "3 个模型" : "3 models"), "plural count format")
        let name = "Studio Display"
        expect(
            String(localized: "\(name) · not connected")
                == (chinese ? "Studio Display · 未连接" : "Studio Display · not connected"),
            "interpolation preserves user text")
        expect(
            CalculatorPresentation.badge("Kilograms") == (chinese ? "千克" : "Kilograms"),
            "calculator unit badges localize")
        expect(
            CalculatorPresentation.badge("2026-10-12") == "2026-10-12",
            "formatted calculator labels stay literal")
        if !chinese {
            expect(
                CalculatorPresentation.badge("UAE Dirham") == "UAE Dirham",
                "English currency names keep their canonical spelling")
        }
        let microphone = Bundle.main.localizedInfoDictionary?["NSMicrophoneUsageDescription"] as? String
        expect(
            microphone?.contains(chinese ? "听写" : "Dictation") == true,
            "localized permission text is packaged")
        print("Localization \(chinese ? "zh-Hans" : "en/fallback"): \(failures) failures")
        if failures > 0 { exit(1) }
    }
}

enum HotKeyAction: Sendable {
    case command(CommandID)
}

enum Quicklink {
    static let sfSymbol = "link"
}

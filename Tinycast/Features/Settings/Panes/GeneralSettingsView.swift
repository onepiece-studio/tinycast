import SwiftUI

struct GeneralSettingsView: View {
    @Environment(AppCore.self) private var core
    @Environment(AppSettings.self) private var settings
    private var launcherRanking: LauncherRankingStore { core.launcherRanking }
    @State private var confirmingRankingReset = false
    @State private var inputSources: [InputSourceSwitcher.Option] = []

    var body: some View {
        @Bindable var settings = settings
        return Form {
            Section {
                SettingsRow(
                    title: SettingsRowID.generalGlobalShortcutsAppLauncher.title,
                    row: .generalGlobalShortcutsAppLauncher
                ) {
                    ShortcutRecorder(action: .togglePalette)
                }
            } header: {
                SettingsSectionHeader(.generalGlobalShortcuts)
            }

            Section {
                Toggle(isOn: $settings.launchAtLogin) {
                    SettingsRowTitle(.generalGeneralLaunchAtLogin)
                }
                Toggle(isOn: $settings.showInMenuBar) {
                    SettingsRowTitle(.generalGeneralShowInMenuBar)
                    Text("Shortcuts still work when hidden.")
                }
                Toggle(isOn: $settings.automaticallyCheckForUpdates) {
                    SettingsRowTitle(.generalGeneralAutomaticallyCheckForUpdates)
                    Text("Check for Updates remains available when off.")
                }
                Picker(selection: $settings.popToRootTimeout) {
                    ForEach(PopToRootTimeout.allCases) { timeout in
                        Text(timeout.title).tag(timeout)
                    }
                } label: {
                    SettingsRowTitle(.generalGeneralPopToRootSearch)
                    Text("After the launcher closes.")
                }
                Picker(selection: $settings.escapeKeyBehavior) {
                    ForEach(EscapeKeyBehavior.allCases) { behavior in
                        Text(behavior.title).tag(behavior)
                    }
                } label: {
                    SettingsRowTitle(.generalGeneralEscapeKeyBehavior)
                    Text("When the search field is empty.")
                }
                // Empty only when TIS fails; one layout still lists, so the row stays put.
                if !inputSources.isEmpty {
                    Picker(selection: $settings.autoSwitchInputSourceID) {
                        Text("None").tag(nil as String?)
                        ForEach(inputSources) { source in
                            Text(source.title).tag(Optional(source.id))
                        }
                    } label: {
                        SettingsRowTitle(.generalGeneralAutoSwitchInputSource)
                        Text("While the launcher is open.")
                    }
                }
            } header: {
                SettingsSectionHeader(.generalGeneral)
            }

            Section {
                Picker(selection: $settings.appearance) {
                    ForEach(AppAppearance.allCases) { appearance in
                        Text(appearance.title).tag(appearance)
                    }
                } label: {
                    SettingsRowTitle(.generalAppearanceTheme)
                }
                InterfaceSizeRow()
                WindowModeRow()
                Toggle(isOn: $settings.showFavoritesInCompactMode) {
                    SettingsRowTitle(.generalAppearanceShowFavoritesInCompactMode)
                    Text("Launch them with ⌘1–⌘5.")
                }
                .settingsEnabled(settings.compactMode)
                Toggle(isOn: $settings.openOnCursorScreen) {
                    SettingsRowTitle(.generalAppearanceFollowTheCursorAcrossDisplays)
                }
                Toggle(isOn: $settings.paletteDraggable) {
                    SettingsRowTitle(.generalAppearanceDragToReposition)
                    Text("Drag the strip above the search field.")
                }
            } header: {
                SettingsSectionHeader(.generalAppearance)
            }

            HyperKeySettingsSection()

            Section {
                Picker(selection: $settings.calcNumberStyle) {
                    ForEach(CalcNumberStyle.allCases) { style in
                        let sample = core.regionNumberFormat.format(for: style).localized("1,234,567.89")
                        Text("\(style.title) (\(sample))").tag(style)
                    }
                } label: {
                    SettingsRowTitle(.generalCalculatorNumberFormat)
                    Text("With a decimal comma, ; separates arguments.")
                }
            } header: {
                SettingsSectionHeader(.generalCalculator)
            }

            Section {
                Toggle(isOn: $settings.launcherShowsSuggestions) {
                    SettingsRowTitle(.generalSearchShowSuggestions)
                    Text("What you open most, while the search field is empty.")
                }
                Picker(selection: $settings.rootSearchSensitivity) {
                    ForEach(SearchSensitivity.allCases) { sensitivity in
                        Text(sensitivity.title).tag(sensitivity)
                    }
                } label: {
                    SettingsRowTitle(.generalSearchSearchSensitivity)
                    Text("Lower finds names from scattered letters.")
                }
                LabeledContent {
                    Button("Reset…", role: .destructive) {
                        confirmingRankingReset = true
                    }
                    .disabled(launcherRanking.isEmpty)
                } label: {
                    SettingsRowTitle(.generalSearchLearnedRanking)
                    Text("Learned privately from the results you pick.")
                }
            } header: {
                SettingsSectionHeader(.generalSearch)
            }
        }
        .formStyle(.grouped)
        .settingsScrollTarget(.general)
        .confirmationDialog(
            String(localized: "Reset learned launcher ranking?"),
            isPresented: $confirmingRankingReset,
            titleVisibility: .visible
        ) {
            Button("Reset Ranking", role: .destructive) {
                launcherRanking.resetAll()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Tinycast will relearn your preferred results as you use the launcher.")
        }
        .onAppear(perform: refreshInputSources)
        .onReceive(
            DistributedNotificationCenter.default().publisher(
                for: InputSourceSwitcher.sourcesDidChange)
        ) { _ in
            refreshInputSources()
        }
    }

    private func refreshInputSources() {
        inputSources = core.inputSourceSwitcher.options(selecting: settings.autoSwitchInputSourceID)
    }
}

private struct WindowModeRow: View {
    @Environment(AppSettings.self) private var settings

    private static let preview = CGSize(width: 135, height: 80)

    var body: some View {
        SettingsRow(
            title: SettingsRowID.generalAppearanceWindowMode.title,
            subtitle: String(localized: "Choose how the launcher opens."),
            subtitleLineLimit: 2, alignment: .top, row: .generalAppearanceWindowMode
        ) {
            HStack(spacing: Theme.Spacing.md) {
                option(String(localized: "Compact"), image: "WindowModeCompact", compact: true)
                option(String(localized: "Expanded"), image: "WindowModeExpanded", compact: false)
            }
        }
    }

    private func option(_ title: String, image: String, compact: Bool) -> some View {
        let selected = settings.compactMode == compact
        return Button {
            settings.compactMode = compact
        } label: {
            VStack(spacing: Theme.Spacing.xs) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Self.preview.width, height: Self.preview.height)
                    .clipShape(
                        RoundedRectangle(cornerRadius: Theme.Radius.barControl, style: .continuous)
                    )
                    .saturation(selected ? 1 : 0)
                Text(title)
                    .font(.caption)
                    .fontWeight(selected ? .semibold : .regular)
                    .foregroundStyle(selected ? Color.primary : Color.secondary)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(WindowModeButtonStyle())
        .accessibilityLabel(title)
        .accessibilityAddTraits(selected ? [.isSelected] : [])
    }
}

private struct WindowModeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        PressedLabel(configuration: configuration)
    }

    private struct PressedLabel: View {
        let configuration: ButtonStyle.Configuration
        @State private var showsPressed = false

        var body: some View {
            configuration.label
                .opacity(showsPressed ? 0.7 : 1)
                .task(id: configuration.isPressed) {
                    if configuration.isPressed {
                        try? await Task.sleep(for: .milliseconds(20))
                        guard !Task.isCancelled else { return }
                        showsPressed = true
                    } else {
                        showsPressed = false
                    }
                }
        }
    }
}

/// Three glyph steps read as a legend; a true-to-scale "Aa" would look identical at 1.1.
private struct InterfaceSizeRow: View {
    @Environment(AppSettings.self) private var settings

    private static let glyph: [InterfaceSize: CGFloat] = [
        .standard: 11, .large: 14, .larger: 17
    ]

    var body: some View {
        SettingsRow(
            title: SettingsRowID.generalAppearanceInterfaceSize.title,
            subtitle: String(localized: "Scales the launcher and its panels, not Settings."),
            row: .generalAppearanceInterfaceSize
        ) {
            HStack(spacing: Theme.Spacing.xs) {
                ForEach(InterfaceSize.allCases) { size in
                    segment(size)
                }
            }
        }
    }

    private func segment(_ size: InterfaceSize) -> some View {
        let selected = settings.interfaceSize == size
        return Button {
            settings.interfaceSize = size
        } label: {
            Text("Aa")
                .font(.system(size: Self.glyph[size] ?? 13, weight: .medium))
                .foregroundStyle(selected ? Color.primary : Color.secondary)
                .settingsOptionSegment(isSelected: selected)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(size.title)
        .accessibilityAddTraits(selected ? [.isSelected] : [])
        .help(size.title)
    }
}

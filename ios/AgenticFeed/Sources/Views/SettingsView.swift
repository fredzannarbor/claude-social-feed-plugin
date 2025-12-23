import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var preferences: UserPreferences
    @EnvironmentObject var feedStore: FeedStore
    @State private var showingClearCacheAlert = false

    var body: some View {
        NavigationStack {
            Form {
                // Version Info
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(AppVersion.full)
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Code Name")
                        Spacer()
                        Text("\"\(AppVersion.codename.capitalized)\"")
                            .foregroundStyle(.secondary)
                    }
                }

                // Presets
                Section("Feed Preset") {
                    Picker("Preset", selection: $preferences.selectedPreset) {
                        ForEach(WeightPreset.allCases, id: \.self) { preset in
                            VStack(alignment: .leading) {
                                Text(preset.displayName)
                                Text(preset.description)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .tag(preset)
                        }
                    }
                    .pickerStyle(.inline)
                }

                // Current Weights
                Section("Neurochemical Weights") {
                    WeightSlider(
                        label: "📊 Learning",
                        value: $preferences.learningWeight
                    )
                    WeightSlider(
                        label: "💬 Engagement",
                        value: $preferences.engagementWeight
                    )
                    WeightSlider(
                        label: "⚡ Breakthrough",
                        value: $preferences.breakthroughWeight
                    )
                    WeightSlider(
                        label: "😊 Mood",
                        value: $preferences.moodWeight
                    )
                    WeightSlider(
                        label: "🎲 Serendipity",
                        value: $preferences.serendipityFactor
                    )
                }

                // Display Settings
                Section("Display") {
                    Toggle("Show Scores", isOn: $preferences.showScores)

                    Stepper(
                        "Posts per page: \(preferences.postsPerPage)",
                        value: $preferences.postsPerPage,
                        in: 5...50,
                        step: 5
                    )
                }

                // Contribution Settings
                Section("Community Contribution") {
                    Toggle("Auto-contribute posts", isOn: $preferences.autoContribute)

                    Stepper(
                        "Threshold: \(preferences.contributionThreshold) posts",
                        value: $preferences.contributionThreshold,
                        in: 1...20
                    )

                    Text("Generated posts are automatically shared with the community after reaching the threshold.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                // Cache
                Section("Cache") {
                    if feedStore.isOffline {
                        Label("Offline Mode", systemImage: "wifi.slash")
                            .foregroundStyle(.orange)
                    }

                    Button("Clear Cache", role: .destructive) {
                        showingClearCacheAlert = true
                    }

                    Button("Refresh Feed") {
                        Task {
                            await feedStore.loadFeed(forceRefresh: true)
                        }
                    }
                }

                // Reset
                Section {
                    Button("Reset to Defaults", role: .destructive) {
                        preferences.resetToDefaults()
                    }
                }

                // About
                Section("About") {
                    Link(destination: URL(string: "https://github.com/fredzannarbor/agentic-social-feed")!) {
                        HStack {
                            Label("GitHub Repository", systemImage: "link")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .foregroundStyle(.secondary)
                        }
                    }

                    HStack {
                        Text("Author")
                        Spacer()
                        Text("Nimble Books LLC")
                            .foregroundStyle(.secondary)
                    }

                    if #available(iOS 18.1, *) {
                        HStack {
                            Text("Apple FM")
                            Spacer()
                            Label("Available", systemImage: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        }
                    } else {
                        HStack {
                            Text("Apple FM")
                            Spacer()
                            Label("Requires iOS 18.1", systemImage: "xmark.circle")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Clear Cache?", isPresented: $showingClearCacheAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Clear", role: .destructive) {
                    Task {
                        await feedStore.clearCache()
                    }
                }
            } message: {
                Text("This will remove all cached posts and require a fresh download.")
            }
        }
    }
}

struct WeightSlider: View {
    let label: String
    @Binding var value: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                Spacer()
                Text(String(format: "%.2f", value))
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
            }
            Slider(value: $value, in: 0...1, step: 0.05)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(UserPreferences())
        .environmentObject(FeedStore())
}

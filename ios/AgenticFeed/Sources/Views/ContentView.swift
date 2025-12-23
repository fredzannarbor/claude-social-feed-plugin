import SwiftUI

struct ContentView: View {
    @EnvironmentObject var feedStore: FeedStore
    @EnvironmentObject var preferences: UserPreferences
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "list.bullet")
                }
                .tag(0)

            PersonasView()
                .tabItem {
                    Label("Personas", systemImage: "person.3")
                }
                .tag(1)

            if #available(iOS 18.1, *) {
                GenerateView()
                    .tabItem {
                        Label("Generate", systemImage: "sparkles")
                    }
                    .tag(2)
            }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(3)
        }
        .task {
            await feedStore.loadFeed()
        }
    }
}

// MARK: - Feed View

struct FeedView: View {
    @EnvironmentObject var feedStore: FeedStore
    @EnvironmentObject var preferences: UserPreferences
    @State private var selectedTag: String?
    @State private var selectedImprint: String?

    var body: some View {
        NavigationStack {
            Group {
                if feedStore.isLoading {
                    ProgressView("Loading feed...")
                } else if feedStore.posts.isEmpty {
                    ContentUnavailableView(
                        "No Posts",
                        systemImage: "book.closed",
                        description: Text("Pull to refresh or check your connection.")
                    )
                } else {
                    List {
                        ForEach(filteredPosts) { post in
                            PostRow(post: post)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await feedStore.loadFeed(forceRefresh: true)
                    }
                }
            }
            .navigationTitle("📚 Feed")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Preset", selection: $preferences.selectedPreset) {
                            ForEach(WeightPreset.allCases, id: \.self) { preset in
                                Text(preset.displayName).tag(preset)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }

                if feedStore.isOffline {
                    ToolbarItem(placement: .topBarLeading) {
                        Label("Offline", systemImage: "wifi.slash")
                            .foregroundStyle(.orange)
                    }
                }
            }
        }
    }

    var filteredPosts: [Post] {
        feedStore.filteredPosts(
            tag: selectedTag,
            imprint: selectedImprint,
            weights: preferences.weights
        )
    }
}

// MARK: - Post Row

struct PostRow: View {
    let post: Post
    @EnvironmentObject var feedStore: FeedStore
    @EnvironmentObject var preferences: UserPreferences

    var persona: Persona? {
        feedStore.persona(for: post)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Text(persona?.glyph ?? "•")
                    .font(.title2)
                Text(persona?.name ?? post.personaId)
                    .font(.headline)
                if let handle = persona?.handle {
                    Text(handle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            // Content
            Text(post.content)
                .font(.body)

            // Hashtags
            if let hashtags = post.hashtags, !hashtags.isEmpty {
                HStack {
                    ForEach(hashtags, id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                }
            }

            // Book references
            if let refs = post.bookReferences {
                ForEach(refs, id: \.title) { ref in
                    HStack {
                        Image(systemName: "book")
                        Text("\(ref.title)")
                            .italic()
                        Text("by \(ref.author)")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }

            // Scores
            if preferences.showScores {
                HStack(spacing: 16) {
                    ScoreBadge(label: "📊", value: post.scores.learning)
                    ScoreBadge(label: "💬", value: post.scores.engagement)
                    ScoreBadge(label: "⚡", value: post.scores.breakthrough)
                    ScoreBadge(label: "😊", value: post.scores.mood)
                }
                .font(.caption)
            }

            // Timestamp
            Text(post.timestamp, style: .relative)
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 8)
    }
}

struct ScoreBadge: View {
    let label: String
    let value: Double

    var body: some View {
        HStack(spacing: 2) {
            Text(label)
            Text(String(format: "%.2f", value))
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FeedStore())
        .environmentObject(UserPreferences())
}

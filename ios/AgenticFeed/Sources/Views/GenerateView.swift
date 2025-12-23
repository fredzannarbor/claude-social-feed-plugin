import SwiftUI

/// View for generating new posts using Apple Foundation Models.
/// Only available on iOS 18.1+
@available(iOS 18.1, *)
struct GenerateView: View {
    @EnvironmentObject var feedStore: FeedStore
    @State private var selectedPersonaId: String?
    @State private var selectedPostType: PostType = .insightDiscovery
    @State private var isGenerating = false
    @State private var generatedPost: Post?
    @State private var error: Error?

    var sortedPersonas: [Persona] {
        Array(feedStore.personas.values).sorted { $0.name < $1.name }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Select Persona") {
                    Picker("Persona", selection: $selectedPersonaId) {
                        Text("Random").tag(nil as String?)
                        ForEach(sortedPersonas) { persona in
                            Text(persona.displayName).tag(persona.personaId as String?)
                        }
                    }
                }

                Section("Post Type") {
                    Picker("Type", selection: $selectedPostType) {
                        Text("Insight Discovery").tag(PostType.insightDiscovery)
                        Text("Book Quote").tag(PostType.bookQuote)
                        Text("Book Recommendation").tag(PostType.bookRecommendation)
                        Text("Author Spotlight").tag(PostType.authorSpotlight)
                        Text("Breakthrough Moment").tag(PostType.breakthroughMoment)
                    }
                }

                Section {
                    Button(action: generate) {
                        HStack {
                            if isGenerating {
                                ProgressView()
                                    .padding(.trailing, 8)
                            }
                            Image(systemName: "sparkles")
                            Text(isGenerating ? "Generating..." : "Generate Post")
                        }
                    }
                    .disabled(isGenerating)
                    .frame(maxWidth: .infinity)
                }

                if let post = generatedPost {
                    Section("Generated Post") {
                        GeneratedPostCard(post: post)
                    }
                }

                if let error = error {
                    Section {
                        Label(error.localizedDescription, systemImage: "exclamationmark.triangle")
                            .foregroundStyle(.red)
                    }
                }

                Section {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("Posts are generated on-device using Apple Foundation Models. No data is sent to external servers.")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Generate")
        }
    }

    func generate() {
        Task {
            isGenerating = true
            error = nil

            do {
                let persona: Persona
                if let id = selectedPersonaId, let p = feedStore.personas[id] {
                    persona = p
                } else {
                    // Random persona
                    persona = sortedPersonas.randomElement()!
                }

                generatedPost = try await feedStore.generatePost(
                    persona: persona,
                    postType: selectedPostType
                )
            } catch {
                self.error = error
            }

            isGenerating = false
        }
    }
}

@available(iOS 18.1, *)
struct GeneratedPostCard: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(post.content)
                .font(.body)

            if let hashtags = post.hashtags {
                HStack {
                    ForEach(hashtags, id: \.self) { tag in
                        Text("#\(tag)")
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                }
            }

            HStack(spacing: 16) {
                ScoreBadge(label: "📊", value: post.scores.learning)
                ScoreBadge(label: "💬", value: post.scores.engagement)
                ScoreBadge(label: "⚡", value: post.scores.breakthrough)
                ScoreBadge(label: "😊", value: post.scores.mood)
            }
            .font(.caption)

            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                Text("Added to your feed")
                    .font(.caption)
            }
        }
    }
}

#Preview {
    if #available(iOS 18.1, *) {
        GenerateView()
            .environmentObject(FeedStore())
    }
}

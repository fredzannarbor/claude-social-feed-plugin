import SwiftUI

struct PersonasView: View {
    @EnvironmentObject var feedStore: FeedStore

    var sortedPersonas: [Persona] {
        Array(feedStore.personas.values).sorted { $0.name < $1.name }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedPersonas) { persona in
                    NavigationLink {
                        PersonaDetailView(persona: persona)
                    } label: {
                        PersonaRow(persona: persona)
                    }
                }
            }
            .navigationTitle("Personas")
        }
    }
}

struct PersonaRow: View {
    let persona: Persona

    var body: some View {
        HStack(spacing: 12) {
            Text(persona.glyph)
                .font(.largeTitle)

            VStack(alignment: .leading, spacing: 4) {
                Text(persona.name)
                    .font(.headline)

                if let specialty = persona.specialty {
                    Text(specialty)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                if let handle = persona.handle {
                    Text(handle)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
            }

            Spacer()

            PersonaTypeBadge(type: persona.personaType)
        }
        .padding(.vertical, 4)
    }
}

struct PersonaTypeBadge: View {
    let type: PersonaType

    var color: Color {
        switch type {
        case .publisher: return .purple
        case .social: return .blue
        case .contributingEditor: return .orange
        case .custom: return .green
        }
    }

    var body: some View {
        Text(type.rawValue.replacingOccurrences(of: "_", with: " ").capitalized)
            .font(.caption2)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.2))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }
}

struct PersonaDetailView: View {
    let persona: Persona
    @EnvironmentObject var feedStore: FeedStore

    var personaPosts: [Post] {
        feedStore.posts.filter { $0.personaId == persona.personaId }
    }

    var body: some View {
        List {
            Section {
                HStack {
                    Text(persona.glyph)
                        .font(.system(size: 60))
                    VStack(alignment: .leading) {
                        Text(persona.name)
                            .font(.title)
                        if let handle = persona.handle {
                            Text(handle)
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }

            if let bio = persona.bio {
                Section("About") {
                    Text(bio)
                }
            }

            if let specialty = persona.specialty {
                Section("Specialty") {
                    Text(specialty)
                }
            }

            if let traits = persona.personalityTraits, !traits.isEmpty {
                Section("Personality") {
                    FlowLayout(items: traits)
                }
            }

            if let tags = persona.tags, !tags.isEmpty {
                Section("Topics") {
                    FlowLayout(items: tags)
                }
            }

            if let benefit = persona.neurochemicalBenefit {
                Section("Neurochemical Benefit") {
                    Text(benefit)
                        .foregroundStyle(.secondary)
                }
            }

            if !personaPosts.isEmpty {
                Section("Recent Posts (\(personaPosts.count))") {
                    ForEach(personaPosts.prefix(5)) { post in
                        Text(post.content)
                            .font(.caption)
                            .lineLimit(3)
                    }
                }
            }
        }
        .navigationTitle(persona.displayName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FlowLayout: View {
    let items: [String]

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 8) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    PersonasView()
        .environmentObject(FeedStore())
}

import Foundation

/// An AI persona that generates social content.
/// Schema: shared/schemas/persona.schema.json
struct Persona: Codable, Identifiable, Hashable {
    let personaId: String
    let personaType: PersonaType
    let name: String
    let glyph: String
    let handle: String?
    let bio: String?
    let specialty: String?
    let imprint: String?
    let tags: [String]?
    let personalityTraits: [String]?
    let interests: [String]?
    let writingStyle: String?
    let voicePrompt: String?
    let neurochemicalBenefit: String?
    let active: Bool?

    var id: String { personaId }

    enum CodingKeys: String, CodingKey {
        case personaId = "persona_id"
        case personaType = "persona_type"
        case name
        case glyph
        case handle
        case bio
        case specialty
        case imprint
        case tags
        case personalityTraits = "personality_traits"
        case interests
        case writingStyle = "writing_style"
        case voicePrompt = "voice_prompt"
        case neurochemicalBenefit = "neurochemical_benefit"
        case active
    }

    /// Display name with glyph
    var displayName: String {
        "\(glyph) \(name)"
    }

    /// Full display with handle
    var fullDisplay: String {
        if let handle = handle {
            return "\(glyph) \(name) \(handle)"
        }
        return displayName
    }
}

enum PersonaType: String, Codable {
    case publisher
    case social
    case contributingEditor = "contributing_editor"
    case custom
}

// MARK: - Persona Registry Response

struct PersonaRegistry: Codable {
    let meta: RegistryMeta?
    let personas: [String: Persona]

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case personas
    }
}

struct RegistryMeta: Codable {
    let version: String?
    let description: String?
    let personaCount: Int?

    enum CodingKeys: String, CodingKey {
        case version
        case description
        case personaCount = "persona_count"
    }
}

// MARK: - Posts Response

struct PostsResponse: Codable {
    let meta: RegistryMeta?
    let posts: [Post]

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case posts
    }
}

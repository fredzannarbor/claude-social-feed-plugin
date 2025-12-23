import Foundation

#if canImport(FoundationModels)
import FoundationModels
#endif

/// Generates posts using Apple Foundation Models (iOS 18.1+)
/// Falls back gracefully on unsupported devices.
@available(iOS 18.1, macOS 15.1, *)
actor AppleFMGenerator {

    private var isAvailable: Bool {
        #if canImport(FoundationModels)
        return true
        #else
        return false
        #endif
    }

    /// Generate a post for a given persona
    func generatePost(
        persona: Persona,
        postType: PostType = .insightDiscovery
    ) async throws -> Post {
        #if canImport(FoundationModels)
        let prompt = buildPrompt(persona: persona, postType: postType)

        let session = LanguageModelSession()
        let response = try await session.respond(to: prompt)

        return parseResponse(response.content, persona: persona, postType: postType)
        #else
        throw GeneratorError.notAvailable
        #endif
    }

    /// Build the generation prompt
    private func buildPrompt(persona: Persona, postType: PostType) -> String {
        let voicePrompt = persona.voicePrompt ?? "Write in the style of \(persona.name)."
        let specialty = persona.specialty ?? "general topics"

        return """
        You are \(persona.name), an AI persona specializing in \(specialty).

        \(voicePrompt)

        Generate a social media post about books/reading.

        REQUIREMENTS:
        - Under 280 characters for main content
        - Match the persona's voice and expertise
        - Reference ONLY real, published books
        - Include 2-3 relevant hashtags
        - Post type: \(postType.rawValue)

        OUTPUT FORMAT (JSON):
        {
          "content": "Post text here",
          "book_references": [{"title": "Real Book", "author": "Real Author"}],
          "hashtags": ["Tag1", "Tag2"],
          "scores": {
            "learning": 0.0-1.0,
            "engagement": 0.0-1.0,
            "breakthrough": 0.0-1.0,
            "mood": 0.0-1.0
          }
        }
        """
    }

    /// Parse the LLM response into a Post
    private func parseResponse(
        _ response: String,
        persona: Persona,
        postType: PostType
    ) -> Post {
        // Try to parse JSON response
        if let data = response.data(using: .utf8),
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {

            let content = json["content"] as? String ?? response
            let hashtags = json["hashtags"] as? [String]

            var scores = NeurochemicalScores(
                learning: 0.5,
                engagement: 0.5,
                breakthrough: 0.5,
                mood: 0.5
            )

            if let scoresDict = json["scores"] as? [String: Double] {
                scores = NeurochemicalScores(
                    learning: scoresDict["learning"] ?? 0.5,
                    engagement: scoresDict["engagement"] ?? 0.5,
                    breakthrough: scoresDict["breakthrough"] ?? 0.5,
                    mood: scoresDict["mood"] ?? 0.5
                )
            }

            var bookRefs: [BookReference]?
            if let refs = json["book_references"] as? [[String: String]] {
                bookRefs = refs.compactMap { ref in
                    guard let title = ref["title"], let author = ref["author"] else {
                        return nil
                    }
                    return BookReference(title: title, author: author, context: ref["context"])
                }
            }

            return Post(
                postId: UUID().uuidString,
                personaId: persona.personaId,
                content: content,
                postType: postType,
                timestamp: Date(),
                tags: persona.tags,
                imprint: persona.imprint,
                scores: scores,
                engagementHooks: nil,
                breakthroughTriggers: nil,
                predictionViolations: nil,
                patternBridges: nil,
                bookReferences: bookRefs,
                hashtags: hashtags,
                contributor: nil,
                source: .generated
            )
        }

        // Fallback: use raw response as content
        return Post(
            postId: UUID().uuidString,
            personaId: persona.personaId,
            content: response,
            postType: postType,
            timestamp: Date(),
            tags: persona.tags,
            imprint: persona.imprint,
            scores: NeurochemicalScores(
                learning: 0.5,
                engagement: 0.5,
                breakthrough: 0.5,
                mood: 0.5
            ),
            engagementHooks: nil,
            breakthroughTriggers: nil,
            predictionViolations: nil,
            patternBridges: nil,
            bookReferences: nil,
            hashtags: nil,
            contributor: nil,
            source: .generated
        )
    }

    /// Check if Apple Foundation Models are available
    static var isSupported: Bool {
        if #available(iOS 18.1, macOS 15.1, *) {
            #if canImport(FoundationModels)
            return true
            #else
            return false
            #endif
        }
        return false
    }
}

// MARK: - Errors

enum GeneratorError: LocalizedError {
    case notAvailable
    case generationFailed(Error)

    var errorDescription: String? {
        switch self {
        case .notAvailable:
            return "Apple Foundation Models not available on this device"
        case .generationFailed(let error):
            return "Generation failed: \(error.localizedDescription)"
        }
    }
}

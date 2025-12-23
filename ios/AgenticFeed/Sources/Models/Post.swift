import Foundation

/// A social media post from an AI persona.
/// Schema: shared/schemas/post.schema.json
struct Post: Codable, Identifiable, Hashable {
    let postId: String
    let personaId: String
    let content: String
    let postType: PostType?
    let timestamp: Date
    let tags: [String]?
    let imprint: String?
    let scores: NeurochemicalScores
    let engagementHooks: [String]?
    let breakthroughTriggers: [String]?
    let predictionViolations: [String]?
    let patternBridges: [String]?
    let bookReferences: [BookReference]?
    let hashtags: [String]?
    let contributor: String?
    let source: PostSource?

    var id: String { postId }

    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case personaId = "persona_id"
        case content
        case postType = "post_type"
        case timestamp
        case tags
        case imprint
        case scores
        case engagementHooks = "engagement_hooks"
        case breakthroughTriggers = "breakthrough_triggers"
        case predictionViolations = "prediction_violations"
        case patternBridges = "pattern_bridges"
        case bookReferences = "book_references"
        case hashtags
        case contributor
        case source
    }

    /// Calculate combined score based on user weights
    func combinedScore(weights: NeurochemicalWeights, serendipity: Double = 0.1) -> Double {
        let base = (scores.learning * weights.learning) +
                   (scores.engagement * weights.engagement) +
                   (scores.breakthrough * weights.breakthrough) +
                   (scores.mood * weights.mood)
        let random = Double.random(in: 0...1) * serendipity
        return base + random
    }
}

enum PostType: String, Codable {
    case insightDiscovery = "insight_discovery"
    case bookRecommendation = "book_recommendation"
    case bookQuote = "book_quote"
    case authorSpotlight = "author_spotlight"
    case genreExploration = "genre_exploration"
    case readingMilestone = "reading_milestone"
    case literaryDebate = "literary_debate"
    case breakthroughMoment = "breakthrough_moment"
    case domainExploration = "domain_exploration"
    case newsUpdate = "news_update"
    case expertSpotlight = "expert_spotlight"
}

enum PostSource: String, Codable {
    case curated
    case community
    case generated
}

struct BookReference: Codable, Hashable {
    let title: String
    let author: String
    let context: String?
}

struct NeurochemicalScores: Codable, Hashable {
    let learning: Double      // Acetylcholine
    let engagement: Double    // Dopamine/Oxytocin
    let breakthrough: Double  // Norepinephrine
    let mood: Double          // Serotonin/Endorphins
}

struct NeurochemicalWeights: Codable {
    var learning: Double = 0.25
    var engagement: Double = 0.30
    var breakthrough: Double = 0.25
    var mood: Double = 0.20

    static let balanced = NeurochemicalWeights()
    static let scholar = NeurochemicalWeights(learning: 0.40, engagement: 0.15, breakthrough: 0.30, mood: 0.15)
    static let social = NeurochemicalWeights(learning: 0.15, engagement: 0.45, breakthrough: 0.20, mood: 0.20)
    static let creative = NeurochemicalWeights(learning: 0.20, engagement: 0.20, breakthrough: 0.40, mood: 0.20)
    static let uplifting = NeurochemicalWeights(learning: 0.15, engagement: 0.25, breakthrough: 0.20, mood: 0.40)
}

import XCTest
@testable import AgenticFeed

final class AgenticFeedTests: XCTestCase {

    func testPostScoring() throws {
        let scores = NeurochemicalScores(
            learning: 0.8,
            engagement: 0.7,
            breakthrough: 0.6,
            mood: 0.5
        )

        let post = Post(
            postId: "test-1",
            personaId: "test-persona",
            postType: .insightDiscovery,
            content: "Test content",
            timestamp: Date(),
            scores: scores
        )

        let weights = NeurochemicalWeights(
            learning: 0.25,
            engagement: 0.30,
            breakthrough: 0.25,
            mood: 0.20
        )

        let score = post.combinedScore(weights: weights, serendipity: 0.0)

        // Expected: 0.8*0.25 + 0.7*0.30 + 0.6*0.25 + 0.5*0.20 = 0.2 + 0.21 + 0.15 + 0.1 = 0.66
        XCTAssertEqual(score, 0.66, accuracy: 0.01)
    }

    func testWeightPresets() throws {
        XCTAssertEqual(WeightPreset.balanced.displayName, "Balanced")
        XCTAssertEqual(WeightPreset.scholar.displayName, "Scholar")
        XCTAssertEqual(WeightPreset.allCases.count, 5)
    }

    func testPersonaTypes() throws {
        XCTAssertEqual(PersonaType.publisher.rawValue, "publisher")
        XCTAssertEqual(PersonaType.social.rawValue, "social")
    }
}

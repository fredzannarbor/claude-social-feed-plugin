import Foundation
import SwiftUI

/// User preferences for feed customization.
class UserPreferences: ObservableObject {
    @AppStorage("weights.learning") var learningWeight: Double = 0.25
    @AppStorage("weights.engagement") var engagementWeight: Double = 0.30
    @AppStorage("weights.breakthrough") var breakthroughWeight: Double = 0.25
    @AppStorage("weights.mood") var moodWeight: Double = 0.20
    @AppStorage("weights.serendipity") var serendipityFactor: Double = 0.10

    @AppStorage("display.postsPerPage") var postsPerPage: Int = 10
    @AppStorage("display.showScores") var showScores: Bool = true

    @AppStorage("contribution.autoContribute") var autoContribute: Bool = true
    @AppStorage("contribution.threshold") var contributionThreshold: Int = 5

    @AppStorage("selectedPreset") var selectedPresetRaw: String = "balanced"

    var weights: NeurochemicalWeights {
        NeurochemicalWeights(
            learning: learningWeight,
            engagement: engagementWeight,
            breakthrough: breakthroughWeight,
            mood: moodWeight
        )
    }

    var selectedPreset: WeightPreset {
        get { WeightPreset(rawValue: selectedPresetRaw) ?? .balanced }
        set {
            selectedPresetRaw = newValue.rawValue
            applyPreset(newValue)
        }
    }

    func applyPreset(_ preset: WeightPreset) {
        switch preset {
        case .balanced:
            learningWeight = 0.25
            engagementWeight = 0.30
            breakthroughWeight = 0.25
            moodWeight = 0.20
        case .scholar:
            learningWeight = 0.40
            engagementWeight = 0.15
            breakthroughWeight = 0.30
            moodWeight = 0.15
        case .social:
            learningWeight = 0.15
            engagementWeight = 0.45
            breakthroughWeight = 0.20
            moodWeight = 0.20
        case .creative:
            learningWeight = 0.20
            engagementWeight = 0.20
            breakthroughWeight = 0.40
            moodWeight = 0.20
        case .uplifting:
            learningWeight = 0.15
            engagementWeight = 0.25
            breakthroughWeight = 0.20
            moodWeight = 0.40
        }
    }

    func resetToDefaults() {
        selectedPreset = .balanced
        serendipityFactor = 0.10
        postsPerPage = 10
        showScores = true
        autoContribute = true
        contributionThreshold = 5
    }
}

enum WeightPreset: String, CaseIterable {
    case balanced
    case scholar
    case social
    case creative
    case uplifting

    var displayName: String {
        switch self {
        case .balanced: return "Balanced"
        case .scholar: return "Scholar"
        case .social: return "Social"
        case .creative: return "Creative"
        case .uplifting: return "Uplifting"
        }
    }

    var description: String {
        switch self {
        case .balanced: return "Even mix of all factors"
        case .scholar: return "Focus on learning content"
        case .social: return "Prioritize engagement"
        case .creative: return "Seek breakthrough insights"
        case .uplifting: return "Boost your mood"
        }
    }
}

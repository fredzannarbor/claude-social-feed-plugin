import SwiftUI

/// Agentic Social Feed iOS App
///
/// Version: 1.0.0-anderson (Tom Anderson / MySpace era)
/// Minimum iOS: 18.1 (required for Apple Foundation Models)

@main
struct AgenticFeedApp: App {
    @StateObject private var feedStore = FeedStore()
    @StateObject private var preferences = UserPreferences()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(feedStore)
                .environmentObject(preferences)
        }
    }
}

// MARK: - Version Info

struct AppVersion {
    static let major = 1
    static let minor = 0
    static let patch = 0

    static var semver: String {
        "\(major).\(minor).\(patch)"
    }

    static var codename: String {
        // Social Media Pioneers code names
        let pioneers = [
            "anderson",    // 1.x - Tom Anderson (MySpace)
            "zuckerberg",  // 2.x - Mark Zuckerberg (Facebook)
            "butterfield", // 3.x - Stewart Butterfield (Flickr)
            "karim",       // 4.x - Jawed Karim (YouTube)
            "hoffman",     // 5.x - Reid Hoffman (LinkedIn)
            "dorsey",      // 6.x - Jack Dorsey (Twitter)
            "karp",        // 7.x - David Karp (Tumblr)
            "crowley",     // 8.x - Dennis Crowley (Foursquare)
            "systrom",     // 9.x - Kevin Systrom (Instagram)
        ]
        let index = major - 1
        return index < pioneers.count ? pioneers[index] : "pioneer\(major)"
    }

    static var full: String {
        "\(semver)-\(codename)"
    }

    static var displayName: String {
        let pioneerNames = [
            "Tom Anderson (MySpace)",
            "Mark Zuckerberg (Facebook)",
            "Stewart Butterfield (Flickr)",
            "Jawed Karim (YouTube)",
            "Reid Hoffman (LinkedIn)",
            "Jack Dorsey (Twitter)",
            "David Karp (Tumblr)",
            "Dennis Crowley (Foursquare)",
            "Kevin Systrom (Instagram)",
        ]
        let index = major - 1
        let name = index < pioneerNames.count ? pioneerNames[index] : "Pioneer \(major)"
        return "\(semver) \"\(name)\""
    }
}

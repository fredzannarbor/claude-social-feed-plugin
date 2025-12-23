import SwiftUI

/// Agentic Social Feed iOS App
///
/// Version: 1.0.0-aim (AOL Instant Messenger, RIP 2017)
/// Minimum iOS: 18.1 (required for Apple Foundation Models)
///
/// Version naming uses defunct social media platforms as memorials:
/// v1=AIM, v2=Bebo, v3=Club Penguin, v5=Friendster, v23=Vine, etc.

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

/// Version naming uses defunct social media platforms - a memorial to the
/// platforms that shaped social media history but are no longer with us.
struct AppVersion {
    static let major = 1
    static let minor = 0
    static let patch = 0

    static var semver: String {
        "\(major).\(minor).\(patch)"
    }

    /// Defunct platform info: (codename, name, peak year, shutdown year, tagline, killer)
    private static let platforms: [(String, String, Int, Int, String, String)] = [
        ("aim", "AIM", 2001, 2017, "The original buddy list", "Mobile messaging apps"),                    // 1.x
        ("bebo", "Bebo", 2008, 2013, "AOL bought for $850M", "Facebook, mismanagement"),                   // 2.x
        ("clubpenguin", "Club Penguin", 2012, 2017, "Waddle around and meet new friends", "Disney shutdown"), // 3.x
        ("dodgeball", "Dodgeball", 2005, 2009, "Check-in pioneer", "Google neglect"),                      // 4.x
        ("friendster", "Friendster", 2003, 2015, "The original social network", "Facebook"),               // 5.x
        ("googleplus", "Google+", 2012, 2019, "Google's Facebook killer", "Low engagement"),               // 6.x
        ("gowalla", "Gowalla", 2010, 2012, "Beautiful check-ins", "Foursquare competition"),              // 7.x
        ("hyves", "Hyves", 2010, 2013, "The Dutch social network", "Facebook expansion"),                  // 8.x
        ("ping", "iTunes Ping", 2010, 2012, "Apple's music social network", "Low adoption"),               // 9.x
        ("jaiku", "Jaiku", 2007, 2012, "Finnish microblogging", "Twitter dominance"),                      // 10.x
        ("klout", "Klout", 2012, 2018, "Your social influence score", "Privacy concerns"),                 // 11.x
        ("lively", "Lively", 2008, 2008, "Google's 3D virtual world", "6 months lifespan"),               // 12.x
        ("meerkat", "Meerkat", 2015, 2016, "Live streaming pioneer", "Periscope, Facebook Live"),         // 13.x
        ("orkut", "Orkut", 2008, 2014, "Google's first social network", "Facebook, Google+"),             // 14.x
        ("path", "Path", 2012, 2018, "The personal network (150 friends)", "Limited growth"),             // 15.x
        ("periscope", "Periscope", 2015, 2021, "Twitter's live streaming", "Integrated then abandoned"),  // 16.x
        ("pownce", "Pownce", 2007, 2008, "Digg founder's Twitter competitor", "Twitter dominance"),       // 17.x
        ("rdio", "Rdio", 2013, 2015, "Beautiful music streaming", "Spotify competition"),                  // 18.x
        ("secret", "Secret", 2014, 2015, "Anonymous secrets", "Cyberbullying concerns"),                   // 19.x
        ("sixdegrees", "SixDegrees", 1999, 2001, "The FIRST social network", "Dot-com bust"),             // 20.x
        ("stumbleupon", "StumbleUpon", 2012, 2018, "Discover random websites", "Algorithm fatigue"),      // 21.x
        ("turntable", "Turntable.fm", 2011, 2013, "DJ with friends", "Music licensing costs"),            // 22.x
        ("vine", "Vine", 2014, 2017, "6-second looping videos", "Twitter neglect"),                        // 23.x
        ("wave", "Wave", 2009, 2010, "Google's collaboration experiment", "Confusing UX"),                 // 24.x
        ("xanga", "Xanga", 2005, 2017, "Teen blogging before Tumblr", "Tumblr, failed reboot"),           // 25.x
        ("yikyak", "Yik Yak", 2014, 2017, "Anonymous college posts", "Cyberbullying"),                     // 26.x
    ]

    static var codename: String {
        let index = major - 1
        return index < platforms.count ? platforms[index].0 : "defunct\(major)"
    }

    static var platformName: String {
        let index = major - 1
        return index < platforms.count ? platforms[index].1 : "Unknown"
    }

    static var full: String {
        "\(semver)-\(codename)"
    }

    static var displayName: String {
        let index = major - 1
        if index < platforms.count {
            let p = platforms[index]
            return "\(semver) \"\(p.1)\" (\(p.2)-\(p.3))"
        }
        return semver
    }

    static var platformInfo: (name: String, peakYear: Int, shutdownYear: Int, tagline: String, killer: String)? {
        let index = major - 1
        guard index < platforms.count else { return nil }
        let p = platforms[index]
        return (p.1, p.2, p.3, p.4, p.5)
    }

    static var epitaph: String {
        let index = major - 1
        guard index < platforms.count else { return "Unknown" }
        return platforms[index].5
    }
}

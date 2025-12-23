import Foundation

/// Manages offline caching of posts and personas.
actor OfflineCache {
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    init() {
        let cachesDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheDirectory = cachesDir.appendingPathComponent("AgenticFeed", isDirectory: true)

        // Create cache directory if needed
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }

    // MARK: - Posts

    private var postsURL: URL {
        cacheDirectory.appendingPathComponent("posts.json")
    }

    func savePosts(_ posts: [Post]) throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted

        let data = try encoder.encode(posts)
        try data.write(to: postsURL)
    }

    func loadPosts() throws -> [Post]? {
        guard fileManager.fileExists(atPath: postsURL.path) else {
            return nil
        }

        let data = try Data(contentsOf: postsURL)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode([Post].self, from: data)
    }

    // MARK: - Personas

    private var personasURL: URL {
        cacheDirectory.appendingPathComponent("personas.json")
    }

    func savePersonas(_ personas: [String: Persona]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try encoder.encode(personas)
        try data.write(to: personasURL)
    }

    func loadPersonas() throws -> [String: Persona]? {
        guard fileManager.fileExists(atPath: personasURL.path) else {
            return nil
        }

        let data = try Data(contentsOf: personasURL)
        let decoder = JSONDecoder()

        return try decoder.decode([String: Persona].self, from: data)
    }

    // MARK: - Generated Posts (User's own)

    private var generatedPostsURL: URL {
        cacheDirectory.appendingPathComponent("generated_posts.json")
    }

    func saveGeneratedPosts(_ posts: [Post]) throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted

        let data = try encoder.encode(posts)
        try data.write(to: generatedPostsURL)
    }

    func loadGeneratedPosts() throws -> [Post]? {
        guard fileManager.fileExists(atPath: generatedPostsURL.path) else {
            return nil
        }

        let data = try Data(contentsOf: generatedPostsURL)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode([Post].self, from: data)
    }

    func appendGeneratedPost(_ post: Post) throws {
        var posts = try loadGeneratedPosts() ?? []
        posts.append(post)
        try saveGeneratedPosts(posts)
    }

    // MARK: - Pending Contributions

    private var pendingContributionsURL: URL {
        cacheDirectory.appendingPathComponent("pending_contributions.json")
    }

    struct PendingContributions: Codable {
        var posts: [Post]
        var queuedAt: Date

        enum CodingKeys: String, CodingKey {
            case posts
            case queuedAt = "queued_at"
        }
    }

    func savePendingContributions(_ posts: [Post]) throws {
        let contributions = PendingContributions(posts: posts, queuedAt: Date())
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted

        let data = try encoder.encode(contributions)
        try data.write(to: pendingContributionsURL)
    }

    func loadPendingContributions() throws -> PendingContributions? {
        guard fileManager.fileExists(atPath: pendingContributionsURL.path) else {
            return nil
        }

        let data = try Data(contentsOf: pendingContributionsURL)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(PendingContributions.self, from: data)
    }

    func clearPendingContributions() throws {
        if fileManager.fileExists(atPath: pendingContributionsURL.path) {
            try fileManager.removeItem(at: pendingContributionsURL)
        }
    }

    // MARK: - Cache Management

    func clearAll() throws {
        let files = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
        for file in files {
            try fileManager.removeItem(at: file)
        }
    }

    func cacheSize() throws -> Int64 {
        var size: Int64 = 0
        let files = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: [.fileSizeKey])
        for file in files {
            let attrs = try file.resourceValues(forKeys: [.fileSizeKey])
            size += Int64(attrs.fileSize ?? 0)
        }
        return size
    }

    var lastUpdated: Date? {
        guard let attrs = try? fileManager.attributesOfItem(atPath: postsURL.path) else {
            return nil
        }
        return attrs[.modificationDate] as? Date
    }
}

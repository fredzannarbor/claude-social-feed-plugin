import Foundation

/// Fetches curated content from the GitHub repository.
actor GitHubFetcher {
    private let repo = "fredzannarbor/agentic-social-feed"
    private let branch = "main"
    private let baseURL: URL

    private var postsCache: [Post]?
    private var personasCache: [String: Persona]?
    private var lastFetch: Date?
    private let cacheTTL: TimeInterval = 3600 // 1 hour

    init() {
        baseURL = URL(string: "https://raw.githubusercontent.com/\(repo)/\(branch)/")!
    }

    /// Fetch posts from the repository
    func fetchPosts(forceRefresh: Bool = false) async throws -> [Post] {
        if !forceRefresh, let cached = postsCache,
           let lastFetch = lastFetch,
           Date().timeIntervalSince(lastFetch) < cacheTTL {
            return cached
        }

        let url = baseURL.appendingPathComponent("data/posts.json")
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let response = try decoder.decode(PostsResponse.self, from: data)
        postsCache = response.posts
        lastFetch = Date()

        return response.posts
    }

    /// Fetch personas from the repository
    func fetchPersonas(forceRefresh: Bool = false) async throws -> [String: Persona] {
        if !forceRefresh, let cached = personasCache,
           let lastFetch = lastFetch,
           Date().timeIntervalSince(lastFetch) < cacheTTL {
            return cached
        }

        let url = baseURL.appendingPathComponent("data/personas.json")
        let (data, _) = try await URLSession.shared.data(from: url)

        let decoder = JSONDecoder()
        let response = try decoder.decode(PersonaRegistry.self, from: data)
        personasCache = response.personas
        lastFetch = Date()

        return response.personas
    }

    /// Clear the cache
    func clearCache() {
        postsCache = nil
        personasCache = nil
        lastFetch = nil
    }

    /// Get all unique tags from posts
    func fetchAllTags() async throws -> Set<String> {
        let posts = try await fetchPosts()
        var tags = Set<String>()
        for post in posts {
            if let postTags = post.tags {
                tags.formUnion(postTags)
            }
        }
        return tags
    }

    /// Get all unique imprints
    func fetchAllImprints() async throws -> Set<String> {
        let posts = try await fetchPosts()
        var imprints = Set<String>()
        for post in posts {
            if let imprint = post.imprint {
                imprints.insert(imprint)
            }
        }
        return imprints
    }
}

// MARK: - Errors

enum FetchError: LocalizedError {
    case networkError(Error)
    case decodingError(Error)
    case invalidURL

    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to parse data: \(error.localizedDescription)"
        case .invalidURL:
            return "Invalid URL"
        }
    }
}

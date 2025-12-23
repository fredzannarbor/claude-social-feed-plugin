import Foundation
import SwiftUI

/// Main data store for the feed.
/// Coordinates between GitHub fetcher, local cache, and generation.
@MainActor
class FeedStore: ObservableObject {
    @Published var posts: [Post] = []
    @Published var personas: [String: Persona] = [:]
    @Published var isLoading = false
    @Published var error: Error?
    @Published var isOffline = false

    private let fetcher = GitHubFetcher()
    private let cache = OfflineCache()

    // MARK: - Loading

    func loadFeed(forceRefresh: Bool = false) async {
        isLoading = true
        error = nil

        do {
            // Try to fetch from GitHub
            async let fetchedPosts = fetcher.fetchPosts(forceRefresh: forceRefresh)
            async let fetchedPersonas = fetcher.fetchPersonas(forceRefresh: forceRefresh)

            let (newPosts, newPersonas) = try await (fetchedPosts, fetchedPersonas)

            posts = newPosts
            personas = newPersonas
            isOffline = false

            // Update cache
            try? await cache.savePosts(newPosts)
            try? await cache.savePersonas(newPersonas)

        } catch {
            // Fall back to cache
            self.error = error

            if let cachedPosts = try? await cache.loadPosts(),
               let cachedPersonas = try? await cache.loadPersonas() {
                posts = cachedPosts
                personas = cachedPersonas
                isOffline = true
            }
        }

        isLoading = false
    }

    // MARK: - Filtering

    func filteredPosts(
        tag: String? = nil,
        imprint: String? = nil,
        personaId: String? = nil,
        weights: NeurochemicalWeights = .balanced
    ) -> [Post] {
        var filtered = posts

        if let tag = tag {
            filtered = filtered.filter { $0.tags?.contains(tag) ?? false }
        }

        if let imprint = imprint {
            filtered = filtered.filter { $0.imprint == imprint }
        }

        if let personaId = personaId {
            filtered = filtered.filter { $0.personaId == personaId }
        }

        // Sort by combined score
        return filtered.sorted { post1, post2 in
            post1.combinedScore(weights: weights) > post2.combinedScore(weights: weights)
        }
    }

    // MARK: - Unique Values

    var allTags: Set<String> {
        var tags = Set<String>()
        for post in posts {
            if let postTags = post.tags {
                tags.formUnion(postTags)
            }
        }
        return tags
    }

    var allImprints: Set<String> {
        var imprints = Set<String>()
        for post in posts {
            if let imprint = post.imprint {
                imprints.insert(imprint)
            }
        }
        return imprints
    }

    // MARK: - Persona Lookup

    func persona(for post: Post) -> Persona? {
        personas[post.personaId]
    }

    // MARK: - Generation (iOS 18.1+)

    @available(iOS 18.1, *)
    func generatePost(persona: Persona, postType: PostType = .insightDiscovery) async throws -> Post {
        let generator = AppleFMGenerator()
        let post = try await generator.generatePost(persona: persona, postType: postType)

        // Add to local posts
        posts.insert(post, at: 0)

        // Save to generated posts cache
        try? await cache.appendGeneratedPost(post)

        return post
    }

    // MARK: - Cache Management

    func clearCache() async {
        try? await cache.clearAll()
        await fetcher.clearCache()
    }

    var cacheLastUpdated: Date? {
        get async {
            await cache.lastUpdated
        }
    }
}

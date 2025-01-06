import Foundation

protocol AppleMusicNetworkServiceInput: AnyObject {
    func fetchPopularAlbums(limit: Int) async throws -> PopularAlbumsDTO
    func fetchArtistAlbums(id: String, limit: Int) async throws -> ArtistAlbumsDTO
}

// MARK: - Query
extension NetworkService {
    struct PopularAlbumObjects: Encodable {
        let limit: String
        let locale: String
    }

    struct ArtistAlbumsObjects: Encodable {
        let includeGroups: String
        let limit: String
        let market: String
    }
}

extension NetworkService: AppleMusicNetworkServiceInput {
    func fetchPopularAlbums(
        limit: Int
    ) async throws -> PopularAlbumsDTO {
        try await request(
            with: ApiConfiguratorBuilder()
                .method(.get)
                .path("browse/new-releases")
                .query(PopularAlbumObjects(
                    limit: "\(limit)",
                    locale: "en_US"
                ))
                .build()
        )
    }

    func fetchArtistAlbums(
        id: String,
        limit: Int
    ) async throws -> ArtistAlbumsDTO {
        try await request(
            with: ApiConfiguratorBuilder()
                .method(.get)
                .path("artists/\(id)/albums")
                .query(ArtistAlbumsObjects(
                    includeGroups: "album",
                    limit: "\(limit)",
                    market: "US"
                ))
                .build()
        )
    }
}

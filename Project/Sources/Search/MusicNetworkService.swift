import Foundation

protocol AppleMusicNetworkServiceInput: AnyObject {
    func fetchPopularAlbums(limit: Int) async throws -> PopularAlbumsDTO
}

extension NetworkService: AppleMusicNetworkServiceInput {
    func fetchPopularAlbums(limit: Int) async throws -> PopularAlbumsDTO {
        try await request(
            with: ApiConfiguratorBuilder()
                .method(.get)
                .path("catalog/us/charts")
                .query(["types": "albums", "limit": "\(limit)"])
                .build()
        )
    }
}

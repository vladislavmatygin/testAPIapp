import Foundation
import Combine

public final class SearchService {

    public enum Action {
        case addPopularAlbums([PopularAlbumUIO])
        case addArtistAlbums([ArtistAlbumUIO])
    }

    // MARK: - Properties

    public static let shared = SearchService()

    private let _searchActionSubject = PassthroughSubject<Action, Never>()
    public private(set) lazy var searchActionSubject = _searchActionSubject.eraseToAnyPublisher()

    private let networkService: AppleMusicNetworkServiceInput = NetworkService()

    private init() {}

    // MARK: - Public methods

    func getPopularAlbums(
        limit: Int = 7
    ) async throws -> [PopularAlbumUIO] {
        let data = try await networkService.fetchPopularAlbums(limit: limit)
        _searchActionSubject.send(.addPopularAlbums(SearchMapper.map(data)))
        return SearchMapper.map(data)
    }

    func getArtistAlbums(
        id: String = "4dM6NDYSfLcspt8GLoT5aE",
        limit: Int = 7
    ) async throws -> [ArtistAlbumUIO] {
        let data = try await networkService.fetchArtistAlbums(id: id, limit: limit)
        _searchActionSubject.send(.addArtistAlbums(SearchMapper.map(data)))
        return SearchMapper.map(data)
    }
}

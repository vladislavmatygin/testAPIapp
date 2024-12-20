import Foundation
import Combine

public final class SearchService {

    public enum Action {
        case addPopularAlbums([PopularAlbumUIO])
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
        let dto = try await networkService.fetchPopularAlbums(limit: limit)
        _searchActionSubject.send(.addPopularAlbums(SearchMapper.map(dto)))
        return SearchMapper.map(dto)
    }
}

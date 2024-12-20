import Foundation

final class SearchMapper {
    static func map(_ dto: PopularAlbumsDTO) -> [PopularAlbumUIO] {
        return dto.results.albums.data.compactMap { albumData in
            guard let imageUrl = URL(string: albumData.attributes.artwork.url) else { return nil }
            return PopularAlbumUIO(
                title: albumData.attributes.name,
                imageUrl: imageUrl
            )
        }
    }
}

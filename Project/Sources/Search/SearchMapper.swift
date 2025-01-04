import Foundation

final class SearchMapper {
    static func map(
        _ data: PopularAlbumsDTO
    ) -> [PopularAlbumUIO] {
        return data.albums.items.compactMap { albumItem in
            guard let imageUrlString = albumItem.images.first?.url,
                  let imageUrl = URL(string: imageUrlString) else {
                return nil
            }

            return PopularAlbumUIO(
                title: albumItem.name,
                imageUrl: imageUrl
            )
        }
    }
}

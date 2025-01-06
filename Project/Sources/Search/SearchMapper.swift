import Foundation

public final class SearchMapper {
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

    static func map(
        _ data: ArtistAlbumsDTO
    ) -> [ArtistAlbumUIO] {
            return data.items.compactMap { album in
                guard let imageUrlString = album.images.first?.url,
                      let imageUrl = URL(string: imageUrlString) else {
                    return nil
                }

                return ArtistAlbumUIO(
                    title: album.name,
                    releaseDate: album.releaseDate,
                    totalTracks: album.totalTracks,
                    imageUrl: imageUrl
                )
            }
        }
}

import UIKit
import Foundation

final class MainDataSource: DataSource {
    struct Model {
        var popularAlbums: [PopularAlbumUIO]
        var artistAlbums: [ArtistAlbumUIO]
    }

    private lazy var popularDefaultSection = EmptySection.Item()
    private lazy var popularTitleItem = MainTitleCell.Item(
        text: "Popular"
    )
    private lazy var popularSection = MainHorizontalSection.Item(
        type: .popular
    )

    private lazy var artistAlbumsDefaultSection = EmptySection.Item()
    private lazy var artistAlbumsTitleItem = MainTitleCell.Item(
        text: "Artist Albums"
    )
    private lazy var artistAlbumsSection = MainHorizontalSection.Item(
        type: .artistAlbums
    )

    func make(model: Model) -> Snapshot {
        collectionDataSource.make { make in
            make.appendSections(
                popularDefaultSection,
                popularTitleItem,
                popularSection,

                artistAlbumsDefaultSection,
                artistAlbumsTitleItem,
                artistAlbumsSection
            )

            if !model.popularAlbums.isEmpty {
                make.appendItems(popularTitleItem, toSection: popularDefaultSection)
                make.appendItems(
                    makePopularObjectItems(model.popularAlbums),
                    toSection: popularSection
                )
            }

            if !model.artistAlbums.isEmpty {
                make.appendItems(artistAlbumsTitleItem, toSection: artistAlbumsDefaultSection)
                make.appendItems(
                    makeArtistAlbumsItems(model.artistAlbums),
                    toSection: artistAlbumsSection
                )
            }
        }
    }

    // MARK: - Private methods

    private func makePopularObjectItems(_ values: [PopularAlbumUIO]) -> [CardOnMainCell.Item] {
        let maxPopularObjects = 7
        let visiblePopularObjects = values.count > maxPopularObjects ?
            Array(values[0..<maxPopularObjects]) :
            values

        return visiblePopularObjects.map { object -> CardOnMainCell.Item in
            return CardOnMainCell.Item(
                data: object,
                card: .short(maxPopularObjects, object.title)
            )
        }
    }
    
    private func makeArtistAlbumsItems(_ values: [ArtistAlbumUIO]) -> [ArtistAlbumsCell.Item] {
        let maxPopularObjects = 7
        let visiblePopularObjects = values.count > maxPopularObjects ?
            Array(values[0..<maxPopularObjects]) :
            values

        return visiblePopularObjects.map { object -> ArtistAlbumsCell.Item in
            return ArtistAlbumsCell.Item(
                data: object,
                card: .full(
                    maxPopularObjects,
                    object.title,
                    "Tracks: \(object.totalTracks)",
                    object.releaseDate
                )
            )
        }
    }
}

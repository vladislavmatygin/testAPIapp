import UIKit
import Foundation

final class MainDataSource: DataSource {
    struct Model {
        var popularAlbums: [PopularAlbumUIO]
    }

    private lazy var popularDefaultSection = EmptySection.Item()
    private lazy var popularTitleItem = MainTitleCell.Item(
        text: "Popular"
    )
    private lazy var popularSection = MainHorizontalSection.Item(
        type: .popular
    )

    func make(model: Model) -> Snapshot {
        collectionDataSource.make { make in
            make.appendSections(
                popularDefaultSection,
                popularTitleItem,
                popularSection
            )

            if !model.popularAlbums.isEmpty {
                make.appendItems(popularTitleItem, toSection: popularDefaultSection)
                make.appendItems(
                    makeViewedObjectItems(model.popularAlbums),
                    toSection: popularSection
                )
            }
        }
    }

    // MARK: - Private methods

    private func makeViewedObjectItems(_ values: [PopularAlbumUIO]) -> [CardOnMainCell.Item] {
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
}

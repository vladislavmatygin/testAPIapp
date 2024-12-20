import UIKit

final class MainDataSource: DataSource {
    struct Model {
        var popularAlbums: [PopularAlbumUIO]
    }

    func make(model: Model) -> Snapshot {
        collectionDataSource.make { make in
            make.appendSections(

            )
        }
    }

    // MARK: - Private methods

}

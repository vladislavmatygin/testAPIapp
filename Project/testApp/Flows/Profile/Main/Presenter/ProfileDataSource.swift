import UIKit

final class ProfileDataSource: DataSource {
    struct Model {

    }

    func make(model: Model) -> Snapshot {
        collectionDataSource.make { make in
            make.appendSections(

            )
        }
    }

    // MARK: - Private methods

}

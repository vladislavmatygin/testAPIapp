import UIKit

final class ProfileDataSource: DataSource {
    // MARK: - Models

    struct Section: CollectionItemable {
        enum SelfType: Hashable {
            case profile, settings
        }

        let identifier = CollectionIdentifier()
        let type: SelfType
    }

    func make() -> Snapshot {
        collectionDataSource.make(isRedraw: true) { make in
            make.appendSections(Section(type: .profile))
            make.appendItems(
                ProfileUserCell.Item(
                    name: "Vladislav",
                    image: URL(string: ""),
                    phone: "+48 882 082 811"
                )
            )

            make.appendSections(Section(type: .settings))
            make.appendItems(
                ProfilePlainCell.Item(type: .settings),
                ProfilePlainCell.Item(type: .support),
                ProfilePlainCell.Item(type: .aboutApp),
                ProfilePlainCell.Item(type: .debugComponents),
                ProfilePlainCell.Item(type: .logout)
            )
        }
    }

    // MARK: - Private methods

}

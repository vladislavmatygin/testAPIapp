import UIKit

final class MainHorizontalSection: AppCollectionSection {
    enum SelfType: Hashable {
        case recentSearch
        case watched
        case defaultBanner
        case popular
        case reviews
    }

    override func drawSelf() {}

    override func makeConstraints() {}

    override func makeAppearance() {}
}

// MARK: - Configurable
extension MainHorizontalSection: CollectionConfigurable {
    struct Item: CollectionItemable {
        let identifier: CollectionIdentifier
        let type: MainHorizontalSection.SelfType

        init(type: MainHorizontalSection.SelfType) {
            identifier = CollectionIdentifier(type.hashValue)
            self.type = type
        }
    }

    func configure(_ item: Item) {}
}

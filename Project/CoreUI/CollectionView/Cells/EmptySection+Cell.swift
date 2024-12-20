import UIKit
import SnapKit

final class EmptySection: AppCollectionSection {}

extension EmptySection: CollectionConfigurable {
    struct Item: CollectionItemable {
        let identifier = CollectionIdentifier()
    }

    func configure(_ item: Item) {}
}

final class EmptyCell: AppCollectionCell {
    private let containerView = UIView()
    override func drawSelf() {
        contentView.addSubview(containerView)
    }

    override func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(0)
        }
    }

    override func makeAppearance() {
        containerView.backgroundColor = .clear
    }
}

// MARK: - CollectionConfigurable
extension EmptyCell: CollectionConfigurable {
    struct Item: CollectionItemable {
        let identifier = CollectionIdentifier()
        let height: CGFloat

        init(height: CGFloat = 0) {
            self.height = height
        }
    }

    func configure(_ item: Item) {
        containerView.snp.updateConstraints { make in
            make.height.equalTo(item.height)
        }
    }
}

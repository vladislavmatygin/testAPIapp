import UIKit
import SnapKit

final class LoadingCell: AppCollectionCell {
    // MARK: - Properties

    private let containerView = UIView()
    private let indicatorView = ActivityIndicatorView()

    override func prepareForReuse() {
        super.prepareForReuse()
        indicatorView.stopAnimating()
    }

    override func drawSelf() {
        contentView.addSubview(containerView)
        containerView.addSubview(indicatorView)
    }

    override func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().priority(.high)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }

        indicatorView.snp.makeConstraints { make in
            make.center.equalTo(containerView.snp.center)
            make.size.equalTo(48)
        }
    }
}

// MARK: - CollectionConfigurable
extension LoadingCell: CollectionConfigurable {
    struct Item: CollectionItemable {
        let identifier = CollectionIdentifier()
        var isLoading: Bool

        init(isLoading: Bool) {
            self.isLoading = isLoading
        }
    }

    func configure(_ item: Item) {
        indicatorView.startAnimating()
    }
}

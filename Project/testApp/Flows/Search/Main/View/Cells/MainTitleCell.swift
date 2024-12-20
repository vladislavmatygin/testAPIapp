import SnapKit
import UIKit

protocol MainTitleCellDelegate: AnyObject {
    func didTapCell(_ item: MainTitleCell.Item)
}

final class MainTitleCell: AppCollectionCell, Delegatable {
    // MARK: - Properties

    weak var delegate: MainTitleCellDelegate?
    private var item: MainTitleCell.Item?

    private let label = Label.configure(font: .subtitle1)
    private let button = UIButton(type: .system)

    // MARK: - Lifecycle

    override func drawSelf() {
        button.setTitle("more", for: .normal)
        button.titleLabel?.apply(font: .body1)
        button.addAction(for: .touchUpInside) { [weak self] _ in
            guard let item = self?.item else { return }
            self?.delegate?.didTapCell(item)
        }

        addSubview(label)
        addSubview(button)
    }

    override func makeConstraints() {
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(button.snp.leading).offset(-12)
        }

        button.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(24)
        }
    }

    override func makeAppearance() {
        label.textColor = theme.textPrimary
        button.setTitleColor(theme.textPrimary, for: .normal)
    }
}

// MARK: - Configurable
extension MainTitleCell: CollectionConfigurable {
    struct Item: CollectionItemable {
        let identifier = CollectionIdentifier()
        let text: String
        var isMoreHidden: Bool
        init(text: String, isMoreHidden: Bool = true) {
            self.text = text
            self.isMoreHidden = isMoreHidden
        }
    }

    func configure(_ item: Item) {
        self.item = item
        label.text = item.text
        button.isHidden = item.isMoreHidden
        makeAppearance()
    }
}

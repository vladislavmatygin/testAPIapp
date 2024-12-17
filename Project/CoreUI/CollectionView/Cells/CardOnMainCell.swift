import UIKit
import SDWebImage
import SnapKit

@MainActor
protocol CardOnMainCellDelegate: AnyObject {
    func didTapCell(_ item: CardOnMainCell.Item)
}

final class CardOnMainCell: AppCollectionCell, Delegatable {
    // MARK: - Types

    enum Card: Hashable {
        case full(Int, String, String, String, String, [String]?)
        case short(Int, String)

        var isShort: Bool {
            if case .short = self {
                return true
            }
            return false
        }
    }

    // MARK: - Properties

    weak var delegate: CardOnMainCellDelegate?

    private var item: Item?

    private let shadowView = ShadowView(type: .light)

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    private let descriptionLabel = UILabel()

    // MARK: - Life cycle

    override func drawSelf() {
        shadowView.layer.cornerRadius = 16

        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true

        titleLabel.apply(font: .subhead1)

        descriptionLabel.apply(font: .caption2)

        contentView.addSubview(shadowView)

        shadowView.addSubview(imageView)
        shadowView.addSubview(titleLabel)
        shadowView.addSubview(descriptionLabel)

        addGestureRecognizer(
            UITapGestureRecognizer(
                target: self, action: #selector(didTapCardCell)
            )
        )
    }

    override func makeConstraints() {
        shadowView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }

    // MARK: - Actions

    @objc private func didTapCardCell() {
        guard let item else {
            return
        }

        delegate?.didTapCell(item)
    }
}

// MARK: - Configurable
extension CardOnMainCell: CollectionConfigurable {
    struct Item: CollectionItemable {
        let identifier: CollectionIdentifier
        let imageUrl: URL?
        let card: Card
        init(imageUrl: URL?, card: Card) {
            identifier = CollectionIdentifier(card.hashValue)
            self.imageUrl = imageUrl
            self.card = card
        }
    }

    func configure(_ item: Item) {
        self.item = item

        descriptionLabel.isHidden = item.card.isShort

        imageView.sd_setImage(with: item.imageUrl, placeholderImage: UIImage(named: "placeholderImage"))

        switch item.card {
        case let .short(_, title):
            titleLabel.text = title
        default:
            titleLabel.text = ""
        }

        descriptionLabel.numberOfLines = 1
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.lineBreakMode = .byTruncatingTail
    }
}

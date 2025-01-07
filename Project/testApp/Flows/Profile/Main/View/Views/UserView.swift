import SnapKit
import UIKit

final class UserView: AppView {
    // MARK: - Properties

    private let imageView = UIImageView()
    private let containerView = UIView()
    private let stackView = UIStackView()
    private let superhostTag = AppTag()
    private let proUserLabel = PaddingLabel()
    private let titleLabel = Label.configure(font: .body1)
    private let subtitleLabel = Label.configure(font: .caption2)
    private var imageSizeConstraint: Constraint?

    private var item: Item?

    // MARK: - Private methods

    override func drawSelf() {
        stackView.axis = .vertical

        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        superhostTag.configure(AppTag.Item(style: .greenContrast("superUser")))

        proUserLabel.text = "proUser"
        proUserLabel.font = Font.getFont(withType: .subhead4)
        proUserLabel.padding = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        proUserLabel.layer.cornerRadius = 10

        addSubview(imageView)
        addSubview(stackView)

        containerView.addSubview(superhostTag)
        containerView.addSubview(proUserLabel)

        stackView.addArrangedSubview(containerView)
        stackView.addArrangedSubview(titleLabel)

        addSubview(subtitleLabel)
    }

    override func makeConstraints() {
        imageView.snp.makeConstraints {
            imageSizeConstraint = $0.size.equalTo(0).constraint
            $0.leading.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        superhostTag.snp.makeConstraints {
            $0.top.bottom.equalTo(containerView)
            $0.leading.equalTo(containerView.snp.leading)
        }

        proUserLabel.snp.makeConstraints {
            $0.width.equalTo(146)
            $0.height.equalTo(23)
            $0.top.bottom.equalTo(containerView)
            $0.leading.equalTo(containerView.snp.leading)
        }

        stackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.top.equalTo(imageView.snp.top)
            $0.trailing.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.bottom.equalTo(imageView.snp.bottom)
            $0.trailing.equalToSuperview()
        }
    }

    override func makeAppearance() {
        titleLabel.textColor = theme.textPrimary
        subtitleLabel.textColor = theme.textMask
        proUserLabel.backgroundColor = theme.elementDisable
        proUserLabel.textColor = theme.textPrimary
        subtitleLabel.textColor = theme.textPlaceholder
    }
}

// MARK: - Configurable
extension UserView: CollectionConfigurable {
    struct Item: CollectionItemable {
        let identifier = CollectionIdentifier()
        let imageUrl: URL?
        let title: String
        let subtitle: String
        let isSuperhost: Bool
        let isProUser: Bool
        let imageSize: CGFloat

        init(
            imageUrl: URL? = nil,
            title: String,
            subtitle: String,
            isSuperhost: Bool = false,
            isProUser: Bool = false,
            imageSize: CGFloat = 66
        ) {
            self.imageUrl = imageUrl
            self.title = title
            self.subtitle = subtitle
            self.isSuperhost = isSuperhost
            self.isProUser = isProUser
            self.imageSize = imageSize
        }
    }

    func configure(_ item: Item) {
        self.item = item
        imageView.sd_setImage(with: item.imageUrl, placeholderImage: UIImage(named: "placeholderImage"))

        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        superhostTag.isHidden = !item.isSuperhost

        titleLabel.lineBreakMode = .byTruncatingTail

        if item.isSuperhost == false, item.isProUser == true {
            containerView.isHidden = false
            superhostTag.isHidden = true
            proUserLabel.isHidden = false
        } else if item.isSuperhost == true {
            containerView.isHidden = false
            superhostTag.isHidden = false
            proUserLabel.isHidden = true
        } else {
            containerView.isHidden = true
            superhostTag.isHidden = true
            proUserLabel.isHidden = true
        }

        imageView.layer.cornerRadius = item.imageSize / 2
        imageSizeConstraint?.update(offset: item.imageSize)
    }
}

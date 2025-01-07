import UIKit
import SnapKit

@MainActor
protocol ProfilePlainCellDelegate: AnyObject {
    func didTapCell(item: ProfilePlainCell.Item)
}

final class ProfilePlainCell: AppCollectionCell {
    enum Plain: Hashable {
        case settings, aboutApp, support, debugComponents, logout

        var image: UIImage? {
            switch self {
            case .settings: UIImage(named: "iconSettings")
            case .aboutApp: UIImage(named: "iconInfo")
            case .support: UIImage(named: "iconSupport")
            case .debugComponents: UIImage(named: "iconSettings")
            case .logout: UIImage(named: "iconExit")
            }
        }

        var title: String {
            switch self {
            case .settings: "Settings"
            case .aboutApp: "About"
            case .support: "Support"
            case .debugComponents: "Debug components"
            case .logout: "Logout"
            }
        }
    }

    // MARK: - Properties

    weak var delegate: ProfilePlainCellDelegate?

    private let imageView = UIImageView()
    private let textStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private var item: Item?

    // MARK: Private methods

    override func drawSelf() {
        titleLabel.apply(font: .body1)
        subtitleLabel.apply(font: .subhead3)
        textStackView.axis = .vertical
        textStackView.spacing = 4

        contentView.addSubview(imageView)
        contentView.addSubview(textStackView)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)

        contentView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self, action: #selector(didTapView)
            )
        )
    }

    override func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(28)
            make.size.equalTo(24)
        }

        textStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(28)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    override func makeAppearance() {
        titleLabel.textColor = item?.type == .logout ? theme.textErrorUniform : theme.textPrimary
        subtitleLabel.textColor = theme.textSecondary
        imageView.tintColor = item?.type == .logout ? theme.textErrorUniform : theme.elementAdditional
    }

    // MARK: - Actions

    @objc private func didTapView() {
        guard let item else { return }
        delegate?.didTapCell(item: item)
    }
}

// MARK: - Configurable
extension ProfilePlainCell: CollectionConfigurable {
    struct Item: CollectionItemable {
        let identifier: CollectionIdentifier
        let type: Plain
        let subtitle: String?

        init(type: Plain, subtitle: String? = nil) {
            identifier = CollectionIdentifier(type.hashValue)
            self.type = type
            self.subtitle = subtitle
        }
    }

    func configure(_ item: Item) {
        self.item = item

        imageView.image = item.type.image?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = item.type.title
        subtitleLabel.text = item.subtitle

        titleLabel.textColor = item.type == .logout ? theme.textErrorUniform : theme.textPrimary
        imageView.tintColor = item.type == .logout ? theme.textErrorUniform : theme.elementAdditional

        subtitleLabel.isHidden = item.subtitle == nil
    }
}

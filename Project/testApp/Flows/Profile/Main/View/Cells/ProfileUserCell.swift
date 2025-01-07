import UIKit
import SnapKit

@MainActor
protocol ProfileUserViewCellDelegate: AnyObject {
    func didTapProfileEditButton()
    func didTapReviews()
    func didTapUserCell()
}

final class ProfileUserCell: AppCollectionCell {
    // MARK: - Properties

    weak var delegate: ProfileUserViewCellDelegate?

    private let shadowView: ShadowView = {
        let view = ShadowView(type: .medium)
        view.layer.cornerRadius = 16
        return view
    }()

    private let userView = UserView()
    private let editButton = UIButton(type: .system)

    private var item: Item?

    // MARK: Private methods

    override func drawSelf() {
        editButton.setImage(UIImage(named: "iconEditFill"), for: .normal)
        editButton.tintColor = .gray
        editButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)

        contentView.addSubview(shadowView)
        shadowView.addSubview(userView)
        shadowView.addSubview(editButton)


        addGestureRecognizer(
            UITapGestureRecognizer(
                target: self, action: #selector(didTapView)
            )
        )
    }

    override func makeConstraints() {
        shadowView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        userView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(32 + 16)
        }

        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
    }

    // MARK: - Actions

    @objc private func didTapEditButton() {
        delegate?.didTapProfileEditButton()
    }

    @objc private func didTapView() {
        delegate?.didTapUserCell()
    }
}

// MARK: - Configurable
extension ProfileUserCell: CollectionConfigurable {
    struct Item: CollectionItemable {
        let identifier = CollectionIdentifier()
        let name: String
        let image: URL?
        let phone: String
    }

    func configure(_ item: Item) {
        self.item = item
        userView.configure(UserView.Item(
            imageUrl: item.image,
            title: item.name,
            subtitle: item.phone,
            isSuperhost: false,
            imageSize: 48
        ))
    }
}

import SnapKit
import UIKit

protocol MainNavigationViewDelegate: AnyObject {
    func didTapNavigationFindButton()
}

final class MainNavigationView: AppView {
    // MARK: - Properties

    weak var delegate: MainNavigationViewDelegate?

    private let imageView = UIImageView()
    private let button = SearchNavigationButton()

    override func drawSelf() {
        imageView.image = UIImage(named: "fix me")
        button.layer.cornerRadius = 12
        button.addAction(for: .touchUpInside) { [weak self] _ in
            self?.delegate?.didTapNavigationFindButton()
        }

        addSubview(imageView)
        addSubview(button)
    }

    override func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(safeAreaTopInset + 16)
            make.leading.equalToSuperview().inset(16)
        }

        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(24)
        }
    }

    override func makeAppearance() {
        backgroundColor = theme.elementPrimaryUniform
    }

    // MARK: Public methods

    func changeImageViewAlpha(offset: CGFloat) {
        let limit: CGFloat = 20
        let percentage = abs(1 - (offset / limit))
        imageView.alpha = offset > limit ? .zero : percentage
    }
}

final class SearchNavigationButton: AppControl {
    // MARK: - Properties

    private let titleLabel = UILabel()
    private let imageView = UIImageView()

    override func drawSelf() {
        titleLabel.apply(font: .body1, text: "fix me")
        imageView.image = UIImage(named: "fix me")?.withRenderingMode(.alwaysTemplate)

        addSubview(titleLabel)
        addSubview(imageView)
    }

    override func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(48)
        }

        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
    }

    override func makeAppearance() {
        backgroundColor = theme.backgroundForeground
        titleLabel.textColor = theme.textPlaceholder
        imageView.tintColor = theme.elementAdditional
    }
}

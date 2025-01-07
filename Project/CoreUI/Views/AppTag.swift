import UIKit

final class AppTag: AppView {
    enum Style: Hashable {
        case green(String)
        case red(String)
        case dark(String)
        case greenContrast(String)
        case orange(String)
        case error(String)
        case cashback(String)

        var text: String {
            switch self {
            case let .green(text),
                 let .red(text),
                 let .dark(text),
                 let .greenContrast(text),
                 let .orange(text),
                 let .error(text),
                 let .cashback(text):
                text
            }
        }
    }

    enum Size {
        case `default`
        case small
    }

    // MARK: - Properties

    private let stackView = UIStackView()
    private let textLabel = UILabel()
    private let gradientView = GradientView(.horizontal)
    private let imageView = UIImageView()

    private var item: Item?

    // MARK: - Private Methods

    override func drawSelf() {
        layer.masksToBounds = true
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 3)

        stackView.spacing = 3
        stackView.axis = .horizontal
        stackView.alignment = .center

        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholderImage")?.withRenderingMode(.alwaysTemplate)
        imageView.isHidden = true

        textLabel.numberOfLines = 1

        addSubview(gradientView)
        gradientView.addSubview(stackView)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(imageView)
    }

    override func makeConstraints() {
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(14)
        }

        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(2)
        }
    }

    override func makeAppearance() {
        guard let item else { return }
        switch item.style {
        case .cashback:
            layer.shadowColor = theme.elementAccent.cgColor
            imageView.tintColor = theme.backgroundBasic
            applyStyle(
                textColor: theme.textStaticUniform,
                gradientColors: [theme.elementAccent, theme.elementAccentAdd, theme.elementAccent]
            )
        case .dark:
            applyStyle(textColor: theme.textPrimary, backgroundColor: theme.backgroundAdditionalOne)
        case .error:
            applyStyle(textColor: theme.textStaticUniform, backgroundColor: theme.elementError)
        case .green:
            applyStyle(textColor: theme.textSuccess, backgroundColor: theme.backgroundSuccess)
        case .greenContrast:
            applyStyle(textColor: theme.textStaticUniform, backgroundColor: theme.elementSuccess)
        case .orange:
            applyStyle(textColor: theme.textAttention, backgroundColor: theme.backgroundAttentionAdd)
        case .red:
            applyStyle(textColor: theme.textAccent, backgroundColor: theme.backgroundError)
        }
    }

    private func applyStyle(
        textColor: UIColor,
        backgroundColor: UIColor? = nil,
        gradientColors: [UIColor]? = nil
    ) {
        textLabel.textColor = textColor
        imageView.tintColor = textColor

        if let backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let gradientColors {
            gradientView.colors = gradientColors
        }
    }
}

// MARK: - Configurable
extension AppTag: CollectionConfigurable {
    struct Item: CollectionItemable {
        let identifier: CollectionIdentifier
        let style: Style
        let size: Size
        let isIcon: Bool

        init(
            style: Style,
            size: Size = .default,
            isIcon: Bool = false
        ) {
            identifier = CollectionIdentifier(style.hashValue)
            self.style = style
            self.size = size
            self.isIcon = isIcon
        }
    }

    func configure(_ item: Item) {
        self.item = item
        imageView.isHidden = !item.isIcon
        textLabel.text = item.style.text

        if item.size == .small {
            layer.cornerRadius = 10
            textLabel.font = Font.getFont(withType: .caption5)
        } else {
            layer.cornerRadius = 12
            textLabel.font = Font.getFont(withType: .caption1)
        }

        stackView.snp.remakeConstraints {
            $0.height.equalTo(item.size == .small ? 16 : 20)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(2)
        }

        makeAppearance()
    }
}

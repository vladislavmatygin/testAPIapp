import UIKit
import SnapKit

final class TooltipViewController: AppViewController {
    enum ArrowDirection {
        case up
        case down

        var value: UIPopoverArrowDirection {
            switch self {
            case .up: .up
            case .down: .down
            }
        }
    }

    // MARK: - Properties

    private let text: String
    private let arrowDirection: ArrowDirection
    private let sourceView: UIButton

    private lazy var label = Label.configure(text: text, font: .subhead3, numberOfLines: 0)

    private var offset: CGFloat {
        switch arrowDirection {
        case .up: 2
        case .down: -2
        }
    }

    private var sourceRect: CGRect {
        CGRect(x: .zero, y: offset, width: sourceView.frame.width, height: sourceView.frame.height)
    }

    private var defaultColor = UIColor.clear

    // MARK: - Init

    init(text: String, arrowDirection: ArrowDirection, sourceView: UIButton) {
        self.text = text
        self.arrowDirection = arrowDirection
        self.sourceView = sourceView
        super.init()

        modalPresentationStyle = .popover
        popoverPresentationController?.sourceView = sourceView
        popoverPresentationController?.permittedArrowDirections = arrowDirection.value
        popoverPresentationController?.sourceRect = sourceRect
        popoverPresentationController?.delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        preferredContentSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sourceView.tintColor = defaultColor
        sourceView.setImage(UIImage(named: "iconHelp"), for: .normal)
    }

    // MARK: - Private methods

    override func drawSelf() {
        view.addSubview(label)
        defaultColor = sourceView.tintColor
        sourceView.setImage(UIImage(named: "iconHelpActive"), for: .normal)
    }

    override func makeConstraints() {
        view.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(UIScreen.main.bounds.width * 0.8).priority(.high)
        }

        switch arrowDirection {
        case .up:
            label.snp.makeConstraints {
                $0.top.equalToSuperview().inset(20)
                $0.directionalHorizontalEdges.equalToSuperview().inset(10)
                $0.bottom.lessThanOrEqualToSuperview()
            }
        case .down:
            label.snp.makeConstraints {
                $0.top.equalToSuperview().inset(10)
                $0.directionalHorizontalEdges.equalToSuperview().inset(10)
                $0.bottom.lessThanOrEqualToSuperview().inset(10)
            }
        }
    }

    override func makeAppearance() {
        label.textColor = theme.textStaticUniform
        view.backgroundColor = theme.elementSecondaryUniform
        sourceView.tintColor = theme.elementSecondaryUniform
    }
}

// MARK: - UIPopoverPresentationControllerDelegate
extension TooltipViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

import UIKit

final class PaddingLabel: UILabel {
    // MARK: - Properties

    var padding: UIEdgeInsets?

    override public var intrinsicContentSize: CGSize {
        guard let padding else { return super.intrinsicContentSize }

        var size = super.intrinsicContentSize
        size.width += padding.left + padding.right
        size.height += padding.top + padding.bottom

        return size
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override public func drawText(in rect: CGRect) {
        guard let padding else {
            super.drawText(in: rect)
            return
        }

        super.drawText(in: rect.inset(by: padding))
    }

    // MARK: - Private methods

    private func drawSelf() {
        layer.masksToBounds = true
    }
}

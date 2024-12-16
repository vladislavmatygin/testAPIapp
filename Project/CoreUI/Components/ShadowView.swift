import UIKit

public final class ShadowView: AppView {
    private let selfType: SelfType
    private var shape: CAShapeLayer?

    // MARK: - Init

    public init(type: SelfType) {
        selfType = type
        super.init(frame: .zero)
    }

    // MARK: - Life Cycle

    override public func layoutSubviews() {
        super.layoutSubviews()
        guard bounds != .zero else { return }
        drawShape(inside: bounds)
    }

    // MARK: Private methods

    private func drawShape(inside frame: CGRect) {
        let rect = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: layer.cornerRadius)

        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = UIColor.clear.cgColor
        applyShadow(layer: layer, path: path)

        self.shape?.removeFromSuperlayer()
        layer.insertSublayer(shape, at: .zero)
        self.shape = shape
    }

    private func applyShadow(layer: CALayer, path: UIBezierPath) {
        layer.shadowPath = path.cgPath
        layer.shadowColor = selfType.shadow.color.cgColor
        layer.shadowOffset = selfType.shadow.offset
        layer.shadowRadius = selfType.shadow.radius
        layer.shadowOpacity = selfType.shadow.opacity
        layer.masksToBounds = false
    }
}

extension ShadowView {
    public struct Shadow {
        public let color: UIColor
        public let opacity: Float
        public let radius: CGFloat
        public let offset: CGSize
    }

    public enum SelfType: String {
        case ultralight, light, medium, menu, cashback

        fileprivate var shadow: Shadow {
            switch self {
            case .ultralight:
                Shadow(
                    color: theme.elementShadow.withAlphaComponent(0.02),
                    opacity: 1,
                    radius: 10,
                    offset: CGSize(width: 0, height: 5)
                )
            case .light:
                Shadow(
                    color: theme.elementPrimaryUniform.withAlphaComponent(0.08),
                    opacity: 1,
                    radius: 12,
                    offset: CGSize(width: 0, height: 4)
                )
            case .medium:
                Shadow(
                    color: theme.elementPrimaryUniform.withAlphaComponent(0.16),
                    opacity: 1,
                    radius: 30,
                    offset: CGSize(width: 0, height: 6)
                )
            case .menu:
                Shadow(
                    color: theme.elementShadow.withAlphaComponent(0.04),
                    opacity: 1,
                    radius: 15,
                    offset: CGSize(width: 0, height: -4)
                )
            case .cashback:
                Shadow(
                    color: theme.elementCashbackShadow.withAlphaComponent(0.5),
                    opacity: 1,
                    radius: 13,
                    offset: CGSize(width: 0, height: 4)
                )
            }
        }
    }
}

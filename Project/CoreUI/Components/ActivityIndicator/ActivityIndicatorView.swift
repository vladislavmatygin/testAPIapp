import UIKit

public final class ActivityIndicatorView: AppView {
    // MARK: - Properties

    private enum Constants {
        static let size: CGSize = .init(width: 24, height: 24)
    }

    public var color: UIColor = .red {
        didSet {
            indicator.strokeColor = color.cgColor
            setNeedsLayout()
        }
    }

    public var lineWidth: CGFloat = 3 {
        didSet {
            indicator.lineWidth = lineWidth
            setNeedsLayout()
        }
    }

    override public var intrinsicContentSize: CGSize {
        return Constants.size
    }

    private let indicator = CAShapeLayer()
    private let animator = ActivityIndicatorAnimator()
    private var isAnimating = false

    // MARK: - Life cycle

    override public func layoutSubviews() {
        super.layoutSubviews()

        indicator.frame = bounds
        let diameter = bounds.size.min - indicator.lineWidth
        let path = UIBezierPath(center: bounds.center, radius: diameter / 2)
        indicator.path = path.cgPath
    }

    override public func removeFromSuperview() {
        super.removeFromSuperview()
        stopAnimating()
    }

    // MARK: Public methods

    public func startAnimating() {
        guard !isAnimating else { return }

        animator.addAnimation(to: indicator)
        isAnimating = true
    }

    public func stopAnimating() {
        guard isAnimating else { return }

        animator.removeAnimation(from: indicator)
        isAnimating = false
    }

    // MARK: Private methods

    override public func drawSelf() {
        backgroundColor = .clear
        indicator.strokeColor = color.cgColor
        indicator.fillColor = nil
        indicator.lineWidth = lineWidth
        indicator.strokeStart = .zero
        indicator.strokeEnd = .zero
        layer.addSublayer(indicator)
    }
}

extension UIBezierPath {
    convenience init(center: CGPoint, radius: CGFloat) {
        self.init(arcCenter: center,
                  radius: radius,
                  startAngle: .zero,
                  endAngle: CGFloat(CGFloat.pi * 2),
                  clockwise: true)
    }
}

extension CAPropertyAnimation {
    enum Key: String {
        var path: String {
            return rawValue
        }

        case strokeStart
        case strokeEnd
        case strokeColor
        case rotationZ = "transform.rotation.z"
        case scale = "transform.scale"
    }

    convenience init(key: Key) {
        self.init(keyPath: key.path)
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension CGSize {
    var min: CGFloat {
        return .minimum(width, height)
    }
}

import UIKit

final class GradientView: AppView {
    enum Direction {
        case vertical
        case horizontal
    }

    // MARK: - Properties

    override public static var layerClass: AnyClass {
        CAGradientLayer.self
    }

    var colors: [UIColor] {
        didSet {
            drawSelf()
        }
    }

    private let direction: Direction

    // MARK: - Init

    init(_ direction: Direction = .vertical, colors: [UIColor] = []) {
        self.direction = direction
        self.colors = colors
        super.init(frame: .zero)
    }

    // MARK: - Private methods

    override func drawSelf() {
        guard let gradientLayer = layer as? CAGradientLayer else {
            return
        }

        if case .horizontal = direction {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }

        gradientLayer.colors = colors.map(\.cgColor)
    }

    override func makeAppearance() {
        backgroundColor = .clear
    }
}

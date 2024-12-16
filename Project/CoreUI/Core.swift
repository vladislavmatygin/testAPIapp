import Foundation
import UIKit

public protocol ViewInput<State>: AnyObject {
    associatedtype State
    func apply(_ state: State)
}

public protocol AppViewable {
    func drawSelf()
    func makeConstraints()
    func makeAppearance()
}

// MARK: - AppView
open class AppView: UIView, AppViewable {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
        makeConstraints()
        makeAppearance()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(frame:) has not been implemented")
    }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        makeAppearance()
    }

    open func drawSelf() {}
    open func makeConstraints() {}
    open func makeAppearance() {}
}

// MARK: - AppControl
open class AppControl: UIControl, AppViewable {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
        makeConstraints()
        makeAppearance()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(frame:) has not been implemented")
    }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        makeAppearance()
    }

    open func drawSelf() {}
    open func makeConstraints() {}
    open func makeAppearance() {}
}

// MARK: - AppStackView
open class AppStackView: UIStackView, AppViewable {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
        makeConstraints()
        makeAppearance()
    }

    @available(*, unavailable)
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        makeAppearance()
    }

    open func drawSelf() {}
    open func makeConstraints() {}
    open func makeAppearance() {}
}

// MARK: - AppCollectionCell
open class AppCollectionCell: UICollectionViewCell, AppViewable {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
        makeConstraints()
        makeAppearance()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(frame:) has not been implemented")
    }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        makeAppearance()
    }

    open func drawSelf() {}
    open func makeConstraints() {}
    open func makeAppearance() {}
}

// MARK: - AppCollectionSection
open class AppCollectionSection: UICollectionReusableView, AppViewable {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
        makeConstraints()
        makeAppearance()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(frame:) has not been implemented")
    }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        makeAppearance()
    }

    open func drawSelf() {}
    open func makeConstraints() {}
    open func makeAppearance() {}
}

// MARK: - AppViewController
public final class SomeView: AppView {}

open class AppViewController: UIViewController, AppViewable {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func loadView() {
        view = SomeView()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
        makeConstraints()
        makeAppearance()
    }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        makeAppearance()
    }

    open func drawSelf() {}
    open func makeConstraints() {}
    open func makeAppearance() {}
}

// MARK: - AppTextView
open class AppTextView: UITextView, AppViewable {
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        drawSelf()
        makeConstraints()
        makeAppearance()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(frame:) has not been implemented")
    }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        makeAppearance()
    }

    open func drawSelf() {}
    open func makeConstraints() {}
    open func makeAppearance() {}
}

// MARK: - HighlightableCell

public protocol HighlightableCell {
    func didHighlight(_ isHighlighted: Bool)
}

public extension HighlightableCell {
    func didHighlight(_ highlighted: Bool) {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
//            self.transform = highlighted ? CGAffineTransform(scaleX: 0.8, y: 0.8) : .identity
        }
    }
}

// MARK: - SelectableCell
public protocol SelectableCell {
    func didSelect()
}

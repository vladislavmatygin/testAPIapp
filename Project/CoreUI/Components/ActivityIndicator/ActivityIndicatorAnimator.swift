import UIKit

final class ActivityIndicatorAnimator {

    // MARK: - Properties

    enum Animation: String {
        case spring = "indicator.spring"
        case rotation = "indicator.rotation"
    }

    // MARK: - Public methods

    public func addAnimation(to layer: CALayer) {
        layer.add(rotationAnimation(), forKey: Animation.rotation.rawValue)
        layer.add(springAnimation(), forKey: Animation.spring.rawValue)
    }

    public func removeAnimation(from layer: CALayer) {
        layer.removeAnimation(forKey: Animation.rotation.rawValue)
        layer.removeAnimation(forKey: Animation.spring.rawValue)
    }

    // MARK: - Private methods

    private func rotationAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .rotationZ)
        animation.duration = 4
        animation.fromValue = 0
        animation.toValue = (2.0 * .pi)
        animation.repeatCount = .infinity

        return animation
    }

    private func springAnimation() -> CAAnimationGroup {
        let animation = CAAnimationGroup()
        animation.duration = 1.5
        animation.animations = [
            strokeStartAnimation(),
            strokeEndAnimation(),
            strokeCatchAnimation(),
            strokeFreezeAnimation()
        ]
        animation.repeatCount = .infinity

        return animation
    }

    private func strokeStartAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeStart)
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 0.15
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        return animation
    }

    private func strokeEndAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeEnd)
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        return animation
    }

    private func strokeCatchAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeStart)
        animation.beginTime = 1
        animation.duration = 0.5
        animation.fromValue = 0.15
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        return animation
    }

    private func strokeFreezeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .strokeEnd)
        animation.beginTime = 1
        animation.duration = 0.5
        animation.fromValue = 1
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        return animation
    }

}

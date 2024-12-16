import UIKit

extension UIApplication {
    public enum InterfaceStyle: String {
        case unspecified
        case light
        case dark
    }

    public var style: UIUserInterfaceStyle {
        let userSavedStyle = InterfaceStyle(rawValue: UserDefaults.standard.string(forKey: "InterfaceStyle") ?? "unspecified")

        return switch userSavedStyle {
        case .dark: .dark
        case .light: .light
        default: .unspecified
        }
    }

    public var theme: Themeable {
        let userSavedStyle = InterfaceStyle(rawValue: UserDefaults.standard.string(forKey: "InterfaceStyle") ?? "unspecified")
        let window = connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        let interfaceStyle = window?.windowScene?.traitCollection.userInterfaceStyle ??
            UITraitCollection.current.userInterfaceStyle

        switch userSavedStyle {
        case .light:
            return LightTheme()
        case .dark:
            return DarkTheme()
        default:
            return interfaceStyle == .light ?
                LightTheme() :
                DarkTheme()
        }
    }

    public var isLight: Bool {
        let userSavedStyle = InterfaceStyle(rawValue: UserDefaults.standard.string(forKey: "InterfaceStyle") ?? "unspecified")
        let window = connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        let interfaceStyle = window?.windowScene?.traitCollection.userInterfaceStyle ??
            UITraitCollection.current.userInterfaceStyle

        switch userSavedStyle {
        case .light:
            return true
        case .dark:
            return false
        default:
            return interfaceStyle == .light ?
                true :
                false
        }
    }
}

extension UIWindow {
    public func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }

    public func notifyAppearanceChanged() {
        guard let windowScene = windowScene,
              let sceneDelegate = windowScene.delegate as? UIWindowSceneDelegate else {
            return
        }

        sceneDelegate.windowScene?(
            windowScene,
            didUpdate: windowScene.coordinateSpace,
            interfaceOrientation: windowScene.interfaceOrientation,
            traitCollection: windowScene.traitCollection
        )
    }
}

extension UIView {
    public class func app_appearance() -> Self {
        return app_appearanceWhenContainedInClasses([])
    }

    public class func app_appearanceWhenContainedInClass(_ object: UIAppearanceContainer.Type) -> Self {
        return app_appearanceWhenContainedInClasses([object])
    }

    public class func app_appearanceWhenContainedInClasses(_ classes: [UIAppearanceContainer.Type]) -> Self {
        guard !classes.isEmpty else {
            return appearance()
        }

        return appearance(whenContainedInInstancesOf: classes)
    }
}

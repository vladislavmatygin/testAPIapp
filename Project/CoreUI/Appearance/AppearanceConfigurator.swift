import UIKit

final class AppearanceConfigurator {
    // MARK: - Properties

    private let theme: Themeable

    // MARK: - Init

    init(theme: Themeable) {
        self.theme = theme
    }

    public func makeDefaultColors() {
        // UINavigationBar
        let navigationBar = UINavigationBar.app_appearance()
        navigationBar.tintColor = theme.elementPrimary

        // SomeView - view VC
        let someView = SomeView.app_appearanceWhenContainedInClass(AppViewController.self)
        someView.backgroundColor = theme.backgroundBasic

        // AppView
        let anotherView = AppView.app_appearanceWhenContainedInClass(AppViewController.self)
        anotherView.backgroundColor = theme.backgroundBasic

        // UILabel
        let uiLabel = UILabel.app_appearanceWhenContainedInClass(AppViewController.self)
        uiLabel.backgroundColor = .clear
        uiLabel.textColor = theme.textPrimary

        // UIStackView
        let stackView = UIStackView.app_appearanceWhenContainedInClass(AppViewController.self)
        stackView.backgroundColor = .clear

        // UICollectionView
        let collectionView = UICollectionView.app_appearance()
        collectionView.backgroundColor = .clear

        // UICollectionReusableView
        let reusableView = UICollectionReusableView.app_appearanceWhenContainedInClass(AppViewController.self)
        reusableView.backgroundColor = .clear

        // UITabBar
        let tabBar = UITabBar.app_appearanceWhenContainedInClass(MenuTabBarController.self)
        tabBar.tintColor = theme.elementAccent
        tabBar.unselectedItemTintColor = theme.elementPrimary
        tabBar.backgroundColor = theme.backgroundBasic

        // ShadowView
        let shadowView = ShadowView.app_appearance()
        shadowView.backgroundColor = theme.backgroundBasic
    }

    static func changeAppearance() {
        UIApplication.shared
            .keyWindow?
            .notifyAppearanceChanged()
    }
}

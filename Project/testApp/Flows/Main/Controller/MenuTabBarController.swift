import UIKit

final class MenuTabBarController: UITabBarController {
    // MARK: - Properties

    private var lastSelectedController: UIViewController?

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
        drawSelf()
        makeAppearance()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        makeAppearance()
    }

    // MARK: Private methods

    private func drawSelf() {
        delegate = self
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        tabBar.layer.shadowOpacity = 0.042
    }

    private func makeAppearance() {
        let appearance = tabBar.standardAppearance.copy()
        appearance.shadowColor = .clear
        appearance.backgroundColor = theme.backgroundBasic

        let normalAppearance = appearance.stackedLayoutAppearance.normal
        normalAppearance.titleTextAttributes = [.foregroundColor: theme.textPlaceholder]
        normalAppearance.iconColor = theme.elementPrimary
        normalAppearance.badgeBackgroundColor = theme.elementAccent
        normalAppearance.badgeTextAttributes = [
            .font: Font.getFont(withType: .caption4),
            .foregroundColor: theme.textStaticUniform
        ]

        let selectedAppearance = appearance.stackedLayoutAppearance.selected
        selectedAppearance.titleTextAttributes = [.foregroundColor: theme.elementAccent]
        selectedAppearance.iconColor = theme.elementAccent

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}

// MARK: - UITabBarControllerDelegate
extension MenuTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        UISelectionFeedbackGenerator().selectionChanged()
        if viewController === lastSelectedController {
            lastSelectedController = nil
        }
        lastSelectedController = viewController
    }
}

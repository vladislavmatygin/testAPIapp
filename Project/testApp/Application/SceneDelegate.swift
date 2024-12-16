import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    
    private var router: ApplicationRouter?
    var window: UIWindow?

    // MARK: - Life cycle

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        makeAppearance()
        router = ApplicationRouter(window: window)
        router?.to(.main)
    }

    func windowScene(
        _ windowScene: UIWindowScene,
        didUpdate previousCoordinateSpace: UICoordinateSpace,
        interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation,
        traitCollection previousTraitCollection: UITraitCollection
    ) {
        makeAppearance()
    }

    // MARK: Private methods

    private func makeAppearance() {
        var style = UIApplication.shared.style
        var theme = UIApplication.shared.theme

        #if DEBUG
        #else
            style = .light
            theme = LightTheme()
        #endif

        window?.overrideUserInterfaceStyle = style
        ThemeService.shared.themeable = theme

        AppearanceConfigurator(theme: theme)
            .makeDefaultColors()

        window?.reload()
    }
}

import UIKit

final class GlobalRouter: Router {
    enum Route: Routable {
        case search
        case profile

        var index: Int {
            switch self {
            case .search: 0
            case .profile: 1
            default: -1
            }
        }
    }

    // MARK: - Properties

    private(set) static var shared: GlobalRouter?
    private(set) var searchRouter: MainRouter?
    private(set) var profileRouter: ProfileRouter?

    weak var navigationController: UINavigationController?

    private let tabBarController = MenuTabBarController()

    // MARK: Init

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        configureRouter()

        Self.shared = self
    }

    // MARK: - Public methods

    @MainActor
    func to(_ route: Route) {
        switch route {
        case .search:
            let navigationController = UINavigationController()

            navigationController.tabBarItem.image = UIImage(named: "iconMenuSearch")
            navigationController.tabBarItem.title = "Search"

            let router = MainRouter(navigationController: navigationController)
            searchRouter = router

            let viewController = SearchBuilder.build(router: router)

            navigationController.viewControllers = [viewController]

            tabBarController.viewControllers = (tabBarController.viewControllers ?? []) + [navigationController]
        case .profile:
            let navigationController = UINavigationController()

            navigationController.tabBarItem.image = UIImage(named: "iconMenuCabinet")
            navigationController.tabBarItem.title = "Profile"

            let router = ProfileRouter(navigationController: navigationController)
            profileRouter = router

            let viewController = ProfileBuilder.build(router: router)

            navigationController.viewControllers = [viewController]

            tabBarController.viewControllers = (tabBarController.viewControllers ?? []) + [navigationController]
        }
    }

    // MARK: - Private methods

    private func configureRouter() {
        navigationController?.viewControllers = [tabBarController]
    }
}

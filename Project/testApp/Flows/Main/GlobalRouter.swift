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
        default:
            let navigationController = UINavigationController()

            navigationController.tabBarItem.image = UIImage(named: "iconMenuSearch")
            navigationController.tabBarItem.title = "Search"

            let router = MainRouter(navigationController: navigationController)
            searchRouter = router

            let viewController = SearchBuilder.build(router: router)

            navigationController.viewControllers = [viewController]

            tabBarController.viewControllers = (tabBarController.viewControllers ?? []) + [navigationController]
        }
    }

    // MARK: - Private methods

    private func configureRouter() {
        navigationController?.viewControllers = [tabBarController]
    }
}

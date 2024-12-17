import UIKit

@MainActor
protocol ProfileFlowPresenterModuleOutput: AnyObject {
    func didTap()
}

extension ProfileFlowPresenterModuleOutput {
    func didTap() {}
}

final class ProfileRouter: Router {
    typealias ModuleOutput = ProfileFlowPresenterModuleOutput

    enum Route: Routable {
        case searchOnMap
    }

    // MARK: - Properties

    weak var navigationController: UINavigationController?
    weak var moduleOutput: ModuleOutput?

    // MARK: Init

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    // MARK: - Public methods

    func to(_ route: Route) {
        switch route {
        case .searchOnMap:
            guard let navigationController, let rootViewController = navigationController.viewControllers.first else {
                return
            }
        }
    }

    func moveToRoot() {
        guard let navigationController else { return }

        let searchTabIndex = GlobalRouter.Route.profile.index

        if let tabBarController = navigationController.parent as? UITabBarController,
           tabBarController.selectedIndex != searchTabIndex {
            tabBarController.selectedIndex = searchTabIndex
        }

        if navigationController.topViewController != navigationController.visibleViewController {
            navigationController.dismiss(animated: false)
        }

        let isMainViewController = navigationController.topViewController is ProfileViewController

        if !isMainViewController {
            navigationController.popToRootViewController(animated: false)
        }
    }
}

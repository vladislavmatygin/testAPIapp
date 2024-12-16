import UIKit

struct ApplicationRouter: Router {
    enum Route: Routable {
        case splash
        case openURL(URL)
        case main
    }

    // MARK: - Properties

    weak var navigationController: UINavigationController?
    private var window: UIWindow?

    // MARK: Init

    init(navigationController: UINavigationController?) {}

    init(window: UIWindow?) {
        self.window = window

        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        self.navigationController = navigationController
    }

    // MARK: - Public methods

    func to(_ route: Route) {
        switch route {
        case .main:
            let router = GlobalRouter(navigationController: navigationController)
            let routes: [GlobalRouter.Route] = [.search, .profile]
            routes.forEach { router.to($0) }
        default:
            let router = GlobalRouter(navigationController: navigationController)
            let routes: [GlobalRouter.Route] = [.search, .profile]
            routes.forEach { router.to($0) }
//        case .splash:
//            let coordinator: SplashScreenCoordinatorModuleInput = SplashScreenCoordinator(
//                navigationController: navigationController
//            )
//            coordinator.show(on: window?.windowScene)
//
//        case let .openURL(url):
//            let router = URLRouter(navigationController: navigationController)
//            router.to(.openURL(url))
        }
    }
}

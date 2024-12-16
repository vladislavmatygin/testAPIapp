import UIKit

protocol Routable {}

@MainActor
protocol Router {
    associatedtype Route: Routable

    var navigationController: UINavigationController? { get }

    init(navigationController: UINavigationController?)

    func to(_ route: Route)
}

extension Router {
    init(_ router: any Router) {
        self.init(navigationController: router.navigationController)
    }

    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }

    func dismissPresented(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.presentedViewController?.dismiss(animated: animated)
    }

    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
}

extension Router {
    func tooltip(text: String, arrowDirection: TooltipViewController.ArrowDirection, sourceView: UIButton) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let navigationController = scene.windows.first?.rootViewController as? UINavigationController,
              let visibleViewController = navigationController.visibleViewController else { return }

        let tooltipVC = TooltipViewController(text: text, arrowDirection: arrowDirection, sourceView: sourceView)
        visibleViewController.present(tooltipVC, animated: true, completion: nil)
    }
}

struct DefaultRouter: Router {
    enum Route: Routable {
        case share(Any)
    }

    weak var navigationController: UINavigationController?

    func to(_ route: Route) {
        switch route {
        case let .share(data):
            let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)

            navigationController?.present(activityViewController, animated: true)
        }
    }
}

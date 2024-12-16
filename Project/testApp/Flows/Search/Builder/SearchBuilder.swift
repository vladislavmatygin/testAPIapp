import UIKit

@MainActor
struct SearchBuilder: Builder {
    static func build(
        router: MainRouter
    ) -> UIViewController {
        let dataSource = MainDataSource()
        let presenter = MainPresenter(
            router: router,
            dataSource: dataSource
        )
        router.moduleOutput = presenter as? any MainRouter.ModuleOutput

        let viewController = MainViewController(presenter: presenter)
        presenter.view = viewController
        viewController.collectionView.actionDelegate = presenter
        dataSource.collectionDataSource = viewController.collectionView.selfDataSource
        return viewController
    }
}

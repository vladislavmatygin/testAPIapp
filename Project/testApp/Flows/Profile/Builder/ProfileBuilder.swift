import UIKit

@MainActor
struct ProfileBuilder: Builder {
    static func build(
        router: ProfileRouter
    ) -> UIViewController {
        let dataSource = ProfileDataSource()
        let presenter = ProfilePresenter(
            router: router,
            dataSource: dataSource
        )
        router.moduleOutput = presenter as? any ProfileRouter.ModuleOutput

        let viewController = ProfileViewController(presenter: presenter)
        presenter.view = viewController
        viewController.collectionView.actionDelegate = presenter
        dataSource.collectionDataSource = viewController.collectionView.selfDataSource
        return viewController
    }
}

import AppTrackingTransparency
import Combine
import CoreLocation
import Foundation

protocol ProfilePresenterOutput: AnyObject, ViewOutput {
    func didTapNavigationView()
}

final class ProfilePresenter {
    private struct State {
        // states
    }

    // MARK: - Properties

    weak var view: (any ProfileViewInput)?

    private let dataSource: ProfileDataSource

    private var cancellables = Set<AnyCancellable>()
    private let router: ProfileRouter

    @Published private var state = State()

    // MARK: - Init

    init(router: ProfileRouter, dataSource: ProfileDataSource) {
        self.router = router
        self.dataSource = dataSource
    }

    // MARK: - Private methods

    private func configurePresenter() {
        $state.sink { [weak self] state in
            guard let self else { return }

            let result = dataSource.make(
                model: ProfileDataSource.Model()
            )

            view?.apply(.isLoading(false))
            view?.apply(.snapshot(result))
        }.store(in: &cancellables)
    }

    private func setState(_ updateState: (inout State) -> Void) async {
        await MainActor.run {
            updateState(&state)
        }
    }
}

// MARK: - MainPresenterOutput
extension ProfilePresenter: ProfilePresenterOutput {

    func didTapNavigationView() {}

    func viewDidLoad() {
        view?.apply(.isLoading(true))

        configurePresenter()
    }
}

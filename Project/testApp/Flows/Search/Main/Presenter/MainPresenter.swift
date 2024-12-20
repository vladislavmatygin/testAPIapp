import AppTrackingTransparency
import Combine
import CoreLocation
import Foundation

protocol MainPresenterOutput: AnyObject, ViewOutput {
    func didTapNavigationView()
}

final class MainPresenter {
    private struct State {
        var popularAlbums: [PopularAlbumUIO] = []
    }

    // MARK: - Properties

    weak var view: (any MainViewInput)?

    private let searchService = SearchService.shared
    private let dataSource: MainDataSource

    private var cancellables = Set<AnyCancellable>()
    private let router: MainRouter

    @Published private var state = State()

    // MARK: - Init

    init(router: MainRouter, dataSource: MainDataSource) {
        self.router = router
        self.dataSource = dataSource
    }

    // MARK: - Private methods

    private func configurePresenter() {
        $state.sink { [weak self] state in
            guard let self else { return }

            let result = dataSource.make(
                model: MainDataSource.Model(
                    popularAlbums: state.popularAlbums
                )
            )

            view?.apply(.isLoading(false))
            view?.apply(.snapshot(result))
        }.store(in: &cancellables)

        searchService.searchActionSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] action in
                switch action {
                case let .addPopularAlbums(albums):
                    //TODO: finish this
                    break
                }
            }.store(in: &cancellables)
    }

    private func setState(_ updateState: (inout State) -> Void) async {
        await MainActor.run {
            updateState(&state)
        }
    }
}

// MARK: - MainPresenterOutput
extension MainPresenter: MainPresenterOutput {

    func didTapNavigationView() {}
    
    func viewDidLoad() {
        view?.apply(.isLoading(true))

        configurePresenter()
    }
}

// MARK: - SearchNavigationViewDelegate
extension MainPresenter: MainNavigationViewDelegate {
    func didTapNavigationFindButton() {
        
    }
}

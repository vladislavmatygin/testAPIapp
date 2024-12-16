import Combine
import UIKit
import SnapKit

protocol MainViewInput: ViewInput<MainViewController.State> {}

final class MainViewController: AppViewController, ProgressView {
    enum State {
        case snapshot(Snapshot)
        case isLoading(Bool)
        case scrollToFirstItem(Bool)
    }

    // MARK: - Properties

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private(set) var collectionView = CollectionView()

    private let presenter: MainPresenterOutput
    private let closedHeaderHeight: CGFloat = 65
    private lazy var commonNavigationBarHeight: CGFloat = safeAreaTopInset + 16 + 86 + 22

    private let openHeaderHeight: CGFloat = 130
    private let lowerLimit: CGFloat = .zero
    private let upperLimit: CGFloat = 55

    private(set) var isHeaderOpen = true

    private let navigationView = MainNavigationView()
    private lazy var navigationViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapNavigationBar))

    private var cancellables = Set<AnyCancellable>()
    private let actualScrolledIndexPathSubject = PassthroughSubject<IndexPath, Never>()

    // MARK: - Init

    init(presenter: MainPresenterOutput) {
        self.presenter = presenter
        super.init()
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithTransparentBackground()
        navigationItem.standardAppearance = navigationAppearance
        navigationItem.scrollEdgeAppearance = navigationAppearance
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()

        if tabBarController?.tabBar.isHidden == true {
            tabBarController?.tabBar.isHidden = false
        }

        if let navigationBar = navigationController?.navigationBar {
            navigationBar.addGestureRecognizer(navigationViewTapGesture)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let navigationBar = navigationController?.navigationBar {
            navigationBar.removeGestureRecognizer(navigationViewTapGesture)
        }
    }

    override func drawSelf() {
        collectionView.layoutDelegate = self
        navigationView.delegate = presenter as? MainPresenter

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

//        collectionView.register(header: MainHorizontalSection.self)
//        collectionView.register(header: EmptySection.self)
//        collectionView.register(
//            MainTitleCell.self,
//            SUCardOnMainCell.self,
//            MainReviewCell.self,
//            MainReviewSkeletonCell.self,
//            MainRecentSearchCell.self,
//            MainBannerCell.self,
//            MainOtherPeopleReviewCell.self
//        )

        collectionView.layer.cornerRadius = 16
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.clipsToBounds = true
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true

        view.addSubview(navigationView)
        view.addSubview(collectionView)
    }

    override func makeConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(commonNavigationBarHeight)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func makeAppearance() {
        view.backgroundColor = theme.backgroundExtraSurface
    }

    // MARK: - Private methods
    @objc private func didTapNavigationBar() {
        presenter.didTapNavigationView()
    }
}

// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    @MainActor
    func apply(_ state: State) {
        switch state {
        case let .snapshot(snapshot):
            collectionView.apply(snapshot)

        case let .isLoading(isLoading):
            progress(isLoading: isLoading)

        case let .scrollToFirstItem(animated):
            guard collectionView.numberOfSections > 0,
                  collectionView.numberOfItems(inSection: 0) > 0 else {
                return
            }
            collectionView.scrollToItem(
                at: IndexPath(item: .zero, section: .zero),
                at: .left,
                animated: animated
            )
        }
    }
}

// MARK: - CollectionViewLayoutDelegate
extension MainViewController: CollectionViewLayoutDelegate {
    func makeLayout(dataSource: CollectionDataSource) -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] index, _ in
            guard let self, let id = dataSource.sectionIdentifier(for: index) else {
                fatalError()
            }

//            let searchSection = dataSource.getSection(id) as? MainHorizontalSection.Item

            var groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
            let horizontalInset: CGFloat = 8
            var sectionContentInsets: NSDirectionalEdgeInsets = .zero

            groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(54))

            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )

            group.contentInsets = .init(top: .zero, leading: horizontalInset, bottom: .zero, trailing: horizontalInset)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsetsReference = .readableContent
            section.interGroupSpacing = -8

            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = sectionContentInsets

            section.visibleItemsInvalidationHandler = { items, offset, _ in
                guard let item = items.first else { return }

                let offsetX = offset.x - horizontalInset
                let itemIndex = Int(offsetX / (item.frame.width + 8))

                self.actualScrolledIndexPathSubject.send([index, itemIndex])
            }

            return section

        }, configuration: config)

        return layout
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

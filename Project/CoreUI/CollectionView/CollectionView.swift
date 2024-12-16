import UIKit

extension UICollectionViewCompositionalLayout {
    static var defaultHeader: UICollectionViewCompositionalLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        config.headerTopPadding = 0
        config.headerMode = .supplementary
        config.backgroundColor = .clear
        config.showsSeparators = false

        let layout = UICollectionViewCompositionalLayout.list(using: config)

        return layout
    }

    static var `default`: UICollectionViewCompositionalLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        config.headerMode = .none
        config.backgroundColor = .clear
        config.showsSeparators = false

        let layout = UICollectionViewCompositionalLayout.list(using: config)

        return layout
    }
}

protocol CollectionViewLayoutDelegate: AnyObject {
    func makeLayout(dataSource: CollectionDataSource) -> UICollectionViewLayout
}

protocol CollectionViewDelegate: AnyObject {
    func collectionView(
        _ collectionView: CollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath
    )
    func collectionView(
        _ collectionView: CollectionView,
        didEndDisplayingSupplementaryView view: UICollectionReusableView,
        forElementOfKind elementKind: String,
        at indexPath: IndexPath
    )

    func scrollViewDidScroll(_ scrollView: UIScrollView)
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
}

extension CollectionViewDelegate {
    func collectionView(
        _ collectionView: CollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath
    ) {}
    func collectionView(
        _ collectionView: CollectionView,
        didEndDisplayingSupplementaryView view: UICollectionReusableView,
        forElementOfKind elementKind: String,
        at indexPath: IndexPath
    ) {}
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {}
}

protocol CollectionViewLoadMoreDelegate: AnyObject {
    func loadMore()
}

extension UICollectionView {
    func setCollectionViewLayout(_ layout: UICollectionViewLayout?, animated: Bool) {
        if let layout {
            setCollectionViewLayout(layout, animated: animated)
        }
    }
}

class CollectionView: UICollectionView {
    private(set) lazy var selfDataSource = makeDataSource()

    weak var actionDelegate: AnyObject?
    weak var loadMoreDelegate: CollectionViewLoadMoreDelegate?
    weak var viewDelegate: CollectionViewDelegate?
    weak var layoutDelegate: CollectionViewLayoutDelegate? {
        didSet {
            setCollectionViewLayout(
                layoutDelegate?.makeLayout(dataSource: selfDataSource),
                animated: false
            )
        }
    }

    init(layout: UICollectionViewCompositionalLayout = .default) {
        super.init(frame: .zero, collectionViewLayout: layout)
        drawSelf()
    }

    required init?(coder: NSCoder) { nil }

    func drawSelf() {
        delegate = self
    }

    private func makeDataSource() -> CollectionDataSource {
        let dataSource = CollectionDataSource(collectionView: self) { collectionView, indexPath, item in
            guard let collectionView = collectionView as? Self,
                  let model = collectionView.selfDataSource.getItem(item) else {
                return UICollectionViewCell()
            }

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reuseIdentifier, for: indexPath)
            (cell as? (any CollectionConfigurable))?.configure(any: model)
            (cell as? (any Delegatable))?.setAnyDelegate(self.actionDelegate)

            return cell
        }

        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            guard
                let sectionIdentifier = dataSource.sectionIdentifier(for: indexPath.section),
                let model = dataSource.getSection(sectionIdentifier) else {
                return UICollectionReusableView()
            }

            let reuseIdentifier = (model as? CollectionSectionable)?.reuseIdentifier(kind: elementKind) ??
                model.reuseIdentifier

            let section = collectionView.dequeueReusableSupplementaryView(
                ofKind: elementKind, withReuseIdentifier: reuseIdentifier, for: indexPath
            )

            (section as? (any CollectionConfigurable))?.configure(any: model)
            (section as? (any Delegatable))?.setAnyDelegate(self.actionDelegate)

            return section
        }

        return dataSource
    }

    func apply(
        _ snapshot: Snapshot,
        animatingDifferences: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        selfDataSource.safeApply(
            snapshot,
            animatingDifferences: animatingDifferences,
            completion: completion
        )
    }
}

extension CollectionView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if cell is LoadingCell {
            loadMoreDelegate?.loadMore()
        }
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (collectionView.cellForItem(at: indexPath) as? SelectableCell)?.didSelect()
    }

    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        true
    }

    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        true
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        (collectionView.cellForItem(at: indexPath) as? HighlightableCell)?.didHighlight(true)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        (collectionView.cellForItem(at: indexPath) as? HighlightableCell)?.didHighlight(false)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath
    ) {
        viewDelegate?.collectionView(
            self,
            willDisplaySupplementaryView: view,
            forElementKind: elementKind,
            at: indexPath
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplayingSupplementaryView view: UICollectionReusableView,
        forElementOfKind elementKind: String,
        at indexPath: IndexPath
    ) {
        viewDelegate?.collectionView(
            self,
            didEndDisplayingSupplementaryView: view,
            forElementOfKind: elementKind,
            at: indexPath
        )
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewDelegate?.scrollViewDidScroll(scrollView)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        viewDelegate?.scrollViewDidEndScrollingAnimation(scrollView)
    }
}

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

// MARK: - Register

extension UICollectionView {
    func register(cell: UICollectionViewCell.Type) {
        register(cell.self, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }

    func register(cells: [UICollectionViewCell.Type]) {
        cells.forEach { register(cell: $0) }
    }

    func register(_ cells: UICollectionViewCell.Type...) {
        cells.forEach { register(cell: $0) }
    }

    func register<T: UICollectionReusableView>(header: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: SupplementaryViewKind.header.rawValue,
            withReuseIdentifier: T.reuseIdentifier
        )
    }

    func register<T: UICollectionReusableView>(footer: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: SupplementaryViewKind.footer.rawValue,
            withReuseIdentifier: T.reuseIdentifier
        )
    }

    func register<T: UICollectionReusableView>(_ view: T.Type, kind: String) {
        register(
            T.self,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: T.reuseIdentifier
        )
    }

    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }

    func dequeue<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T
    }

    func dequeue<T: UICollectionReusableView>(_ kind: SupplementaryViewKind, for indexPath: IndexPath) -> T? {
        dequeueReusableSupplementaryView(
            ofKind: kind.rawValue,
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T
    }

    func dequeue<T: UICollectionReusableView>(_ kind: String, for indexPath: IndexPath) -> T? {
        dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T
    }
}

// MARK: - SupplementaryViewKind

extension UICollectionView {
    enum SupplementaryViewKind: String {
        case header = "UICollectionElementKindSectionHeader"
        case footer = "UICollectionElementKindSectionFooter"
    }
}

extension UICollectionView {
    func scrollToTop(animated: Bool = true) {
        scrollToItem(
            at: IndexPath(item: .zero, section: .zero),
            at: .top,
            animated: animated
        )
    }
}

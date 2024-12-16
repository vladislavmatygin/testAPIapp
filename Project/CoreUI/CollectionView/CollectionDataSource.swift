import Foundation
import UIKit

protocol Delegatable: AnyObject {
    associatedtype Delegate
    var delegate: Delegate? { get set }
}

extension Delegatable {
    func setAnyDelegate(_ object: AnyObject?) {
        guard let delegate = object as? Delegate else { return }
        self.delegate = delegate
    }
}

struct CollectionIdentifier: Hashable {
    let id: Int

    init(_ id: Int = UUID().hashValue) {
        self.id = id
    }
}

protocol CollectionItemable {
    var identifier: CollectionIdentifier { get }
    var reuseIdentifier: String { get }
}

extension CollectionItemable {
    var reuseIdentifier: String {
        let components = String(reflecting: type(of: self)).components(separatedBy: ".")

        return components[1]
    }
}

protocol CollectionSectionable: CollectionItemable {
    func reuseIdentifier(kind: String) -> String
}

extension CollectionSectionable {
    func reuseIdentifier(kind: String) -> String {
        reuseIdentifier
    }
}

protocol CollectionConfigurable {
    associatedtype Item: CollectionItemable

    func configure(_ item: Item)
}

extension CollectionConfigurable {
    func configure(any item: any CollectionItemable) {
        if let item = item as? Item {
            configure(item)
        }
    }
}

typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionIdentifier, CollectionIdentifier>

// MARK: - CollectionDataSource
/*
 Возможно в будущем хотелось бы видеть API
 let source = CollectionDataSource()
 source.append()
 source.append()

 Чтобы сделать единый источник а не 2: CollectionDataSource + SnapshotMaker
 */
final class CollectionDataSource: UICollectionViewDiffableDataSource<CollectionIdentifier, CollectionIdentifier> {
    private(set) var sections: [CollectionItemable] = []
    private(set) var items: [CollectionItemable] = []

    func getSection(_ identifier: CollectionIdentifier) -> CollectionItemable? {
        sections.first(where: { $0.identifier == identifier })
    }

    func getItem(_ identifier: CollectionIdentifier?) -> CollectionItemable? {
        items.first(where: { $0.identifier == identifier })
    }

    func itemIdentifiers(inSection section: CollectionItemable) -> [CollectionItemable] {
        let identifiers = snapshot().itemIdentifiers(inSection: section.identifier)
        let result = items.filter { item in
            identifiers.contains { $0 == item.identifier }
        }

        return result
    }

    func sectionIdentifier(containingItem item: CollectionItemable) -> CollectionItemable? {
        guard let identifier = snapshot().sectionIdentifier(containingItem: item.identifier) else { return nil }
        return sections.first(where: { $0.identifier == identifier })
    }

    func make(isRedraw: Bool = false, _ make: (SnapshotMaker) -> Void) -> Snapshot {
        let maker = SnapshotMaker(
            snapshot: isRedraw ? Snapshot() : snapshot(),
            sections: isRedraw ? [] : sections,
            items: isRedraw ? [] : items
        )

        make(maker)

        sections = maker.sections
        items = maker.items

        return maker.snapshot
    }

    func safeApply(
        _ snapshot: Snapshot,
        animatingDifferences: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        do {
            try tryExp {
                apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
            }
        } catch {
            logger.error("SU_Error_CollectionView_Apply_Snapshot -> \(error)")
        }
    }
}

// MARK: - Items
extension CollectionDataSource {
    func appendItems(_ items: [CollectionItemable], toSection section: CollectionItemable? = nil) -> Snapshot {
        self.items += items
        var snapshot = snapshot()
        snapshot.safeAppendItems(
            identifiers: items.map(\.identifier), section: section?.identifier
        )

        return snapshot
    }

    func insertItems(_ items: [CollectionItemable], before item: CollectionItemable) -> Snapshot {
        var snapshot = snapshot()
        guard let index = self.items.firstIndex(where: { $0.identifier == item.identifier }) else {
            return snapshot
        }
        guard let item = snapshot.itemIdentifiers.first(where: { $0 == item.identifier }) else {
            return snapshot
        }
        self.items.insert(contentsOf: items, at: index)
        snapshot.safeInsertItems(items.map(\.identifier), beforeItem: item)

        return snapshot
    }

    func insertItems(_ items: [CollectionItemable], after item: CollectionItemable) -> Snapshot {
        var snapshot = snapshot()
        guard let index = self.items.firstIndex(where: { $0.identifier == item.identifier }) else {
            return snapshot
        }
        guard let item = snapshot.itemIdentifiers.first(where: { $0 == item.identifier }) else {
            return snapshot
        }
        self.items.insert(contentsOf: items, at: index)
        snapshot.safeInsertItems(items.map(\.identifier), afterItem: item)

        return snapshot
    }

    func deleteItems(_ items: [CollectionItemable]) -> Snapshot {
        self.items.removeAll { item in items.contains(where: { $0.identifier == item.identifier }) }
        var snapshot = snapshot()
        snapshot.deleteItems(items.map(\.identifier))
        return snapshot
    }

    func reconfigureItems(_ items: [CollectionItemable]) -> Snapshot {
        self.items.removeAll { item in items.contains(where: { $0.identifier == item.identifier }) }
        self.items += items

        var snapshot = snapshot()
        snapshot.safeReconfigureItems(items.map(\.identifier))
        return snapshot
    }
}

// MARK: - Sections
extension CollectionDataSource {
    func appendSections(_ sections: [CollectionItemable]) -> Snapshot {
        self.sections += sections
        var snapshot = snapshot()
        snapshot.safeAppendSections(sections.map(\.identifier))
        return snapshot
    }

    func deleteSections(_ sections: [CollectionItemable]) -> Snapshot {
        self.sections += sections
        var snapshot = snapshot()

        let sections = sections.map(\.identifier)

        let items = sections.flatMap(snapshot.itemIdentifiers(inSection:))
        self.items.removeAll { items.contains($0.identifier) }

        snapshot.deleteSections(sections)

        return snapshot
    }

    func reloadSections(_ sections: [CollectionItemable]) -> Snapshot {
        var snapshot = snapshot()
        snapshot.reloadSections(sections.map(\.identifier))
        return snapshot
    }
}

// MARK: - CollectionDataSource+Utils
extension CollectionDataSource {
    func appendItems(_ items: CollectionItemable?...) -> Snapshot {
        appendItems(items.compactMap { $0 })
    }

    func insertItems(_ items: CollectionItemable?..., before item: CollectionItemable?) -> Snapshot {
        guard let item else { return snapshot() }
        return insertItems(items.compactMap { $0 }, before: item)
    }

    func insertItems(_ items: CollectionItemable?..., after item: CollectionItemable?) -> Snapshot {
        guard let item else { return snapshot() }
        return insertItems(items.compactMap { $0 }, after: item)
    }

    func deleteItems(_ items: CollectionItemable?...) -> Snapshot {
        deleteItems(items.compactMap { $0 })
    }

    func reconfigureItems(_ items: CollectionItemable?...) -> Snapshot {
        reconfigureItems(items.compactMap { $0 })
    }

    func appendSections(_ items: CollectionItemable?...) -> Snapshot {
        appendSections(items.compactMap { $0 })
    }

    func deleteSections(_ items: CollectionItemable?...) -> Snapshot {
        deleteSections(items.compactMap { $0 })
    }

    func reloadSections(_ items: CollectionItemable?...) -> Snapshot {
        reloadSections(items.compactMap { $0 })
    }
}

// MARK: - SnapshotMaker
final class SnapshotMaker {
    private(set) var snapshot: Snapshot
    private(set) var sections: [CollectionItemable]
    private(set) var items: [CollectionItemable]

    init(
        snapshot: Snapshot,
        sections: [CollectionItemable],
        items: [CollectionItemable]
    ) {
        self.snapshot = snapshot
        self.sections = sections
        self.items = items
    }

    func getSection(_ identifier: CollectionIdentifier) -> CollectionItemable? {
        sections.first(where: { $0.identifier == identifier })
    }

    func getItem(_ id: CollectionIdentifier) -> CollectionItemable? {
        items.first(where: { $0.identifier == id })
    }
}

// MARK: - Items
extension SnapshotMaker {
    @discardableResult
    func appendItems(_ items: [CollectionItemable], toSection section: CollectionItemable? = nil) -> Self {
        self.items += items

        snapshot.safeAppendItems(
            identifiers: items.map(\.identifier), section: section?.identifier
        )

        return self
    }

    @discardableResult
    func insertItems(_ items: [CollectionItemable], after item: CollectionItemable) -> Self {
        guard let index = self.items.firstIndex(where: { $0.identifier == item.identifier }) else {
            return self
        }
        guard let item = snapshot.itemIdentifiers.first(where: { $0 == item.identifier }) else {
            return self
        }
        self.items.insert(contentsOf: items, at: index)
        snapshot.safeInsertItems(items.map(\.identifier), afterItem: item)
        return self
    }

    @discardableResult
    func insertItems(_ items: [CollectionItemable], before item: CollectionItemable) -> Self {
        guard let index = self.items.firstIndex(where: { $0.identifier == item.identifier }) else {
            return self
        }
        guard let item = snapshot.itemIdentifiers.first(where: { $0 == item.identifier }) else {
            return self
        }
        self.items.insert(contentsOf: items, at: index)
        snapshot.safeInsertItems(items.map(\.identifier), beforeItem: item)
        return self
    }

    @discardableResult
    func deleteItems(_ items: [CollectionItemable]) -> Self {
        self.items.removeAll { item in items.contains(where: { $0.identifier == item.identifier }) }
        snapshot.deleteItems(items.map(\.identifier))
        return self
    }

    @discardableResult
    func reconfigureItems(_ items: [CollectionItemable]) -> Self {
        self.items.removeAll { item in items.contains(where: { $0.identifier == item.identifier }) }
        self.items += items
        snapshot.safeReconfigureItems(items.map(\.identifier))
        return self
    }
}

// MARK: - Sections
extension SnapshotMaker {
    @discardableResult
    func appendSections(_ sections: [CollectionItemable]) -> Self {
        for section in sections where !self.sections.contains(where: { $0.identifier == section.identifier }) {
            self.sections.append(section)
            snapshot.safeAppendSections([section.identifier])
        }
        return self
    }

    @discardableResult
    func insertSections(_ sections: [CollectionItemable], afterSection section: CollectionItemable) -> Self {
        guard let index = self.sections.firstIndex(where: { $0.identifier == section.identifier }),
              let section = snapshot.sectionIdentifiers.first(where: { $0 == section.identifier }) else {
            return self
        }

        self.sections.insert(contentsOf: sections, at: index)
        snapshot.safeInsertSections(sections.map(\.identifier), afterSection: section)

        return self
    }

    @discardableResult
    func insertSections(_ sections: [CollectionItemable], beforeSection section: CollectionItemable) -> Self {
        guard let index = self.sections.firstIndex(where: { $0.identifier == section.identifier }),
              let section = snapshot.sectionIdentifiers.first(where: { $0 == section.identifier }) else {
            return self
        }

        self.sections.insert(contentsOf: sections, at: index)
        snapshot.safeInsertSections(sections.map(\.identifier), beforeSection: section)

        return self
    }

    // Возможно это надо называть deleteItemsInSections
    @discardableResult
    func clearSections(_ sections: [CollectionItemable]) -> Self {
        let sections = sections.map(\.identifier)

        let items = sections.flatMap(snapshot.itemIdentifiers(inSection:))
        snapshot.deleteItems(items)
        self.items.removeAll { items.contains($0.identifier) }

        return self
    }
}

// MARK: - SnapshotMaker+Utils
extension SnapshotMaker {
    // Items

    @discardableResult
    func appendItems(_ items: CollectionItemable?...) -> Self {
        appendItems(items.compactMap { $0 })
    }

    @discardableResult
    func appendItems(_ items: CollectionItemable?..., toSection section: CollectionItemable? = nil) -> Self {
        appendItems(items.compactMap { $0 }, toSection: section)
    }

    @discardableResult
    func insertItems(_ items: CollectionItemable?..., after item: CollectionItemable) -> Self {
        insertItems(items.compactMap { $0 }, after: item)
    }

    @discardableResult
    func insertItems(_ items: CollectionItemable?..., before item: CollectionItemable) -> Self {
        insertItems(items.compactMap { $0 }, before: item)
    }

    @discardableResult
    func deleteItems(_ items: CollectionItemable?...) -> Self {
        deleteItems(items.compactMap { $0 })
    }

    @discardableResult
    func reconfigureItems(_ items: CollectionItemable?...) -> Self {
        reconfigureItems(items.compactMap { $0 })
    }

    // Sections

    @discardableResult
    func insertSections(_ sections: CollectionItemable?..., afterSection section: CollectionItemable) -> Self {
        insertSections(sections.compactMap { $0 }, afterSection: section)
    }

    @discardableResult
    func insertSections(_ sections: CollectionItemable?..., beforeSection section: CollectionItemable) -> Self {
        insertSections(sections.compactMap { $0 }, beforeSection: section)
    }

    @discardableResult
    func appendSections(_ sections: CollectionItemable?...) -> Self {
        appendSections(sections.compactMap { $0 })
    }

    @discardableResult
    func clearSections(_ sections: CollectionItemable?...) -> Self {
        clearSections(sections.compactMap { $0 })
    }
}

class DataSource {
    weak var collectionDataSource: CollectionDataSource!

    func appendItems(_ items: CollectionItemable) -> Snapshot {
        collectionDataSource.appendItems(items)
    }

    func deleteItems(_ items: CollectionItemable) -> Snapshot {
        collectionDataSource.deleteItems(items)
    }

    func reconfigureItems(_ items: CollectionItemable...) -> Snapshot {
        collectionDataSource.reconfigureItems(items)
    }

    func reconfigureItems(_ items: [CollectionItemable]) -> Snapshot {
        collectionDataSource.reconfigureItems(items)
    }
}

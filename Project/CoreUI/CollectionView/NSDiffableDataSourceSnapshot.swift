import OrderedCollections
import UIKit

// MARK: - Items
extension NSDiffableDataSourceSnapshot {
    mutating func appendItem(_ identifier: ItemIdentifierType, toSection sectionIdentifier: SectionIdentifierType? = nil) {
        safeAppendItems(identifiers: [identifier], section: sectionIdentifier)
    }

    mutating func appendItems(_ identifiers: ItemIdentifierType..., toSection sectionIdentifier: SectionIdentifierType? = nil) {
        safeAppendItems(identifiers: identifiers, section: sectionIdentifier)
    }

    mutating func insertItems(_ identifiers: ItemIdentifierType..., afterItem afterIdentifier: ItemIdentifierType) {
        insertItems(identifiers, afterItem: afterIdentifier)
    }

    mutating func insertItem(_ identifier: ItemIdentifierType, afterItem afterIdentifier: ItemIdentifierType) {
        insertItems([identifier], afterItem: afterIdentifier)
    }

    mutating func deleteItem(_ identifier: ItemIdentifierType) {
        deleteItems([identifier])
    }

    mutating func reconfigureItem(_ identifier: ItemIdentifierType) {
        reconfigureItems([identifier])
    }
}

// MARK: - Sections
extension NSDiffableDataSourceSnapshot {
    // MARK: - appendSections

    mutating func appendSection(_ identifier: SectionIdentifierType) {
        appendSections([identifier])
    }

    mutating func appendSections(_ identifiers: SectionIdentifierType...) {
        appendSections(identifiers)
    }
}

// MARK: - Safely
extension NSDiffableDataSourceSnapshot {
    mutating func safeInsertItems(_ identifiers: [ItemIdentifierType], beforeItem beforeIdentifier: ItemIdentifierType) {
        do {
            try tryExp {
                insertItems(identifiers, beforeItem: beforeIdentifier)
            }
        } catch {
            logger.error("[Error_CollectionView_Duplicate_InsertItems_BeforeItem] -> \(error)")
        }
    }

    mutating func safeInsertItems(_ identifiers: [ItemIdentifierType], afterItem afterIdentifier: ItemIdentifierType) {
        do {
            try tryExp {
                insertItems(identifiers, afterItem: afterIdentifier)
            }
        } catch {
            logger.error("[Error_CollectionView_Duplicate_InsertItems_AfterItem] -> \(error)")
        }
    }

    mutating func safeAppendItems(identifiers: [ItemIdentifierType], section: SectionIdentifierType? = nil) {
        do {
            try tryExp {
                appendItems(identifiers, toSection: section)
            }
        } catch {
            logger.error("[Error_CollectionView_Duplicate_AppendItems] -> \(error)")

            OrderedSet(identifiers).forEach {
                appendItems([$0], toSection: section)
            }
        }
    }

    mutating func safeReconfigureItems(_ identifiers: [ItemIdentifierType]) {
        do {
            try tryExp {
                reconfigureItems(identifiers)
            }
        } catch {
            logger.error("[Error_CollectionView_NotExist_ReconfigureItems] -> \(error)")
        }
    }

    mutating func safeAppendSections(_ identifiers: [SectionIdentifierType]) {
        do {
            try tryExp {
                appendSections(identifiers)
            }
        } catch {
            logger.error("[Error_CollectionView_Duplicate_AppendSection] -> \(error)")
        }
    }

    mutating func safeInsertSections(_ identifiers: [SectionIdentifierType], beforeSection toIdentifier: SectionIdentifierType) {
        do {
            try tryExp {
                insertSections(identifiers, beforeSection: toIdentifier)
            }
        } catch {
            logger.error("[Error_CollectionView_Duplicate_InsertItems_BeforeItem] -> \(error)")
        }
    }

    mutating func safeInsertSections(_ identifiers: [SectionIdentifierType], afterSection toIdentifier: SectionIdentifierType) {
        do {
            try tryExp {
                insertSections(identifiers, afterSection: toIdentifier)
            }
        } catch {
            logger.error("[Error_CollectionView_Duplicate_InsertItems_BeforeItem] -> \(error)")
        }
    }
}

func tryExp(_ completion: () -> Void) throws {
    guard let error = tryExpection(completion) else { return }

    throw error
}

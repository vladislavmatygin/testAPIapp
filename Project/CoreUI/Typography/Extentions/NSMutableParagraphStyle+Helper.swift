import UIKit

extension NSMutableParagraphStyle {

    func withProperty<ValueType>(_ value: ValueType, for keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, ValueType>) -> NSMutableParagraphStyle {
        self[keyPath: keyPath] = value

        return self
    }

}

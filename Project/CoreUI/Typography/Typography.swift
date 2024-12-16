import UIKit

public final class Typography {

    // MARK: - Properties

    public var lineHeight: CGFloat? = nil
    public var letterSpacing: CGFloat? = nil
    public var underline: NSUnderlineStyle? = nil
    public var strikethrough: NSUnderlineStyle? = nil

    func set<ValueType: Equatable>(_ value: ValueType, for keyPath: ReferenceWritableKeyPath<Typography, ValueType>, onChange: () -> Void) {
        if self[keyPath: keyPath] != value {
            self[keyPath: keyPath] = value
            onChange()
        }
    }
}

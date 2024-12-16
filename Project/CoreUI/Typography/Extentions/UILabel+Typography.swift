import UIKit

extension UILabel: TypographyExtensions {

    var paragraphStyle: NSParagraphStyle? {
        getAttribute(.paragraphStyle)
    }

    public var lineHeight: CGFloat? {
        get { paragraphStyle?.maximumLineHeight }
        set {
            let lineHeight = newValue ?? font.lineHeight
            let adjustment = lineHeight > font.lineHeight ? 2.0 : 1.0
            let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / adjustment
            addAttribute(.baselineOffset, value: baselineOffset)
            addAttribute(
                .paragraphStyle,
                value: (paragraphStyle ?? NSParagraphStyle())
                    .mutable
                    .withProperty(lineHeight, for: \.minimumLineHeight)
                    .withProperty(lineHeight, for: \.maximumLineHeight)
            )
            setupAttributeCacheIfNeeded()
        }
    }

    func setupAttributeCacheIfNeeded() {
        onTextChange { [unowned self] oldText, newText in
            if oldText.count == .zero,
               newText.count > .zero,
               let newText = newText {
                let alignment = textAlignment
                self.attributedText = NSAttributedString(string: newText, attributes: cachedAttributes)
                self.textAlignment = alignment
            }

            _ = self.attributedText
        }
    }

    public var letterSpacing: CGFloat? {
        get { getAttribute(.kern) }
        set {
            setAttribute(.kern, value: newValue)
            setupAttributeCacheIfNeeded()
        }
    }

    public var underline: NSUnderlineStyle? {
        get { getAttribute(.underlineStyle) }
        set {
            setAttribute(.underlineStyle, value: newValue)
            setupAttributeCacheIfNeeded()
        }
    }

    public var strikethrough: NSUnderlineStyle? {
        get { getAttribute(.strikethroughStyle) }
        set {
            setAttribute(.strikethroughStyle, value: newValue)
            setupAttributeCacheIfNeeded()
        }
    }

}

fileprivate extension UILabel {

    struct Keys {
        static var cache: UInt8 = .zero
    }

    var cache: NSAttributedString {
        get {
            objc_getAssociatedObject(self, &Keys.cache) as? NSAttributedString ?? NSAttributedString(string: "Placeholder")
        }
        set {
            objc_setAssociatedObject(self, &Keys.cache, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var attributes: [NSAttributedString.Key: Any]? {
        get {
            if let attributedText = attributedText,
               attributedText.length > .zero {
                return attributedText.attributes(at: .zero, effectiveRange: nil)
            } else {
                return nil
            }
        }
    }

    var cachedAttributes: [NSAttributedString.Key: Any] {
        cache.attributes(at: .zero, effectiveRange: nil)
    }

    func addAttribute(_ key: NSAttributedString.Key, value: Any) {
        attributedText = attributedText?.stringByAddingAttribute(key, value: value)
        cache = cache.stringByAddingAttribute(key, value: value)
    }

    func removeAttribute(_ key: NSAttributedString.Key) {
        attributedText = attributedText?.stringByRemovingAttribute(key)
        cache = cache.stringByRemovingAttribute(key)
    }
}

fileprivate extension UILabel {

    func getAttribute<AttributeType>(_ key: NSAttributedString.Key) -> AttributeType? where AttributeType: Any {
        return (attributes ?? cachedAttributes)[key] as? AttributeType
    }

    func getAttribute<AttributeType>(_ key: NSAttributedString.Key) -> AttributeType? where AttributeType: OptionSet {
        if let attribute = (attributes ?? cachedAttributes)[key] as? AttributeType.RawValue {
            return .init(rawValue: attribute)
        } else {
            return nil
        }
    }

    func setAttribute<AttributeType>(_ key: NSAttributedString.Key, value: AttributeType?) where AttributeType: Any  {
        if let value = value {
            addAttribute(key, value: value)
        } else {
            removeAttribute(key)
        }
    }

    func setAttribute<AttributeType>(_ key: NSAttributedString.Key, value: AttributeType?) where AttributeType: OptionSet  {
        if let value = value {
            addAttribute(key, value: value.rawValue)
        } else {
            removeAttribute(key)
        }
    }
}

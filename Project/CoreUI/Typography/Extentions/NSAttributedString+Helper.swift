import UIKit

extension NSAttributedString {

    var entireRange: NSRange {
        NSRange(location: .zero, length: length)
    }

    func stringByAddingAttribute(_ key: NSAttributedString.Key, value: Any) -> NSAttributedString {
        let changedString = NSMutableAttributedString(attributedString: self)
        changedString.addAttribute(key, value: value, range: entireRange)

        return changedString
    }

    func stringByRemovingAttribute(_ key: NSAttributedString.Key) -> NSAttributedString {
        let changedString = NSMutableAttributedString(attributedString: self)
        changedString.removeAttribute(key, range: entireRange)

        return changedString
    }
}

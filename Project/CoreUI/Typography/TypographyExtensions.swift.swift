import UIKit

protocol TypographyExtensions: UILabel {

    var lineHeight: CGFloat? { get set }
    var letterSpacing: CGFloat? { get set }
    var underline: NSUnderlineStyle? { get set }
    var strikethrough: NSUnderlineStyle? { get set }

}

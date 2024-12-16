import UIKit

public final class Label {
    public static func configure(
        text: String? = nil,
        font: Font.FontType,
        textAligment: NSTextAlignment = .left,
        numberOfLines: Int = 1
    ) -> UILabel {
        let label = UILabel()
        label.textAlignment = textAligment
        label.numberOfLines = numberOfLines
        label.font = Font.getFont(withType: font)
        label.lineHeight = font.lineHeight
        label.text = text

        return label
    }
}

extension UILabel {
    func apply(
        font: Font.FontType,
        text: String? = nil,
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 1
    ) {
        self.font = Font.getFont(withType: font)
        self.text = text
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}

import UIKit

extension NSParagraphStyle {

    var mutable: NSMutableParagraphStyle {
        let mutable = NSMutableParagraphStyle()
        mutable.setParagraphStyle(self)

        return mutable
    }

}

import UIKit

extension UIControl {
    func addAction(for event: UIControl.Event, handler: @escaping UIActionHandler) {
        addAction(UIAction(handler: handler), for: event)
    }
}

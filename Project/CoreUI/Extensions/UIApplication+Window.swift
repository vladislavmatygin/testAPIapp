import UIKit

extension UIApplication {
    static var window: UIWindow? {
        if let sceneDelegate = shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window
        } else {
            nil
        }
    }
}

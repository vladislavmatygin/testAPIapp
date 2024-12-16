import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .first { $0.activationState == .foregroundActive }
            // Get its associated windows
            .flatMap { $0 as? UIWindowScene }?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}

// MARK: - Insets
extension UIViewController {
    var safeAreaBottomInset: CGFloat {
        UIApplication.window?.safeAreaInsets.bottom ?? 0
    }

    var safeAreaTopInset: CGFloat {
        UIApplication.window?.safeAreaInsets.top ?? 0
    }

    var heightNavBar: CGFloat {
        navigationController?.navigationBar.bounds.height ?? 0
    }
}

extension UIView {
    var safeAreaBottomInset: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }

    var safeAreaTopInset: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
}

// MARK: - Alert
extension UIViewController {
    func showAlert(
        title: String,
        message: String? = nil,
        plain: String,
        destructive: String? = nil,
        cancel: String? = nil,
        action: ((UIAlertAction.Style) -> Void)? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        if let destructive {
            let destructiveAction = UIAlertAction(title: destructive, style: .destructive, handler: { _ in
                if let action {
                    action(.destructive)
                } else {
                    alertController.dismiss(animated: true)
                }
            })
            alertController.addAction(destructiveAction)
        }

        if let cancel {
            let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: { _ in
                if let action {
                    action(.cancel)
                } else {
                    alertController.dismiss(animated: true)
                }
            })
            alertController.addAction(cancelAction)
        }

        let defaultAction = UIAlertAction(title: plain, style: .default, handler: { _ in
            if let action {
                action(.default)
            } else {
                alertController.dismiss(animated: true)
            }
        })
        alertController.addAction(defaultAction)

        present(alertController, animated: true)
    }
}

// MARK: - NavigationBar
extension UIViewController {
    func configureNavigationBar(
        backgroundColor: UIColor? = nil,
        shadowColor: UIColor? = nil
    ) {
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithTransparentBackground()
        navigationAppearance.backgroundColor = backgroundColor ?? theme.backgroundBasic
        navigationAppearance.shadowColor = shadowColor

        navigationItem.standardAppearance = navigationAppearance
        navigationItem.scrollEdgeAppearance = navigationAppearance
    }
}

// MARK: - SU Appearance
extension UIViewController {
    static func su_topmostPresentedViewController() -> UIViewController? {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        let rootViewController = sceneDelegate?.window?.rootViewController

        return rootViewController?.su_presentedViewController() ?? rootViewController
    }

    func su_presentedViewController() -> UIViewController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            viewController = viewController?.presentedViewController
        }
        return viewController
    }
}

// MARK: - SUKeyboardListenerable
@objc protocol SUKeyboardListenerable where Self: UIViewController {
    func didHideKeyboard()

    func keyboardWillAppear(_ notification: Notification)
    func keyboardWillDisappear(_ notification: Notification)
}

extension SUKeyboardListenerable {
    func setKeyboardListeners() {
        let center = NotificationCenter.default

        center.addObserver(
            self,
            selector: #selector(keyboardWillAppear(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        center.addObserver(
            self,
            selector: #selector(keyboardWillDisappear(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}

// MARK: - Keyboard
extension UIViewController: UIGestureRecognizerDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self

        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(_ gesture: UITapGestureRecognizer) {
        (self as? SUKeyboardListenerable)?.didHideKeyboard()
        view.endEditing(true)
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        touch.view?.tag != 1000
    }
}

extension UIViewController {
    func addChildController(_ childViewController: UIViewController, inside containerView: UIView?) {
        childViewController.willMove(toParent: self)
        containerView?.addSubview(childViewController.view)

        addChild(childViewController)

        childViewController.didMove(toParent: self)
    }
}

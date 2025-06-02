import UIKit

extension UIApplication {
    static func topViewController(base: UIViewController? = UIApplication.shared.connectedScenes
        .compactMap { ($0 as? UIWindowScene)?.keyWindow }
        .first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

class AlertWrapper {
    struct Action {
        let title: String
        let style: UIAlertAction.Style
        let handler: (() -> Void)?
        init(title: String, style: UIAlertAction.Style = .default, handler: (() -> Void)? = nil) {
            self.title = title
            self.style = style
            self.handler = handler
        }
    }
    
    static func showAlert(on viewController: UIViewController, title: String, message: String, buttonTitle: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithActions(on viewController: UIViewController, title: String, message: String, actions: [Action]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(UIAlertAction(title: action.title, style: action.style) { _ in
                action.handler?()
            })
        }
        viewController.present(alert, animated: true, completion: nil)
    }

    static func showAlertOnTop(title: String, message: String, buttonTitle: String, completion: (() -> Void)? = nil) {
        if let topVC = UIApplication.topViewController() {
            showAlert(on: topVC, title: title, message: message, buttonTitle: buttonTitle, completion: completion)
        }
    }

    static func showAlertWithActionsOnTop(title: String, message: String, actions: [Action]) {
        if let topVC = UIApplication.topViewController() {
            showAlertWithActions(on: topVC, title: title, message: message, actions: actions)
        }
    }
} 
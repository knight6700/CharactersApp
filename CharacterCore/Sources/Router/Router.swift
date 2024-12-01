import UIKit

public protocol Routable {
    associatedtype Route
    func navigate(to route: Route)
}

public protocol RouteRepresentable {
    var path: String { get }
}

public enum RouterType {
    case push
    case modal
    case fullScreen
    case replace
}

public protocol RouterConfigurable {
    associatedtype Route: RouteRepresentable
    
    var navigationController: UINavigationController? { get set }
    var rootViewController: UIViewController? { get set }
    
    func navigate(to route: Route, type: RouterType)
    func dismiss(animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
}

open class Router<R: RouteRepresentable>: RouterConfigurable {
    public var navigationController: UINavigationController?
    public var rootViewController: UIViewController?
    
    public init(navigationController: UINavigationController? = nil,
                rootViewController: UIViewController? = nil) {
        self.navigationController = navigationController
        self.rootViewController = rootViewController
    }
    
    open func navigate(to route: R, type: RouterType = .push) {
        switch type {
        case .push:
            performPushNavigation(for: route)
        case .modal:
            performModalNavigation(for: route)
        case .fullScreen:
            performFullScreenNavigation(for: route)
        case .replace:
            performReplaceNavigation(for: route)
        }
    }
    
    private func performPushNavigation(for route: R) {
        guard let navigationController = navigationController else {
            assertionFailure("No navigation controller available")
            return
        }
        
        let viewController = createViewController(for: route)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func performModalNavigation(for route: R) {
        guard let presentingViewController = rootViewController ?? navigationController?.topViewController else {
            assertionFailure("No view controller to present from")
            return
        }
        
        let viewController = createViewController(for: route)
        viewController.modalPresentationStyle = .automatic
        presentingViewController.present(viewController, animated: true)
    }
    
    private func performFullScreenNavigation(for route: R) {
        guard let presentingViewController = rootViewController ?? navigationController?.topViewController else {
            assertionFailure("No view controller to present from")
            return
        }
        
        let viewController = createViewController(for: route)
        viewController.modalPresentationStyle = .fullScreen
        presentingViewController.present(viewController, animated: true)
    }
    
    private func performReplaceNavigation(for route: R) {
        guard let navigationController = navigationController else {
            assertionFailure("No navigation controller available")
            return
        }
        
        let viewController = createViewController(for: route)
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    open func createViewController(for route: R) -> UIViewController {
        // Override this method in subclasses to create view controllers based on routes
        fatalError("Must override createViewController(for:)")
    }
    
    open func dismiss(animated: Bool = true) {
        rootViewController?.dismiss(animated: animated)
    }
    
    open func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    open func popToRoot(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
}

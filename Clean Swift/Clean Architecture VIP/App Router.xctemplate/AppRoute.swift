//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

//================================================================================================
// Common App Router Service
//================================================================================================

enum PresentType {
    case root
    case push
    case present
    case presentWithNavigation
    case modal
    case modalWithNavigation
}

protocol Router {
    var module: UIViewController? { get }
}

public extension UIWindow {
    /// Change the root view controller of the window
    ///
    /// - Parameters:
    ///   - controller: controller to set
    func setRootViewController(_ controller: UIViewController) {
        // Make animation
        self.rootViewController = controller
        self.makeKeyAndVisible()
    }
}

extension UIViewController {
    static func initialModule<T: Router>(module: T) -> UIViewController {
        guard let _module = module.module else { fatalError() }
        return _module
    }
    
    func navigate(type: PresentType = .push, module: Router, completion: ((_ module: UIViewController) -> Void)? = nil) {
        guard let _module = module.module else { fatalError() }
        switch type {
        case .root:
            if _module is UITabBarController {
                UIApplication.shared.delegate?.window??.setRootViewController(_module)
            } else {
                UIApplication.shared.delegate?.window??.setRootViewController(
                    UINavigationController(rootViewController: _module)
                )
            }
            completion?(_module)
        case .push:
            if let navigation = self.navigationController {
                navigation.pushViewController(_module, animated: true)
                completion?(_module)
            }
        case .present:
            self.present(_module, animated: true, completion: {
                completion?(_module)
            })
        case .presentWithNavigation:
            let nav = UINavigationController(rootViewController: _module)
            self.present(nav, animated: true, completion: {
                completion?(_module)
            })
        case .modal:
            _module.modalTransitionStyle = .crossDissolve
            _module.modalPresentationStyle = .overFullScreen
            
            self.present(_module, animated: true, completion: {
                completion?(_module)
            })
        case .modalWithNavigation:
            let nav = UINavigationController(rootViewController: _module)
            nav.modalPresentationStyle = .overFullScreen
            nav.modalTransitionStyle = .crossDissolve
            self.present(nav, animated: true, completion: {
                completion?(_module)
            })
        }
    }
    
    func dismiss(to: Router? = nil, _ completion: (() -> Void)? = nil) {
        if self.navigationController != nil {
            self.navigationController?.dismiss(animated: true, completion: {
                completion?()
                return
            })
            
            if let module = to?.module, let viewControllers = self.navigationController?.viewControllers {
                if let _vc = viewControllers.filter({ type(of: $0) == type(of: module) }).first {
                    self.navigationController?.popToViewController(_vc, animated: true)
                }
            } else {
                self.navigationController?.popViewController(animated: true)
            }
            completion?()
        } else {
            self.dismiss(animated: true, completion: {
                completion?()
            })
        }                
    }
    
    func backToRoot(_ completion: (() -> Void)? = nil) {
        self.navigationController?.popToRootViewController(animated: true)
        completion?()
    }
}

extension UIViewController {
    private struct UniqueIdProperies {
        static var previousViewController: UIViewController?
    }
    
    var previousViewController: UIViewController? {
        get {
            return objc_getAssociatedObject(self, &UniqueIdProperies.previousViewController) as? UIViewController
        } set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &UniqueIdProperies.previousViewController, unwrappedValue as UIViewController?, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
    
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
}

//================================================================================================
// Common Extension
//================================================================================================

extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            let top = self.topViewController(nav.visibleViewController)
            return top
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                let top = self.topViewController(selected)
                return top
            }
        }
        
        if let presented = base?.presentedViewController {
            let top = self.topViewController(presented)
            return top
        }
        return base
    }
}

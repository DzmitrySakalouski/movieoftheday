//
//  Navigator.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation
import UIKit

class Navigator: NavigatorType {
    
    private weak var rootNavigationController: UINavigationController?
    private var complitionHandlers: [UIViewController: () -> Void]
    
    func setNavBarHidden(navBarHidden: Bool) {
        rootNavigationController?.isNavigationBarHidden = navBarHidden
    }
    
    func popModule() {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool) {
        if let viewController = rootNavigationController?.popViewController(animated: animated) {
            runComplition(for: viewController)
        }
    }
    
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
        complitionHandlers = [:]
    }

    func present(module: PresentableType?) {
        present(module: module, animated: true)
    }
    
    func present(module: PresentableType?, animated: Bool) {
        guard let viewController = module?.toPresent() else { return }
        rootNavigationController?.present(viewController, animated: animated, completion: nil)
    }
    
    func navigate(module: PresentableType?) {
        navigate(module: module, animated: true)
    }
    
    func navigate(module: PresentableType?, isNavBarHidden: Bool) {
        rootNavigationController?.isNavigationBarHidden = isNavBarHidden
        navigate(module: module, animated: true)
    }
    
    func navigate(module: PresentableType?, animated: Bool) {
        navigate(module: module, animated: animated, completion: nil)
    }
    
    func navigate(module: PresentableType?, animated: Bool, completion: (() -> Void)?) {
        guard let viewController = module?.toPresent(), (viewController is UINavigationController == false) else {
            return
        }
        
        if let completeionHandler = completion {
            complitionHandlers[viewController] = completeionHandler
        }
        
        rootNavigationController?.pushViewController(viewController, animated: animated)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootNavigationController?.dismiss(animated: animated, completion: completion)
    }
    
    func setRootModule(module: PresentableType?, hideNavBar: Bool) {
        guard let viewController = module?.toPresent() else {
            return
        }
        
        rootNavigationController?.setViewControllers([viewController], animated: true)
        rootNavigationController?.isNavigationBarHidden = hideNavBar
    }
    
    func popToRootModule(animated: Bool) {
        if let viewControllers = rootNavigationController?.popToRootViewController(animated: animated) {
            viewControllers.forEach { controller in
                runComplition(for: controller)
            }
        }
    }
    
    func toPresent() -> UIViewController? {
        return rootNavigationController
    }
    
    func runComplition(for controller: UIViewController) {
        guard let completionHandler = complitionHandlers[controller] else { return }
        completionHandler()
        complitionHandlers.removeValue(forKey: controller)
    }
}

//
//  OnboardingCoordinator.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 16.05.21.
//

import Foundation
import Swinject

class OnboardingCoordinator: CoordinatorType {
    private let navigator: NavigatorType
    private let factory: ViewControllerFactoryType
    
    var finishFlow: (() -> ())?
    
    private var container: Container {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container
    }
             
    init(factory: ViewControllerFactoryType, navigator: NavigatorType) {
        self.navigator = navigator
        self.factory = factory
    }
    
    func start() {
        showOnboardingViewController()
    }
    
    func showOnboardingViewController() -> () {
        let onboardingVC = factory.makeOnboardingViewController()
        onboardingVC.didPressSubscribeButton = { [unowned self] in
            self.finishFlow?()
        }
        navigator.setRootModule(module: onboardingVC, hideNavBar: true)
    }
}

//
//  AuthCoordinator.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.05.21.
//

import Foundation
import UIKit
import Swinject

class AuthCoordinator: CoordinatorType {
    private let navigator: NavigatorType
    private let factory: ViewControllerFactoryType
    
    private var container: Container {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container
    }
    
    var finishFlow: (() -> ())?
    
    init(factory: ViewControllerFactoryType, navigator: NavigatorType) {
        self.navigator = navigator
        self.factory = factory
    }

    func start() {
        showSignInViewController()
    }
    
    func showSignInViewController() {
        let signInVC = factory.makeSignInViewController()
        var signInVM = container.resolve(SignInViewModelType.self)
        signInVM?.didPressSignIn = { [unowned self] in
            self.finishFlow?()
        }
        signInVM?.didPressSignUp = { [unowned self] in
            self.showSignUpViewController()
        }
        signInVC.viewModel = signInVM
        navigator.setRootModule(module: signInVC, hideNavBar: false)
    }
    
    func showSignUpViewController() {
        let signUpVC = factory.makeSignUpViewController()
        var signUpVM = container.resolve(SignUpViewModelType.self)
        signUpVM?.didPressSignInLabel = { [unowned self] in
            self.navigator.popModule()
        }
        signUpVM?.didFinishSignUp = { [unowned self] in
            self.finishFlow?()
        }
        signUpVC.viewModel = signUpVM
        navigator.navigate(module: signUpVC)
    }
}

//
//  ViewControllerfactory.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation

import UIKit

class ViewControllerFactory: ViewControllerFactoryType {
    func makeSignUpViewController() -> SignUpViewController {
        let signUpVC = UIStoryboard(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        return signUpVC
    }
    
    func makeSignInViewController() -> SignInViewController {
        let signInViewController = UIStoryboard(name: "Auth", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                
        return signInViewController
    }
    
    func makeMainMovieViewController() -> MainMovieViewController {
        let mainMovieVC = MainMovieViewController()
        return mainMovieVC
    }
    
    func makeMovieDetailsViewController() -> DetailsViewController {
        let detailsVC = DetailsViewController()
        return detailsVC
    }
    
    func makeInitialMovieViewController() -> InitialPagerViewController {
        let initialMovieVC = InitialPagerViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return initialMovieVC
    }
    
}

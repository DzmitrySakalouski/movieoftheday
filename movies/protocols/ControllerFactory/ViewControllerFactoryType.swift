//
//  ViewControllerFactoryType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation

protocol ViewControllerFactoryType {
    func makeMainMovieViewController() -> MainMovieViewController
    func makeMovieDetailsViewController() -> DetailsViewController
    func makeInitialMovieViewController() -> InitialPagerViewController
    func makeSignInViewController() -> SignInViewController
    func makeSignUpViewController() -> SignUpViewController
}

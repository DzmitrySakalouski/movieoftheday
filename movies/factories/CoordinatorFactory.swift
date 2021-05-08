//
//  CoordinatorFactory.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation

class CoordinatorFactory: CoordinatorFactoryType {
    func makeMainMovieCoordinator(navigator: NavigatorType) -> MainMovieCoordinator {
        let vcFactory = ViewControllerFactory()
        return MainMovieCoordinator(factory: vcFactory, navigator: navigator)
    }
    
    func makeAuthCoordinator(navigator: NavigatorType) -> AuthCoordinator {
        let vcFactory = ViewControllerFactory()
        return AuthCoordinator(factory: vcFactory, navigator: navigator)
    }
}

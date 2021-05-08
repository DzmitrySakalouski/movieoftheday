//
//  MainMovieCoordinator.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation
import Swinject

class MainMovieCoordinator: CoordinatorType {
    private let navigator: NavigatorType
    private let factory: ViewControllerFactoryType
    
    private var container: Container {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container
    }
             
    init(factory: ViewControllerFactoryType, navigator: NavigatorType) {
        self.navigator = navigator
        self.factory = factory
    }
    
    func showInitialMovieViewController() {
        let initialVC = factory.makeInitialMovieViewController()
        let initialMovieVM = container.resolve(InitialMovieViewModelType.self)
        initialVC.viewModel = initialMovieVM
        
        let detailsVC = factory.makeMovieDetailsViewController()
        let detailsVM = container.resolve(DetailsViewModelType.self)
        detailsVC.viewModel = detailsVM
        
        let mainMovieVC = factory.makeMainMovieViewController()
        let mainMovieVM = container.resolve(MainMovieViewModelType.self)
        mainMovieVC.viewModel = mainMovieVM
        initialVC.pages = [mainMovieVC, detailsVC]
        navigator.setRootModule(module: initialVC, hideNavBar: true)
    }
    
    func start() {
        showInitialMovieViewController()
    }
}

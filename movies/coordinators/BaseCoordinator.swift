//
//  BaseCoordinator.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 1.04.21.
//

import Foundation

class BaseCoordinator: CoordinatorType {
    var childCoordinators: [CoordinatorType] = []
    
    func start() {}
    
    func addDependency(coordinator: CoordinatorType) {
        guard !childCoordinators.contains(where: { element in
            return element === coordinator
        }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(coordinator: CoordinatorType?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
        
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators.filter({$0 !== coordinator}).forEach({coordinator.removeDependency(coordinator: $0)})
        }
        
        for (index, childCoordinator) in childCoordinators.enumerated() where childCoordinator === coordinator {
            childCoordinators.remove(at: index)
        }
    }
}

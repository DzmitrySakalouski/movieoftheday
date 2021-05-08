
import Foundation

class ApplicationCoordinator: BaseCoordinator {
    private let coordinatorFacrory: CoordinatorFactoryType
    private let navigator: NavigatorType
    
    init(coordinatorFacrory: CoordinatorFactoryType, navigator: NavigatorType) {
        self.coordinatorFacrory = coordinatorFacrory
        self.navigator = navigator
    }
    
    override func start() {
        runAuthFlow()
    }
    
    func runMainMovieFlow () {
        let coordinator = coordinatorFacrory.makeMainMovieCoordinator(navigator: navigator)
        addDependency(coordinator: coordinator)
        coordinator.start()
    }
    
    func runAuthFlow () {
        let coordinator = coordinatorFacrory.makeAuthCoordinator(navigator: navigator)
        addDependency(coordinator: coordinator)
        coordinator.start()
    }
}

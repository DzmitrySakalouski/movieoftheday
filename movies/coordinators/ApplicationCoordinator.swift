
import Foundation
import Swinject
import RxSwift
import Firebase

class ApplicationCoordinator: BaseCoordinator {
    private let coordinatorFacrory: CoordinatorFactoryType
    private let navigator: NavigatorType
    
    private let disposeBag = DisposeBag()
    
    init(coordinatorFacrory: CoordinatorFactoryType, navigator: NavigatorType) {
        self.coordinatorFacrory = coordinatorFacrory
        self.navigator = navigator
    }
    
    private var authService: AuthServiceType? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container.resolve(AuthServiceType.self)
    }
    
    override func start() {
        self.runMainMovieFlow()
        // TODO: move to launch service
//        authService?.configureAuthListener().subscribe(onNext: {[unowned self] isAuthenticated in
//            guard let isAuth = isAuthenticated else {
//                return
//            }
//            if isAuth {
//                
//            } else {
//                self.runAuthFlow()
//            }
//        }).disposed(by: disposeBag)
//        switch launcher {
//        case .auth:
//            runAuthFlow()
//        case .home:
//            runMainMovieFlow()
//        case .onbording:
//            runAuthFlow()
//        }
    }
    
    func runMainMovieFlow () {
        let coordinator = coordinatorFacrory.makeMainMovieCoordinator(navigator: navigator)
        addDependency(coordinator: coordinator)
        coordinator.start()
    }
    
    func runAuthFlow () {
        let coordinator = coordinatorFacrory.makeAuthCoordinator(navigator: navigator)
        addDependency(coordinator: coordinator)
        coordinator.finishFlow = { [unowned self] in
            self.removeDependency(coordinator: coordinator)
            self.runMainMovieFlow()
        }
        coordinator.start()
    }
}

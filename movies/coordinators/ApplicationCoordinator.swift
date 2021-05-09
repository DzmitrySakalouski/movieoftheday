
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
        // TODO: move to launch service
        authService?.configureAuthListener().subscribe(onNext: {[unowned self] isAuthenticated in
            print(Auth.auth().currentUser)
            print(Auth.auth().currentUser)
            print(Auth.auth().currentUser)
            print(Auth.auth().currentUser)

            
            guard let isAuth = isAuthenticated else {
                print("NOOOOOOO")
                return
                
            }
            if isAuth {
                self.runMainMovieFlow()
                print(Auth.auth().currentUser)
                print(Auth.auth().currentUser)
                print(Auth.auth().currentUser)
                print(Auth.auth().currentUser)
            } else {
                self.runAuthFlow()
            }
        }).disposed(by: disposeBag)
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

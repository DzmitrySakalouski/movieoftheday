//
//  DIService.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import Foundation
import Swinject

class DIService {
    private static var container = Container()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static func registerDependencies() -> () {
        container.register(NetworkServiceType.self, factory: {_ in return NetworkService()})
        
        container.register(APIClientType.self, factory: {r in
                                return APIClient(networkService: r.resolve(NetworkServiceType.self)!)})
        
        container.register(MovieServiceType.self, factory: {r in return MovieService(apiClient: r.resolve(APIClientType.self)!)}).inObjectScope(.container)
        
        container.register(MainMovieViewModelType.self, factory: {r in return MainMovieViewModel(movieService: r.resolve(MovieServiceType.self)!)})
        
        container.register(InitialMovieViewModelType.self, factory: {r in
            return InitialMovieViewModel(movieService: r.resolve(MovieServiceType.self)!)
        })
        
        container.register(DetailsViewModelType.self, factory: {r in
            return DetailsViewModel(movieService: r.resolve(MovieServiceType.self)!)
        })
        
        container.register(PasswordViewModelType.self, factory: {r in
            return PasswordViewModel()
        })
        
        container.register(EmailViewModelType.self, factory: {r in
            return EmailViewModel()
        })
        
        container.register(SignInViewModelType.self, factory: {r in
            return SignInViewModel(emailViewModel: r.resolve(EmailViewModelType.self)!, passwordViewModel: r.resolve(PasswordViewModelType.self)!, userService: r.resolve(UserServiceType.self)!)
        })
        
        container.register(AuthServiceType.self, factory: {r in
            return AuthService()
        })
        
        container.register(UserServiceType.self, factory: {r in
            return UserService(authService: r.resolve(AuthServiceType.self)!)
        }).inObjectScope(.container)
    }
    
    static func registerContainer(for delegate: AppDelegate) -> () {
        delegate.container = self.container
    }
}

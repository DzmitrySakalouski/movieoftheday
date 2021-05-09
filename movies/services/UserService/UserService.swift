//
//  AuthService.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 9.05.21.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

class UserService: UserServiceType {
    var user: BehaviorRelay<User?> = BehaviorRelay<User?>(value: nil)
    var authService: AuthServiceType!
    var errorMessage: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    var disposeBag = DisposeBag()
    
    init(authService: AuthServiceType) {
        self.authService = authService
    }
    
    func signIn(email: String, password: String) -> Observable<User?> {
        return authService.signInWithEmail(email: email, password: password).asObservable()
    }
    
    func logOut() -> () {
        authService.signOut().subscribe(onNext: {[unowned self] isLoggedOut in
            if isLoggedOut {
                self.user.accept(nil)
            }
        }, onError: {[unowned self] error in
            self.errorMessage.accept(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}

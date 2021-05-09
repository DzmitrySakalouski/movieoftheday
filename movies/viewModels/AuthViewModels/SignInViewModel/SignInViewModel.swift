//
//  SignInViewModel.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel: SignInViewModelType {
    var emailViewModel: EmailViewModelType!
    var passwordViewModel: PasswordViewModelType!
    var userService: UserServiceType!
    
    var errorMessage: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    var didPressSignIn: (() -> ())!
    var didPressSignUp: (() -> ())!
    
    var disposeBag = DisposeBag()
    
    init(emailViewModel: EmailViewModelType, passwordViewModel: PasswordViewModelType, userService: UserServiceType) {
        self.emailViewModel = emailViewModel
        self.passwordViewModel = passwordViewModel
        self.userService = userService
    }
    
    func validateCredetials() -> Bool {
        let isEmailValid = emailViewModel.validate()
        let isPasswordValid = passwordViewModel.validate()
        return isEmailValid && isPasswordValid
    }
    
    func logIn() {
        let email = emailViewModel.data.value
        let password = passwordViewModel.data.value
        userService.signIn(email: email, password: password).subscribe(onNext: {[unowned self] user in
            self.userService.user.accept(user)
        }, onError: {[unowned self] error in
            self.errorMessage.accept(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}

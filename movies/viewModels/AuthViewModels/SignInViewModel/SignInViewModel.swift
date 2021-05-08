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
    var errorMessage: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    var didPressSignIn: (() -> ())!
    var didPressSignUp: (() -> ())!
    
    var disposeBag = DisposeBag()
    
    init(emailViewModel: EmailViewModelType, passwordViewModel: PasswordViewModelType) {
        self.emailViewModel = emailViewModel
        self.passwordViewModel = passwordViewModel
    }
    
    func validateCredetials() -> Bool {
        let isEmailValid = emailViewModel.validate()
        let isPasswordValid = passwordViewModel.validate()
        return isEmailValid && isPasswordValid
    }
}

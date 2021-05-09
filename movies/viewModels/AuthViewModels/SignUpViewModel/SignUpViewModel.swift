//
//  SignUpViewModel.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 10.05.21.
//

import Foundation
import RxCocoa
import RxSwift

class SignUpViewModel: SignUpViewModelType {
    var emailViewModel: EmailViewModelType!
    var passwordViewModel: PasswordViewModelType!
    var confirmPasswordViewModel: PasswordViewModelType!
    var userService: UserServiceType!
    
    var didPressSignInLabel: (() -> ())?
    var didFinishSignUp: (() -> ())?
    
    var disposeBag = DisposeBag()
    
    var errorMessage: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    init(emailViewModel: EmailViewModelType, passwordViewModel: PasswordViewModelType, userService: UserServiceType, confirmPasswordViewModel: PasswordViewModelType) {
        self.emailViewModel = emailViewModel
        self.passwordViewModel = passwordViewModel
        self.userService = userService
        self.confirmPasswordViewModel = confirmPasswordViewModel
    }
    
    func validateCredetials() -> Bool {
        let isEmailValid = emailViewModel.validate()
        let isPasswordValid = passwordViewModel.validate()
        let isConfirmPasswordValid = confirmPasswordViewModel.validateToConfirm(confirmText: passwordViewModel.data.value)
        return isEmailValid && isPasswordValid && isConfirmPasswordValid
    }
    
    func register() -> () {
        let email = emailViewModel.data.value
        let password = passwordViewModel.data.value
        userService.signUp(email: email, password: password).subscribe(onNext: {[unowned self] user in
            self.userService.user.accept(user)
        }, onError: {[unowned self] error in
            self.errorMessage.accept(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}

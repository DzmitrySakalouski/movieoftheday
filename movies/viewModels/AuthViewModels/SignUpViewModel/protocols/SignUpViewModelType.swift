//
//  SignUpViewModelType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 10.05.21.
//

import Foundation
import RxCocoa

protocol SignUpViewModelType {
    var emailViewModel: EmailViewModelType! { get }
    var passwordViewModel: PasswordViewModelType! { get }
    var confirmPasswordViewModel: PasswordViewModelType! { get }
    var userService: UserServiceType! { get }
    var didPressSignInLabel: (() -> ())? { get set }
    var didFinishSignUp: (() -> ())? { get set }
    var errorMessage: BehaviorRelay<String?> { get }
    
    func validateCredetials() -> Bool
    func register() -> ()
}

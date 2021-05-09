//
//  SignInViewModelType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import Foundation
import RxCocoa

protocol SignInViewModelType {
    var passwordViewModel: PasswordViewModelType! { get set }
    var emailViewModel: EmailViewModelType! { get set }
    var didPressSignIn: (() -> ())! { get set }
    var didPressSignUp: (() -> ())! { get set }
    var errorMessage: BehaviorRelay<String?> { get }
    var userService: UserServiceType! { get }
    
    func validateCredetials() -> Bool
    func logIn() -> ()
}

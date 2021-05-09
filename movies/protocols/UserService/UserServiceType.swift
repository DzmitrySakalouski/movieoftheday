//
//  UserServiceType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 9.05.21.
//

import Foundation
import RxCocoa
import RxSwift
import Firebase

protocol UserServiceType {
    var user: BehaviorRelay<User?> { get }
    var authService: AuthServiceType! { get set }
    var errorMessage: BehaviorRelay<String?> { get set }
    func signIn(email: String, password: String) -> Observable<User?>
    func logOut() -> ()
    func signUp(email: String, password: String) -> Observable<User?>
}

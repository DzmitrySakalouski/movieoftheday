//
//  AuthServiceType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 9.05.21.
//

import Foundation
import Firebase
import RxSwift

protocol AuthServiceType {
    func configureAuthListener() -> Observable<Bool?>
    func signInWithEmail(email: String, password: String) -> Observable<User?>
    func signOut() -> Observable<Bool>
    func register(email: String, password: String) -> Observable<User?>
}

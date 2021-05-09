//
//  AuthService.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import Foundation
import RxCocoa
import RxSwift
import Firebase

class AuthService: AuthServiceType {
    func configureAuthListener() -> Observable<Bool?> {
        return Observable<Bool?>.create{ observer in
            Auth.auth().addStateDidChangeListener { (auth, user) in
                print(auth.currentUser, user)
                observer.onNext(user != nil)
            }
            return Disposables.create()
        }
    }
    
    func signInWithEmail(email: String, password: String) -> Observable<User?> {
        return Observable<User?>.create{ observer in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    observer.onError(error!)
                }
                
                let user = Auth.auth().currentUser
                observer.onNext(user)
            }
            return Disposables.create()
        }
    }
    
    func signOut() -> Observable<Bool> {
        return Observable<Bool>.create{observer in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                observer.onNext(true)
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}

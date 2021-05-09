//
//  PasswordViewModel.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import Foundation
import RxCocoa

class PasswordViewModel: PasswordViewModelType {
    var errorMessage: String = "Please enter valid password"
    
    var data: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    func validate() -> Bool {
        guard validateLength(text: data.value) else {
            errorValue.accept(errorMessage)
            return false
        }
        
        errorValue.accept(nil)
        return true
    }
    
    func validateToConfirm(confirmText: String) -> Bool {
        guard validateLength(text: data.value) else {
            errorValue.accept("Please enter confirm password")
            return false
        }
        
        guard confirmText == data.value else {
            errorValue.accept("Confirm password fail")
            return false
        }
        
        errorValue.accept(nil)
        return true
    }
    
    func validateLength(text: String) -> Bool {
        return text.count > 6
    }
}

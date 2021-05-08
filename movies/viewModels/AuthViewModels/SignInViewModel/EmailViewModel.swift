//
//  EmailViewModel.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import Foundation
import RxCocoa

class EmailViewModel: ValidationType, EmailViewModelType {
    var errorMessage: String = "Please enter valid email"
    
    var data: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    var errorValue: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    func validate() -> Bool {
        guard validatePattern(text: data.value) else {
            errorValue.accept(errorMessage)
            return false
        }
        
        errorValue.accept(nil)
        return true
    }
    
    func validatePattern(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
}

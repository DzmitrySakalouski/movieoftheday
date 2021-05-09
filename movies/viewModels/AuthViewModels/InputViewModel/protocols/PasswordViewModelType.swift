//
//  PasswordViewModelType.swift
//  movies
//
//  Created by Dzmitry  Sakalouski  on 8.05.21.
//

import Foundation

protocol PasswordViewModelType: ValidationType {
    func validateLength(text: String) -> Bool
    func validateToConfirm(confirmText: String) -> Bool
}
